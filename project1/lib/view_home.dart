import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:what_todo/data_tasks.dart';
import 'package:what_todo/utils.dart';
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
  int pageIndex = 1;

  @override
  Widget build(BuildContext context) {
    final ColorScheme scheme = Theme.of(context).colorScheme;
    final Color systemNavigationBarColor =
        ElevationOverlay.applySurfaceTint(scheme.surface, scheme.primary, 3);
    final ScaffoldMessengerState messengerState = ScaffoldMessenger.of(context);

    return Scaffold(
      appBar: AppBar(
        systemOverlayStyle: SystemUiOverlayStyle(
          systemNavigationBarColor: systemNavigationBarColor,
        ),
        title: Text(['Important Tasks', 'Tasks'][pageIndex]),
        centerTitle: true,
      ),
      // ignore: prefer_const_constructors
      body: <Widget>[StarTasksView(), TasksView()][pageIndex],
      floatingActionButton: InkWell(
        // demo purposes
        onLongPress: () {
          setState(() => addDummy());
          snack(messengerState, 'DEBUG: DUMMY DATA ADDED');
        },
        // add task
        child: FloatingActionButton(
          onPressed: () async {
            await showModalBottomSheet(
              isScrollControlled: true,
              context: context,
              builder: (context) => const AddTaskView(),
            ).then((task) {
              if (task is Task) {
                setState(() => Task.addTodo(task));
              }
            });
          },
          child: const Icon(Icons.add),
        ),
      ),
      bottomNavigationBar: NavigationBar(
        onDestinationSelected: (int index) {
          messengerState.removeCurrentSnackBar();
          setState(() => pageIndex = index);
        },
        selectedIndex: pageIndex,
        destinations: const <Widget>[
          NavigationDestination(icon: Icon(Icons.star), label: 'Starred'),
          NavigationDestination(icon: Icon(Icons.list_alt), label: 'Tasks'),
        ],
        // selectedItemColor: Theme.of(context).primaryColor,
      ),
    );
  }
}
