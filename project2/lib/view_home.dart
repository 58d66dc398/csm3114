import 'package:flutter/material.dart';
import 'package:haulier/view_login.dart';
import 'package:haulier/widget_buttons.dart';
import 'package:haulier/widget_schedules.dart';
import 'package:haulier/widget_statistic.dart';
import 'package:haulier/widget_trucks.dart';

import 'data.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<StatefulWidget> createState() {
    return _HomePageState();
  }
}

class _HomePageState extends State<HomePage> {
  late final ThemeData theme = Theme.of(context);
  late final ColorScheme scheme = theme.colorScheme;
  int currentPageIndex = 1;
  final List<String> titles = ['Trucks', 'Overview', 'Schedules'];
  final Map<String, dynamic> user = Data.getCurrentUser();

  Widget? getButton() {
    switch (currentPageIndex) {
      case 0:
        return AddTruckButton(refresh: () => setState(() {}));
      case 2:
        return AddScheduleButton(refresh: () => setState(() {}));
      default:
        return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> pageView = const [
      TruckListView(),
      TruckUtilView(),
      ScheduleListView(),
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text(titles[currentPageIndex]),
        centerTitle: true,
        backgroundColor: scheme.primary,
        foregroundColor: scheme.onPrimary,
        actions: [
          Column(
            children: [
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
        ],
      ),
      backgroundColor: scheme.primary,
      body: pageView[currentPageIndex],
      bottomNavigationBar: NavigationBar(
        onDestinationSelected: (int index) {
          setState(() => currentPageIndex = index);
        },
        selectedIndex: currentPageIndex,
        destinations: const <Widget>[
          NavigationDestination(
            icon: Icon(Icons.local_shipping),
            label: 'Trucks',
          ),
          NavigationDestination(
            icon: Icon(Icons.leaderboard),
            label: 'Overview',
          ),
          NavigationDestination(
            icon: Icon(Icons.calendar_today),
            label: 'Schedules',
          ),
        ],
      ),
      floatingActionButton: getButton(),
    );
  }
}
