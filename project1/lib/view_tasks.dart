import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:what_todo/part_add_task.dart';

import 'model_task.dart';

class ViewTasks extends StatefulWidget {
  const ViewTasks({super.key});

  @override
  State<StatefulWidget> createState() {
    return _ViewTasksState();
  }
}

class _ViewTasksState extends State<ViewTasks> {
  final DateFormat df = DateFormat("yyyy/MM/dd HH:mm");

  // List<Task> tasks = [];
  List<Task> tasks = [
    Task(created: DateTime.now(), title: 'Test'),
    Task(created: DateTime.now(), deadline: DateTime.now(), title: 'Test'),
    Task(created: DateTime.now(), title: 'Test'),
  ];

  void refresh() => setState(() {});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tasks'),
        centerTitle: true,
      ),
      body: ListView.builder(
        itemCount: tasks.length,
        itemBuilder: (BuildContext context, int i) {
          return InkWell(
            onTap: () {},
            child: ListTile(
              enabled: !tasks[i].done,
              leading: Checkbox(
                value: tasks[i].done,
                onChanged: (bool? value) {
                  setState(() {
                    tasks[i].done = value ?? false;
                  });
                },
              ),
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
              title: Text(tasks[i].title),
              subtitle: (tasks[i].deadline != null)
                  ? Text(df.format(tasks[i].deadline!.toLocal()))
                  : null,
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await showModalBottomSheet(
            isScrollControlled: true,
            context: context,
            builder: (context) => PartAddTask(),
          ).then((task) => setState(() => tasks.add(task)));
        },
        child: const Icon(Icons.add),
      ),
      // bottomNavigationBar: BottomNavigationBar(
      //   items: [],
      // ),
    );
  }
}
