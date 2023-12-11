import 'package:flutter/material.dart';

class ViewStocks extends StatelessWidget {
  const ViewStocks({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('Product')),
        body: const Center(child: Text('Overall Product View')));
  }
}
