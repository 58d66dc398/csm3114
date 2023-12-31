import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:what_todo/view_edit_task.dart';

import 'model_task.dart';

class TasksView extends StatefulWidget {
  const TasksView({super.key});

  @override
  State<TasksView> createState() {
    return TasksViewState();
  }
}

class TasksViewState extends State<TasksView> {
  final DateFormat df = DateFormat("yyyy/MM/dd HH:mm");

  List<Task> todos = Task.todos, done = Task.done, star = Task.star;

  void refresh() => setState(() {});

  void removeTodo(int index) {
    setState(() {
      Task cache = todos.removeAt(index);
      bool wasStarred = star.contains(cache);
      int starredIndex = 0;
      if (wasStarred) {
        starredIndex = star.indexOf(cache);
        star.remove(cache);
      }
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Deleted Task'),
          action: SnackBarAction(
            label: 'Undo',
            onPressed: () => setState(() {
              todos.insert(index, cache);
              if (wasStarred) {
                star.insert(starredIndex, cache);
              }
            }),
          ),
        ),
      );
    });
  }

  void removeDone(int index) {
    setState(() {
      Task cache = done.removeAt(index);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Deleted Task'),
          action: SnackBarAction(
            label: 'Undo',
            onPressed: () => setState(() => done.insert(index, cache)),
          ),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          ListView.builder(
            physics: const ClampingScrollPhysics(),
            shrinkWrap: true,
            itemCount: todos.length,
            itemBuilder: (BuildContext context, int i) {
              return InkWell(
                // edit existing task
                onTap: () async {
                  await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => EditTaskPage(
                        refreshParent: refresh,
                        task: todos[i],
                      ),
                    ),
                  ).then((value) {
                    if (value == 'done') {
                      Task cache = todos.removeAt(i);
                      if (star.contains(cache)) {
                        star.remove(cache);
                      }
                      done.add(cache);
                      ScaffoldMessenger.of(context)
                        ..removeCurrentSnackBar()
                        ..showSnackBar(
                          const SnackBar(
                            content: Text('Marked as done'),
                          ),
                        );
                    } else if (value == 'delete') {
                      removeTodo(i);
                      return;
                    }
                    setState(() {});
                  });
                },
                child: Dismissible(
                  key: UniqueKey(),
                  confirmDismiss: (direction) async {
                    if (direction == DismissDirection.startToEnd) {
                      bool starred = Task.toggleStar(todos[i]);
                      String message = (starred)
                          ? 'Starred as important'
                          : 'Removed from starred';
                      ScaffoldMessenger.of(context)
                        ..removeCurrentSnackBar()
                        ..showSnackBar(SnackBar(content: Text(message)));
                    }
                    return direction == DismissDirection.endToStart;
                  },
                  onDismissed: (direction) => setState(() => removeTodo(i)),
                  background: Container(
                    color: Colors.yellow,
                    padding: const EdgeInsets.all(16),
                    child: const Align(
                      alignment: Alignment.centerLeft,
                      child: Icon(Icons.star_border, size: 32),
                    ),
                  ),
                  secondaryBackground: Container(
                    color: Colors.red,
                    padding: const EdgeInsets.all(16),
                    child: const Align(
                        alignment: Alignment.centerRight,
                        child: Icon(Icons.delete_outline, size: 32)),
                  ),
                  child: ListTile(
                    leading: Checkbox(
                      shape: const CircleBorder(),
                      value: false,
                      onChanged: (bool? value) {
                        setState(() {
                          Task cache = todos.removeAt(i);
                          if (star.contains(cache)) {
                            star.remove(cache);
                          }
                          done.add(cache);
                          Task.sortAll();
                        });
                      },
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                      vertical: 8,
                      horizontal: 16,
                    ),
                    title: Text(todos[i].title),
                    subtitle: (todos[i].deadline != null)
                        ? Text(df.format(todos[i].deadline!.toLocal()))
                        : null,
                  ),
                ),
              );
            },
          ),
          // done list
          Visibility(
            visible: done.isNotEmpty,
            child: ExpansionTile(
              shape: const Border(),
              tilePadding: const EdgeInsets.symmetric(horizontal: 32),
              title: const Text('Completed Task'),
              children: <Widget>[
                ListView.builder(
                  physics: const ClampingScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: done.length,
                  itemBuilder: (context, i) {
                    return Dismissible(
                      key: UniqueKey(),
                      direction: DismissDirection.endToStart,
                      onDismissed: (direction) => setState(() => removeDone(i)),
                      background: Container(
                        color: Colors.red,
                        padding: const EdgeInsets.all(16),
                        child: const Align(
                            alignment: Alignment.centerRight,
                            child: Icon(Icons.delete_outline, size: 32)),
                      ),
                      child: ListTile(
                        enabled: false,
                        leading: Checkbox(
                          shape: const CircleBorder(),
                          value: true,
                          onChanged: (bool? value) {
                            setState(() {
                              todos.add(done.removeAt(i));
                              Task.sortAll();
                            });
                          },
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 8, horizontal: 16),
                        title: Text(done[i].title),
                        // subtitle: (done[i].deadline != null)
                        //     ? Text(df.format(done[i].deadline!.toLocal()))
                        //     : null,
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
