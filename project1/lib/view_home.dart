import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'data.dart';
import 'model_task.dart';
import 'utils.dart';
import 'widget_add_task.dart';
import 'widget_tasks.dart';
import 'widget_tasks_star.dart';

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
  void initState() {
    super.initState();
  }

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
        onLongPress: () async {
          await Data.dummy();
          setState(() {});
          snack(messengerState, 'DEBUG: DUMMY DATA ADDED');
        },
        onDoubleTap: () async {
          await Data.nuke();
          setState(() {});
          snack(messengerState, 'DEBUG: BOOM');
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
                setState(() => task.addTodo());
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
