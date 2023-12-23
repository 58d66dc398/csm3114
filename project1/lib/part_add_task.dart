import 'dart:math';

import 'package:flutter/material.dart';
import 'package:what_todo/part_datetime_picker.dart';
import 'package:what_todo/view_edit_task.dart';

import 'model_task.dart';

class PartAddTask extends StatefulWidget {
  const PartAddTask(this.refreshParent, {super.key});

  final Function refreshParent;

  @override
  State<StatefulWidget> createState() {
    return _PartAddTaskState();
  }
}

class _PartAddTaskState extends State<PartAddTask> {
  final GlobalKey<FormFieldState> _key = GlobalKey();

  String title = '';
  DateTime? deadline;

  DateTime? getDeadline() => deadline;

  void setDeadline(DateTime? dateTime) {
    deadline = dateTime;
  }

  Task createTask() {
    return Task(
      title: title,
      deadline: deadline,
    );
  }

  @override
  Widget build(BuildContext context) {
    final NavigatorState navigator = Navigator.of(context);
    final MediaQueryData mediaQuery = MediaQuery.of(context);
    final double keyboardPadding = max(mediaQuery.viewInsets.bottom - 24, 0);

    return Container(
      padding: EdgeInsets.only(bottom: keyboardPadding),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: TextFormField(
                decoration: const InputDecoration(labelText: 'Task'),
                autofocus: true,
                key: _key,
                validator: (value) => (value != null && value.isEmpty)
                    ? 'You have no task?'
                    : null,
                onSaved: (value) => title = value!,
              ),
            ),
            const SizedBox(height: 8),
            Row(
              children: <Widget>[
                PartDateTimePicker(getDeadline, setDeadline),
                IconButton(
                  onPressed: () {
                    if (_key.currentState!.validate()) {
                      _key.currentState!.save();
                      Task task = createTask();
                      navigator.pop(task);
                      navigator.push(
                        MaterialPageRoute(
                          builder: (_) => ViewEditTask(
                            refreshParent: widget.refreshParent,
                            task: task,
                          ),
                        ),
                      );
                    }
                  },
                  icon: const Icon(Icons.notes),
                ),
                const Spacer(),
                TextButton(
                  onPressed: () {
                    if (_key.currentState!.validate()) {
                      _key.currentState!.save();
                      return navigator.pop(createTask());
                    }
                  },
                  child: const Text('Add'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
