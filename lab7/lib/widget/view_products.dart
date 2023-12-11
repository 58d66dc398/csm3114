import 'package:flutter/material.dart';

class ViewProducts extends StatelessWidget {
  const ViewProducts({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('Product')),
        body: const Center(child: Text('Overall Product View')));
  }
}
