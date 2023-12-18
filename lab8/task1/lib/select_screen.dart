import 'package:flutter/material.dart';

class SelectionScreen extends StatelessWidget {
  final GlobalKey<FormState> _globalKey = GlobalKey<FormState>();
  String num = '', name = '';

  SelectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Select'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _globalKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              TextFormField(
                decoration: const InputDecoration(
                    labelText: 'Number', hintText: 'Student Number'),
                onSaved: (value) {
                  num = value ?? '';
                },
              ),
              TextFormField(
                decoration: const InputDecoration(
                    labelText: 'Name', hintText: 'Student Name'),
                onSaved: (value) {
                  name = value ?? '';
                },
              ),
              ElevatedButton(
                  onPressed: () {
                    _globalKey.currentState!.save();
                    return Navigator.pop(context, {'name': name, 'num': num});
                  },
                  child: const Text('Submit')),
            ],
          ),
        ),
      ),
    );
  }
}
