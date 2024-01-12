import 'package:flutter/material.dart';

import 'data.dart';

class TruckUtilView extends StatefulWidget {
  const TruckUtilView({super.key});

  @override
  State<StatefulWidget> createState() {
    return _TruckUtilViewState();
  }
}

class _TruckUtilViewState extends State<TruckUtilView> {
  Map<String, dynamic>? data;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      data = await Data.getTruckAvgUtils();
      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        ListTile(title: Text((data == null) ? '' : data.toString())),
        ElevatedButton(
          onPressed: () async {
            data = await Data.getTruckAvgUtils();
            setState(() {});
          },
          child: const Text('Tempting Button'),
        ),
      ],
    );
  }
}
