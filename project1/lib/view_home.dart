import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:what_todo/data_tasks.dart';
import 'package:what_todo/widget_add_task.dart';
import 'package:what_todo/widget_tasks.dart';
import 'package:what_todo/widget_tasks_star.dart';

import 'model_task.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<StatefulWidget> createState() {
    return _HomePageState();
  }
}

class _HomePageState extends State<HomePage> {
  int viewIndex = 1;
  List<Task> todos = Task.todos, done = Task.done;

  List<String> titles = ['Important Tasks', 'Tasks'];
  late List<Widget> views;

  void refresh() => setState(() {});

  @override
  Widget build(BuildContext context) {
    // ignore: prefer_const_constructors
    views = <Widget>[StarTasksView(), TasksView()];

    return Scaffold(
      appBar: AppBar(
        systemOverlayStyle: SystemUiOverlayStyle(
          systemNavigationBarColor: Theme.of(context).canvasColor,
        ),
        title: Text(titles[viewIndex]),
        centerTitle: true,
      ),
      // task list
      body: views.elementAt(viewIndex),
      floatingActionButton: InkWell(
        // demo purposes
        onLongPress: () => setState(() {
          addDummy();
          Task.sortAll();
          ScaffoldMessenger.of(context)
            ..removeCurrentSnackBar()
            ..showSnackBar(
              const SnackBar(
                content: Text('DEBUG: DUMMY DATA ADDED'),
              ),
            );
        }),
        child: FloatingActionButton(
          onPressed: () async {
            await showModalBottomSheet(
              isScrollControlled: true,
              context: context,
              builder: (context) => AddTaskView(refresh),
            ).then((task) {
              if (task is Task) {
                setState(() {
                  todos.add(task);
                  Task.sortAll();
                  viewIndex = viewIndex;
                });
              }
            });
          },
          child: const Icon(Icons.add),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: viewIndex,
        onTap: (i) => setState(() {
          ScaffoldMessenger.of(context).removeCurrentSnackBar();
          viewIndex = i;
        }),
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.star), label: 'Starred'),
          BottomNavigationBarItem(icon: Icon(Icons.list_alt), label: 'Tasks'),
        ],
        // selectedItemColor: Theme.of(context).primaryColor,
      ),
    );
  }
}
