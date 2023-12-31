import 'package:flutter/material.dart';
import 'package:lab_test/view_home.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flood Evacuation',
      darkTheme: ThemeData.from(colorScheme: const ColorScheme.dark()),
      home: const HomePage(),
    );
  }
}
