import 'package:flutter/material.dart';
import 'package:haulier/view_truck.dart';

import 'data.dart';

class TruckListView extends StatefulWidget {
  const TruckListView({super.key});

  @override
  State<StatefulWidget> createState() => _TruckListViewState();
}

class _TruckListViewState extends State<TruckListView> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: Data.trucks.length,
      itemBuilder: (BuildContext context, int index) {
        return ListTile(
          title: Text(Data.trucks[index].toString()),
          onTap: () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => TruckPage(editTruck: Data.trucks[index]),
            ),
          ).then((value) async {
            await Data.loadTrucks();
            setState(() {});
          }),
        );
      },
    );
  }
}
