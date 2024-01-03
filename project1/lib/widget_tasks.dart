import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:what_todo/utils.dart';
import 'package:what_todo/view_edit_task.dart';

import 'data.dart';
import 'model_task.dart';

class TasksView extends StatefulWidget {
  const TasksView({super.key});

  @override
  State<TasksView> createState() {
    return TasksViewState();
  }
}

class TasksViewState extends State<TasksView> {
  final List<Task> todos = Task.todos, done = Task.done, star = Task.star;
  final DateFormat df = DateFormat("yyyy/MM/dd HH:mm");

  void refresh() => setState(() {});

  void _snackRemove(void Function() onUndo) {
    ScaffoldMessengerState state = ScaffoldMessenger.of(context);
    String message = 'Deleted Task';
    state
      ..removeCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Text(message),
          action: SnackBarAction(label: 'Undo', onPressed: () async {
            setState(onUndo);
            await Data.save();
          }),
        ),
      );
  }

  Future<void> removeTodo(int index) async {
    Task cache = todos[index];
    bool wasStarred = cache.removeTodo();
    _snackRemove(() => cache.addTodo(wasStarred: wasStarred));
    setState(() {});
    await Data.save();
  }

  Future<void> removeDone(int index) async {
    Task cache = done[index];
    cache.removeDone();
    _snackRemove(() => cache.addDone());
    setState(() {});
    await Data.save();
  }

  Future<void> checkDone(Task task) async {
    ScaffoldMessengerState state = ScaffoldMessenger.of(context);
    setState(() => task.flipDone());
    await Data.save();
    if (context.mounted) {
      bool isDone = done.contains(task);
      String message = (isDone) ? 'Marked as done' : 'Marked undone';
      snack(state, message);
    }
  }

  @override
  Widget build(BuildContext context) {
    ScaffoldMessengerState state = ScaffoldMessenger.of(context);

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
                  ).then((value) async {
                    if (value == 'done') {
                      await checkDone(todos[i]);
                    } else if (value == 'delete') {
                      await removeTodo(i);
                    }
                    setState(() {});
                  });
                },
                child: Dismissible(
                  key: UniqueKey(),
                  confirmDismiss: (direction) async {
                    if (direction == DismissDirection.startToEnd) {
                      todos[i].flipStar();
                      await Data.save();
                      String message = (todos[i].starred)
                          ? 'Starred as important'
                          : 'Removed from starred';
                      snack(state, message);
                    }
                    return direction == DismissDirection.endToStart;
                  },
                  onDismissed: (direction) async {
                    await removeTodo(i);
                    setState(() {});
                  },
                  background: Container(
                    color: Colors.yellow,
                    padding: const EdgeInsets.all(16),
                    child: const Align(
                      alignment: Alignment.centerLeft,
                      child: Icon(Icons.star_border_rounded, size: 32),
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
                      onChanged: (bool? value) async {
                        await checkDone(todos[i]);
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
                      onDismissed: (direction) async {
                        await removeDone(i);
                        setState(() {});
                      },
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
                          onChanged: (bool? value) async {
                            await checkDone(done[i]);
                          },
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                          vertical: 8,
                          horizontal: 16,
                        ),
                        title: Text(done[i].title),
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
