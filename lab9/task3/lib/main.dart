import 'package:flutter/material.dart';

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
  final _key = GlobalKey<FormFieldState>();
  late FocusNode currentFocus;

  // late TextEditingController myController;
  late TextEditingController firstController, secondController;

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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const SizedBox(height: 64),
            TextFormField(
              key: _key,
              controller: firstController,
              // onChanged: (value) => // it is abusing my CPU
              //     print('# Debug : first field value update $value'),
              decoration: const InputDecoration(
                // hintText: 'auto focus is set',
                  labelText: 'Number',
                  hintText: 'Student Number',
                  // labelText: 'Plate Number',
                  // hintText: 'Car Plate Number',
                  prefixIcon: Icon(Icons.onetwothree),
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(width: 2, color: Colors.blue))),
              autofocus: true,
              focusNode: currentFocus,
              validator: (value) {
                String? error;
                if (value == null) {
                  error = 'first input is null';
                } else if (value.contains(' ')) {
                  error = 'no space in student number';
                }
                print('# Debug : main.dart -> $error');
                return error;
              },
            ),
            const SizedBox(height: 8),
            TextField(
              // controller: myController,
              controller: secondController,
              decoration: const InputDecoration(
                // hintText: 'current focus is trigger',
                  labelText: 'Name',
                  hintText: 'Full Name',
                  prefixIcon: Icon(Icons.person),
                  // labelText: 'Model',
                  // hintText: 'Car Model',
                  // prefixIcon: Icon(Icons.directions_car),
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(width: 2, color: Colors.blue))),
            ),
            // const TextField(
            //   decoration: InputDecoration(hintText: 'data 3'),
            // ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (_key.currentState!.validate()) {
            showDialog(
              context: context,
              builder: (context) =>
                  AlertDialog(
                    // title: const Text('Car Info'),
                    title: const Text('Student Info'),
                    content: SingleChildScrollView(
                      child: ListBody(
                        children: [
                          // Text('Car Plate Number: ${firstController.text}'),
                          // Text('Car Model: ${secondController.text}'),
                          Text('Student Number: ${firstController.text}'),
                          Text('Name: ${secondController.text}'),
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
