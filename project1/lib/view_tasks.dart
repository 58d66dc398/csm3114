import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:what_todo/part_add_task.dart';
import 'package:what_todo/view_edit_task.dart';

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

  void deleteTask(int index) {
    setState(() {
      Task cache = tasks.removeAt(index);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Deleted Task'),
          action: SnackBarAction(
            label: 'Undo',
            onPressed: () => setState(() => tasks.insert(index, cache)),
          ),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Tasks'),
        centerTitle: true,
      ),
      // task list
      body: ListView.builder(
        itemCount: tasks.length,
        itemBuilder: (BuildContext context, int i) {
          return InkWell(
            // edit existing task
            onTap: () async {
              if (!tasks[i].done) {
                await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => ViewEditTask(
                      refreshParent: refresh,
                      task: tasks[i],
                    ),
                  ),
                ).then((value) {
                  if (value is String) {
                    if (value == 'done') {
                      setState(() {
                        tasks[i].done = true;
                      });
                      ScaffoldMessenger.of(context)
                        ..removeCurrentSnackBar()
                        ..showSnackBar(
                          const SnackBar(content: Text('Marked as done')),
                        );
                    } else if (value == 'delete') {
                      deleteTask(i);
                    }
                  }
                });
              }
            },
            child: Dismissible(
              key: UniqueKey(),
              confirmDismiss: (direction) async =>
                  direction == DismissDirection.endToStart,
              onDismissed: (direction) => deleteTask(i),
              background: Container(
                color: Colors.yellow,
                padding: const EdgeInsets.all(16),
                child: const Align(
                    alignment: Alignment.centerLeft,
                    child: Icon(Icons.star_border, size: 32)),
              ),
              secondaryBackground: Container(
                color: Colors.red,
                padding: const EdgeInsets.all(16),
                child: const Align(
                    alignment: Alignment.centerRight,
                    child: Icon(Icons.delete_outline, size: 32)),
              ),
              child: ListTile(
                tileColor: theme.colorScheme.background,
                enabled: !tasks[i].done,
                leading: Checkbox(
                  shape: const CircleBorder(),
                  value: tasks[i].done,
                  onChanged: (bool? value) =>
                      setState(() => tasks[i].done = value!),
                ),
                contentPadding:
                    const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                title: Text(tasks[i].title),
                subtitle: (tasks[i].deadline != null)
                    ? Text(df.format(tasks[i].deadline!.toLocal()))
                    : null,
              ),
            ),
          );
        },
      ),
      floatingActionButton: InkWell(
        child: FloatingActionButton(
          onPressed: () async {
            await showModalBottomSheet(
              isScrollControlled: true,
              context: context,
              builder: (context) => PartAddTask(refresh),
            ).then((task) {
              if (task is Task) {
                setState(() => tasks.add(task));
              }
            });
          },
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}
