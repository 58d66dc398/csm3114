import 'package:flutter/material.dart';
import 'package:haulier/view_schedule.dart';
import 'package:haulier/view_truck.dart';

class AddTruckButton extends StatelessWidget {
  final Function refresh;

  const AddTruckButton({super.key, required this.refresh});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton.extended(
      onPressed: () =>
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const TruckPage()),
          ).then((value) => refresh),
      label: const Text('Register Truck'),
      icon: const Icon(Icons.add),
    );
  }
}

class AddScheduleButton extends StatelessWidget {
  final Function refresh;

  const AddScheduleButton({super.key, required this.refresh});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton.extended(
      onPressed: () =>
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const SchedulePage()),
          ).then((value) => refresh),
      label: const Text('Add Schedule'),
      icon: const Icon(Icons.add),
    );
  }
}
