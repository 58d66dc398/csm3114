import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Lab 9',
      home: MyMainUI(),
    );
  }
}

class MyMainUI extends StatefulWidget {
  const MyMainUI({super.key});

  @override
  State<StatefulWidget> createState() => _MyMainUIState();
}

class _MyMainUIState extends State<MyMainUI> {
  final TextEditingController number = TextEditingController(),
      name = TextEditingController();
  final global = GlobalKey<FormFieldState>();

  @override
  void initState() {
    number.text = '';
    name.text = '';
    super.initState();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: const Text('Lab 9'),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: <Widget>[
              const SizedBox(height: 16),
              TextField(
                controller: number,
                decoration: const InputDecoration(
                  labelText: 'Number',
                  hintText: 'Enter your id number',
                  prefixIcon: Icon(
                    Icons.person,
                    size: 24,
                  ),
                  hintStyle:
                      TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  labelStyle: TextStyle(fontSize: 16, color: Colors.blueAccent),
                ),
              ),
              const SizedBox(height: 8),
              TextField(
                controller: name,
                decoration: InputDecoration(
                    labelText: 'Name',
                    hintText: 'Enter your full name',
                    prefixIcon: const Icon(
                      Icons.abc,
                      size: 24,
                    ),
                    hintStyle: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.bold),
                    labelStyle:
                        const TextStyle(fontSize: 16, color: Colors.blueAccent),
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16))),
              ),
              const SizedBox(height: 8),
              TextFormField(
                key: global,
                autovalidateMode: AutovalidateMode.always,
                decoration: const InputDecoration(
                  labelText: 'Course',
                  hintText: 'Enter your course code',
                  prefixIcon: Icon(
                    Icons.school,
                    size: 24,
                  ),
                ),
                onSaved: (String? data) => print('# debug : submitted "$data"'),
                validator: (String? data) => data!.contains(' ')
                    ? "combination of alphabetical and numerical characters only"
                    : null,
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  // if (global.currentState!.validate()) {
                  global.currentState!.save();
                  // }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blueGrey,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16)),
                  minimumSize: const Size(256, 64),
                ),
                child: const Text('Submit'),
              ),
            ],
          ),
        ),
      );
}
