import 'package:flutter/material.dart';

import 'view_home.dart';

void main() {
  runApp(const TaskApp());
}

class TaskApp extends StatelessWidget {
  const TaskApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Task',
      darkTheme: ThemeData.dark(),
      home: const HomePage(),
    );
  }
}
