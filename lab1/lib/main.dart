import 'package:flutter/material.dart';

void main() {
  // var yourName = 'Someone';

  // runApp(Center(
  //     child: Text('Welcome to my Flutter app, $yourName',
  //         textDirection: TextDirection.ltr,
  //         style: const TextStyle(color: Colors.orangeAccent, fontSize: 24, fontStyle: FontStyle.italic))));

  runApp(MaterialApp(
    theme: ThemeData(
        brightness: Brightness.dark, primaryColor: Colors.blueAccent),
    home: Scaffold(
      appBar: AppBar(title: const Text('Flutter App Development')),
      body: const Center(
          child: Text('Welcome to Flutter App Development')),
      floatingActionButton: const FloatingActionButton(onPressed: null))));
}
