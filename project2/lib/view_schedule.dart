import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:haulier/view_location.dart';

import 'data.dart';

class SchedulePage extends StatefulWidget {
  final Map<String, dynamic>? editSchedule;

  const SchedulePage({super.key, this.editSchedule});

  @override
  State<StatefulWidget> createState() => _SchedulePageState();
}

class _SchedulePageState extends State<SchedulePage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  Map<String, dynamic> _body = {
    'user': Data.getCurrentUser()['id'],
    'truck': Data.trucks[0]['id'],
    'status': 'scheduled',
    'details': '',
    'dateStart': '',
    'dateEnd': '',
    'posStart': {'coordinates': <double>[]},
    'posEnd': {'coordinates': <double>[]},
  };
  Map<String, dynamic> _response = {};
  String details = '',
      posStart = 'Start',
      posEnd = 'Destination',
      dateStart = 'Start Date',
      dateEnd = 'End Date';
  Future<String>? status;

  String? getErrorMessage(String key) {
    String? message;
    if (_response.containsKey('data')) {
      Map<String, dynamic> data = _response['data'];
      message = (data.containsKey(key)) ? data[key]!['message'] : null;
    }
    return message;
  }

  Future<String> getPosName(String key) async {
    List<dynamic> pos = _body[key]['coordinates'];
    List<Placemark> places = await placemarkFromCoordinates(
      pos[1] as double,
      pos[0] as double,
    );
    Map<String, dynamic> place = places[0].toJson();
    return place.toString();
  }

  String getDate(String key) {
    return ((_body[key] as String).isEmpty) ? 'Start Date' : _body[key];
  }

  Future<void> checkBody() async {
    if (widget.editSchedule == null) return;
    _body = Map.from(widget.editSchedule!);
    details = _body['details'];
    posStart = await getPosName('posStart');
    posEnd = await getPosName('posEnd');
    dateStart = getDate('dateStart');
    dateEnd = getDate('dateEnd');
    print(_body);
    setState(() {});
  }

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      checkBody();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    bool add = widget.editSchedule == null;

    return Scaffold(
      appBar: AppBar(
        title: Text((add) ? 'Add Schedule' : 'Schedule Info'),
        actions: [
          if (!add)
            IconButton(
              onPressed: () async {
                await Data.deleteSchedule(widget.editSchedule!['id']);
                if (context.mounted) {
                  Navigator.pop(context);
                }
              },
              icon: const Icon(Icons.delete),
            ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              DropdownButton<String>(
                value: _body['truck'],
                icon: const Icon(Icons.arrow_downward),
                elevation: 16,
                style: const TextStyle(color: Colors.deepPurple),
                underline: Container(
                  height: 2,
                  color: Colors.deepPurpleAccent,
                ),
                onChanged: (String? value) {
                  setState(() => _body['truck'] = value!);
                },
                items: Data.trucks.map<DropdownMenuItem<String>>((e) {
                  return DropdownMenuItem<String>(
                    value: e['id'],
                    child: Text(e['plate']),
                  );
                }).toList(),
              ),
              TextFormField(
                key: Key('start@$details'),
                decoration: const InputDecoration(labelText: 'Details'),
                maxLines: null,
                keyboardType: TextInputType.multiline,
                initialValue: details,
                onSaved: (value) => _body['details'] = value!,
              ),
              TextFormField(
                key: Key('start@$dateStart'),
                maxLines: null,
                keyboardType: TextInputType.multiline,
                initialValue: dateStart,
                readOnly: true,
                onTap: () async {
                  DateTime? picked = DateTime.tryParse(_body['dateStart']);
                  final DateTime now = DateTime.now();

                  DateTime? dateTime = await showDatePicker(
                    context: context,
                    initialDate: picked ?? now,
                    firstDate: picked ?? now,
                    lastDate: now.copyWith(year: now.year + 1),
                  );
                  if (dateTime != null && context.mounted) {
                    TimeOfDay now = (picked != null)
                        ? TimeOfDay.fromDateTime(picked)
                        : TimeOfDay.now();
                    TimeOfDay? time = await showTimePicker(
                      context: context,
                      initialTime: now,
                    );
                    if (time != null) {
                      dateTime = dateTime.add(
                        Duration(
                          hours: time.hour,
                          minutes: time.minute,
                        ),
                      );
                    }
                  }
                  setState(() {
                    if (dateTime != null) {
                      _body['dateStart'] = dateTime.toString();
                      dateStart = dateTime.toString();
                    } else {
                      _body['dateStart'] = '';
                      dateStart = 'Start Date';
                    }
                  });
                },
                validator: (value) {
                  String? error;
                  if (value == 'Start Date') {
                    error = 'No Date?';
                  } else {
                    error = getErrorMessage('dateStart');
                  }
                  return error;
                },
              ),
              TextFormField(
                key: Key('end@$dateEnd'),
                maxLines: null,
                keyboardType: TextInputType.multiline,
                initialValue: dateEnd,
                readOnly: true,
                onTap: () async {
                  DateTime? picked = DateTime.tryParse(_body['dateEnd']);
                  final DateTime now = DateTime.now();

                  DateTime? dateTime = await showDatePicker(
                    context: context,
                    initialDate: picked ?? now,
                    firstDate: now,
                    lastDate: now.copyWith(year: now.year + 1),
                  );
                  if (dateTime != null && context.mounted) {
                    TimeOfDay now = (picked != null)
                        ? TimeOfDay.fromDateTime(picked)
                        : TimeOfDay.now();
                    TimeOfDay? time = await showTimePicker(
                      context: context,
                      initialTime: now,
                    );
                    if (time != null) {
                      dateTime = dateTime.add(
                        Duration(
                          hours: time.hour,
                          minutes: time.minute,
                        ),
                      );
                    }
                  }
                  setState(() {
                    _body['dateEnd'] =
                        (dateTime != null) ? dateTime.toString() : '';
                  });
                },
                validator: (value) {
                  String? error;
                  if (value == 'End Date') {
                    error = 'No Date?';
                  } else {
                    error = getErrorMessage('dateEnd');
                  }
                  return error;
                },
              ),
              // https://stackoverflow.com/questions/45900387
              TextFormField(
                key: Key(posStart),
                maxLines: null,
                keyboardType: TextInputType.multiline,
                initialValue: posStart,
                readOnly: true,
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => LocationPickerPage(
                      coordinates: _body['posStart'],
                    ),
                  ),
                ).then((value) async {
                  if (value != null) {
                    _body['posStart'] = value;
                    posStart = await getPosName('posStart');
                    setState(() {});
                  }
                }),
                validator: (value) {
                  String? error;
                  if (value == 'Start') {
                    error = 'No location?';
                  } else {
                    error = getErrorMessage('posStart');
                  }
                  return error;
                },
              ),
              TextFormField(
                key: Key(posEnd),
                maxLines: null,
                keyboardType: TextInputType.multiline,
                initialValue: posEnd,
                readOnly: true,
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => LocationPickerPage(
                      coordinates: _body['posEnd'],
                    ),
                  ),
                ).then((value) async {
                  if (value != null) {
                    _body['posEnd'] = value;
                    posEnd = await getPosName('posEnd');
                    setState(() {});
                  }
                }),
                validator: (value) {
                  String? error;
                  if (value == 'Destination') {
                    error = 'No location?';
                  } else {
                    error = getErrorMessage('posEnd');
                  }
                  return error;
                },
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async {
          _formKey.currentState!.save();
          _response = (add)
              ? await Data.addSchedule(_body)
              : await Data.updateSchedule(widget.editSchedule!['id'], _body);
          if (_formKey.currentState!.validate()) {
            _formKey.currentState!.reset();
            if (context.mounted) {
              Navigator.pop(context);
            }
          }
        },
        label: Text((add) ? 'Add' : 'Update'),
        icon: const Icon(Icons.check),
      ),
    );
  }
}
