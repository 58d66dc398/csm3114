import 'dart:math';

import 'package:flutter/material.dart';

import 'model_task.dart';

class PartAddTask extends StatefulWidget {
  const PartAddTask({super.key});

  @override
  State<StatefulWidget> createState() {
    return _PartAddTaskState();
  }
}

class _PartAddTaskState extends State<PartAddTask> {
  final GlobalKey<FormFieldState> _key = GlobalKey();

  String title = '';
  DateTime? pickedDate;
  TimeOfDay? pickedTime;

  DateTime? getDateTime() {
    if (pickedDate != null || pickedTime != null) {
      DateTime date = pickedDate ?? DateTime.now();
      TimeOfDay time = pickedTime ?? const TimeOfDay(hour: 0, minute: 0);
      return DateTime(date.year, date.month, date.day, time.hour, time.minute);
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    final MediaQueryData mediaQuery = MediaQuery.of(context);
    final double keyboardPadding = max(mediaQuery.viewInsets.bottom - 24, 0);

    return Container(
      padding: EdgeInsets.only(bottom: keyboardPadding),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            const Text('New Task'),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: TextFormField(
                decoration: const InputDecoration(labelText: 'Task'),
                autofocus: true,
                key: _key,
                validator: (value) => (value != null && value.isEmpty)
                    ? 'You have no task?'
                    : null,
                onSaved: (value) => title = value!,
              ),
            ),
            const SizedBox(height: 8),
            Row(
              children: <Widget>[
                IconButton(
                  onPressed: () {
                    final DateTime now = DateTime.now();
                    showDatePicker(
                      context: context,
                      initialDate: pickedDate ?? now,
                      firstDate: now,
                      lastDate: now.copyWith(year: now.year + 1),
                    ).then((date) => setState(() => pickedDate = date));
                  },
                  icon: Icon(
                    Icons.calendar_month,
                    color: (pickedDate != null) ? Colors.blue : null,
                  ),
                ),
                IconButton(
                  onPressed: () => showTimePicker(
                    context: context,
                    initialTime: TimeOfDay.now(),
                  ).then((time) => setState(() => pickedTime = time)),
                  icon: Icon(
                    Icons.access_time,
                    color: (pickedTime != null) ? Colors.green : null,
                  ),
                ),
                const Spacer(),
                TextButton(
                  onPressed: () {
                    if (_key.currentState!.validate()) {
                      _key.currentState!.save();
                      Task newTask = Task(
                        created: DateTime.now(),
                        title: title,
                        deadline: getDateTime(),
                      );
                      return Navigator.pop(context, newTask);
                    }
                  },
                  child: const Text('Add'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
