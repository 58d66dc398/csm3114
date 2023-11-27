import 'package:flutter/material.dart';

class Task1Part1 extends StatefulWidget {
  const Task1Part1({super.key});

  @override
  State<Task1Part1> createState() => _Task1Part1State();
}

class _Task1Part1State extends State<Task1Part1> {
  String _inputText = '';
  final myController = TextEditingController();

  void _showInputDialog() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Enter Text'),
            content: TextField(
                controller: myController,
                decoration: const InputDecoration(hintText: 'Enter Text')),
            actions: [
              TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: const Text('Cancel')),
              TextButton(
                  onPressed: () {
                    setState(() {
                      _inputText = myController.text;
                    });
                    Navigator.of(context).pop();
                  },
                  child: const Text('Save'))
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('Dialog Box')),
        body: Center(child: Text(_inputText)),
        // https://stackoverflow.com/questions/50839282/
        floatingActionButton: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  FloatingActionButton(
                      onPressed: _showInputDialog,
                      child: const Icon(Icons.edit)),
                  FloatingActionButton(
                      onPressed: () => setState(() => _inputText = ''),
                      child: const Icon(Icons.delete)),
                ])),
        floatingActionButtonLocation:
            FloatingActionButtonLocation.centerDocked);
  }
}
