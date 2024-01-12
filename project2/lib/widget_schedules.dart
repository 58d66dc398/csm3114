import 'package:flutter/material.dart';
import 'package:haulier/view_schedule.dart';

import 'data.dart';

class ScheduleListView extends StatefulWidget {
  const ScheduleListView({super.key});

  @override
  State<StatefulWidget> createState() {
    return _ScheduleListViewState();
  }
}

class _ScheduleListViewState extends State<ScheduleListView> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: Data.schedules.length,
      itemBuilder: (BuildContext context, int index) {
        return ListTile(
          title: Text(Data.schedules[index].toString()),
          onTap: () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => SchedulePage(editSchedule: Data.schedules[index]),
            ),
          ).then((value) => setState(() {})),
        );
      },
    );
  }
}
