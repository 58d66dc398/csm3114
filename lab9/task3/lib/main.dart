import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  final String title = 'Lab 9 - Focus Field';

  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: title,
      theme: ThemeData(
        fontFamily: 'Roboto',
      ),
      home: MyMainUI(title: title),
    );
  }
}

class MyMainUI extends StatefulWidget {
  final String title;

  const MyMainUI({super.key, required this.title});

  @override
  State<MyMainUI> createState() => _MyMainUIState();
}

class _MyMainUIState extends State<MyMainUI> {
  // final _key = GlobalKey<FormFieldState>();
  final _key = GlobalKey<FormState>();
  late FocusNode currentFocus;

  // late TextEditingController myController;
  late TextEditingController firstController, secondController;
  String thirdInput = '';

  @override
  void initState() {
    super.initState();
    currentFocus = FocusNode();
    // myController = TextEditingController();
    firstController = TextEditingController();
    secondController = TextEditingController();
  }

  @override
  void dispose() {
    currentFocus.dispose();
    firstController.dispose();
    secondController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _key,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const SizedBox(height: 64),
              TextFormField(
                // key: _key,
                controller: firstController,
                // onChanged: (value) => // it is abusing my CPU
                //     print('# Debug : first field value update $value'),
                decoration: const InputDecoration(
                  // hintText: 'auto focus is set',
                  // labelText: 'Number',
                  // hintText: 'Student Number',
                  // labelText: 'Plate Number',
                  // hintText: 'Car Plate Number',
                  labelText: 'Customer ID',
                  hintText: 'ID Number',
                  prefixIcon: Icon(Icons.key),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(width: 2, color: Colors.red),
                  ),
                ),
                autofocus: true,
                focusNode: currentFocus,
                keyboardType: TextInputType.number,
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.digitsOnly
                ],
                validator: (value) {
                  String? error;
                  if (value == null) {
                    error = 'user id is null';
                  } else if (int.tryParse(value) == null) {
                    error = 'user id is not number';
                  } else if (int.tryParse(value)! <= 0) {
                    error = 'user id is not valid';
                  }
                  print('# Debug : main.dart -> $error');
                  return error;
                },
              ),
              const SizedBox(height: 8),
              TextFormField(
                // controller: myController,
                controller: secondController,
                decoration: const InputDecoration(
                  // hintText: 'current focus is trigger',
                  labelText: 'Customer Name',
                  hintText: 'Full Name',
                  prefixIcon: Icon(Icons.person),
                  // labelText: 'Model',
                  // hintText: 'Car Model',
                  // prefixIcon: Icon(Icons.directions_car),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(width: 2, color: Colors.green),
                  ),
                ),
                maxLength: 64,
                validator: (value) {
                  String? error;
                  if (value == null) {
                    error = 'first input is null';
                  }
                  print('# Debug : main.dart -> $error');
                  return error;
                },
              ),
              TextFormField(
                // decoration: InputDecoration(hintText: 'data 3'),
                decoration: const InputDecoration(
                  labelText: 'Credit Number',
                  hintText: 'Credit Number',
                  prefixIcon: Icon(Icons.onetwothree),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(width: 2, color: Colors.blue),
                  ),
                ),
                keyboardType: TextInputType.number,
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.digitsOnly
                ],
                maxLength: 12,
                validator: (value) {
                  String? error;
                  if (value == null) {
                    error = 'credit number is null';
                  } else if (int.tryParse(value) == null) {
                    error = 'credit number is not number';
                  } else if (int.tryParse(value)! <= 0) {
                    error = 'credit number is not valid';
                  }
                  print('# Debug : main.dart -> $error');
                  return error;
                },
                onSaved: (value) {
                  thirdInput = value!;
                },
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (_key.currentState!.validate()) {
            _key.currentState!.save();
            showDialog(
              context: context,
              builder: (context) => AlertDialog(
                // title: const Text('Car Info'),
                title: const Text('Student Info'),
                content: SingleChildScrollView(
                  child: ListBody(
                    children: [
                      // Text('Car Plate Number: ${firstController.text}'),
                      // Text('Car Model: ${secondController.text}'),
                      // Text('Student Number: ${firstController.text}'),
                      // Text('Name: ${secondController.text}'),
                      Text('User ID: ${firstController.text}'),
                      Text('User Name: ${secondController.text}'),
                      Text('Credit Number: $thirdInput'),
                    ],
                  ),
                ),
                actions: [
                  TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                        firstController.text = '';
                        secondController.text = '';
                        currentFocus.requestFocus();
                      },
                      child: const Text('Close')),
                ],
              ),
            );
          }
        },
        tooltip: 'click to send form',
        child: const Icon(Icons.send),
      ),
    );
  }
}
