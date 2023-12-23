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

  List<Task> todos = Task.todos, done = Task.done;

  void refresh() => setState(() {});

  void deleteTask(int index) {
    setState(() {
      Task cache = todos.removeAt(index);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Deleted Task'),
          action: SnackBarAction(
            label: 'Undo',
            onPressed: () => setState(() => todos.insert(index, cache)),
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
      body: SingleChildScrollView(
        child: Column(
          children: [
            ListView.builder(
              shrinkWrap: true,
              itemCount: todos.length,
              itemBuilder: (BuildContext context, int i) {
                return InkWell(
                  // edit existing task
                  onTap: () async {
                    await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => ViewEditTask(
                          refreshParent: refresh,
                          task: todos[i],
                        ),
                      ),
                    ).then((value) {
                      if (value == 'done') {
                        setState(() {
                          done.add(todos.removeAt(i));
                        });
                        ScaffoldMessenger.of(context)
                          ..removeCurrentSnackBar()
                          ..showSnackBar(
                            const SnackBar(content: Text('Marked as done')),
                          );
                      } else if (value == 'delete') {
                        deleteTask(i);
                      }
                    });
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
                      // enabled: !todos[i].done, // TODO: double list
                      leading: Checkbox(
                        shape: const CircleBorder(),
                        value: false, // TODO: double list
                        onChanged: (bool? value) {
                          setState(() => done.add(todos.removeAt(i)));
                        },
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 8, horizontal: 16),
                      title: Text(todos[i].title),
                      subtitle: (todos[i].deadline != null)
                          ? Text(df.format(todos[i].deadline!.toLocal()))
                          : null,
                    ),
                  ),
                );
              },
            ),
            ExpansionTile(
              shape: const Border(),
              tilePadding: const EdgeInsets.symmetric(horizontal: 32),
              title: const Text('Completed Task'),
              children: <Widget>[
                ListView.builder(
                  shrinkWrap: true,
                  itemCount: done.length,
                  itemBuilder: (context, i) {
                    return ListTile(
                      tileColor: theme.colorScheme.background,
                      enabled: false,
                      leading: Checkbox(
                        shape: const CircleBorder(),
                        value: true,
                        onChanged: (bool? value) {
                          setState(() => todos.add(done.removeAt(i)));
                        },
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 8, horizontal: 16),
                      title: Text(done[i].title),
                      subtitle: (done[i].deadline != null)
                          ? Text(df.format(done[i].deadline!.toLocal()))
                          : null,
                    );
                  },
                ),
              ],
            ),
          ],
        ),
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
                setState(() => todos.add(task));
              }
            });
          },
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}
