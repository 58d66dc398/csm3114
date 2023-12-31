import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:what_todo/widget_set_datetime.dart';

import 'model_task.dart';

class EditTaskPage extends StatefulWidget {
  final Function refreshParent;
  final Task task;

  const EditTaskPage({
    super.key,
    required this.task,
    required this.refreshParent,
  });

  @override
  State<StatefulWidget> createState() {
    return _EditTaskPageState();
  }
}

class _EditTaskPageState extends State<EditTaskPage> {
  final DateFormat df = DateFormat("yyyy/MM/dd HH:mm");
  final GlobalKey<FormState> _key = GlobalKey<FormState>();
  List<Widget> partDeadline = <Widget>[];

  void updateTask() {
    if (_key.currentState!.validate()) {
      _key.currentState!.save();
      Task.sortAll();
      widget.refreshParent();
    }
  }

  DateTime? getDeadline() => widget.task.deadline;

  void setDeadline(DateTime? date) {
    setState(() {
      widget.task.deadline = date;
      updateTask();
    });
  }

  @override
  Widget build(BuildContext context) {
    final navigator = Navigator.of(context);
    final Task task = widget.task;
    final DateTime? deadline = widget.task.deadline;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Task'),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () => setState(() => Task.toggleStar(task)),
            icon: Icon(
              Icons.star,
              color: (Task.star.contains(task)) ? Colors.yellow : null,
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
                    DateTimePickerView(getDeadline, setDeadline),
                    const SizedBox(width: 8),
                    Text((deadline != null) ? df.format(deadline) : ''),
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
                    onSaved: (value) => task.details = value!,
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
