import 'package:flutter/material.dart';

import '../data/dummy_items.dart';
import 'add_item_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() {
    return _HomePageState();
  }
}

class _HomePageState extends State<HomePage> {
  void _addItemPage() {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (ctx) => AddItemPage(refreshParent: refresh)));
  }

  void refresh() => setState(() {});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Shopping List'),
        actions: [
          IconButton(onPressed: _addItemPage, icon: const Icon(Icons.add)),
        ],
      ),
      body: ListView.builder(
        itemCount: items.length,
        itemBuilder: (context, index) => ListTile(
          leading: Container(
              width: 32, height: 32, color: items[index].category.color),
          title: Text(items[index].name),
          trailing: Text(
            items[index].quantity.toString(),
          ),
        ),
      ),
    );
  }
}