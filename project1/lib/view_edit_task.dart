import 'package:flutter/material.dart';
import 'package:what_todo/part_datetime_picker.dart';

import 'model_task.dart';

class ViewEditTask extends StatefulWidget {
  final Function refreshParent;
  final Task task;

  const ViewEditTask({
    super.key,
    required this.task,
    required this.refreshParent,
  });

  @override
  State<StatefulWidget> createState() {
    return _ViewEditTaskState();
  }
}

class _ViewEditTaskState extends State<ViewEditTask> {
  final GlobalKey<FormState> _key = GlobalKey<FormState>();

  void updateTask() {
    if (_key.currentState!.validate()) {
      _key.currentState!.save();
      widget.refreshParent();
    }
  }

  DateTime? getDeadline() => widget.task.deadline;

  void setDeadline(DateTime? date) {
    setState(() {
      widget.task.deadline = date;
    });
  }

  @override
  Widget build(BuildContext context) {
    final navigator = Navigator.of(context);
    final Task task = widget.task;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Task'),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () => setState(() => task.priority = !task.priority),
            icon: Icon(
              Icons.star,
              color: (task.priority) ? Colors.yellow : null,
            ),
          ),
          IconButton(
              onPressed: () => navigator.pop('delete'),
              icon: const Icon(Icons.delete)),
        ],
      ),
      body: Container(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _key,
          child: Column(
            children: <Widget>[
              _FormSaveWrapper(
                onFocusChange: updateTask,
                child: TextFormField(
                  decoration: const InputDecoration(labelText: 'Task'),
                  initialValue: task.title,
                  validator: (value) => (value != null && value.isEmpty)
                      ? 'You have no task?'
                      : null,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  onSaved: (value) => task.title = value!,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16),
                child: Row(
                  children: [
                    PartDateTimePicker(getDeadline, setDeadline),
                    const SizedBox(width: 8),
                    Text(task.deadline?.toString() ?? ''),
                  ],
                ),
              ),
              _FormSaveWrapper(
                  onFocusChange: updateTask,
                  child: TextFormField(
                    decoration: const InputDecoration(labelText: 'Details'),
                    initialValue: task.details,
                    maxLines: null,
                    keyboardType: TextInputType.multiline,
                    onSaved: (value) => task.details = value,
                  ))
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => navigator.pop('done'),
        child: const Icon(Icons.check),
      ),
    );
  }
}

class _FormSaveWrapper extends StatelessWidget {
  final Function onFocusChange;
  final Widget child;

  const _FormSaveWrapper({required this.onFocusChange, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: FocusScope(
        onFocusChange: (value) {
          if (!value) onFocusChange();
        },
        child: child,
      ),
    );
  }
}
