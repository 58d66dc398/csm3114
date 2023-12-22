import 'package:flutter/material.dart';

import 'view_tasks.dart';

void main() {
  runApp(const TaskApp());
}

class TaskApp extends StatelessWidget {
  const TaskApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Task',
      theme: ThemeData(),
      darkTheme: ThemeData(brightness: Brightness.dark),
      home: const ViewTasks(),
    );
  }
}
