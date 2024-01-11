import 'package:flutter/material.dart';
import 'package:haulier/view_login.dart';
import 'package:haulier/widget_buttons.dart';
import 'package:haulier/widget_schedules.dart';

import 'data.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<StatefulWidget> createState() {
    return _HomePageState();
  }
}

class _HomePageState extends State<HomePage> {
  final Map<String, dynamic> user = Data.getCurrentUser();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Current User: ${user['username']}'),
        actions: [
          IconButton(
            onPressed: () {
              Data.deAuthUser();
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (_) => const LoginPage()),
              );
            },
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
      // ignore: prefer_const_constructors
      body: ScheduleListView(),
      // ignore: prefer_const_constructors
      // body: TruckListView(),
      floatingActionButton: AddScheduleButton(refresh: () => setState(() {})),
    );
  }
}
