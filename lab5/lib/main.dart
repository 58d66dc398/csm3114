import 'package:flutter/material.dart';
import 'package:lab5/task1/part1.dart';
import 'package:lab5/task1/part2.dart';
import 'package:lab5/task2/part1.dart';
import 'package:lab5/task2/part2.dart';
import 'package:lab5/task2/part3.dart';
import 'package:lab5/task3.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // IDE is being noisy
  final String title = 'Lab 5';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: title,
      home: const Task3(),
    );
  }
}
