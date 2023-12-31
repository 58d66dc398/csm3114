import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:tutorial3/data/categories.dart';

import '../data/dummy_items.dart';
import '../models/category.dart';
import '../models/item.dart';
import 'add_item_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() {
    return _HomePageState();
  }
}

class _HomePageState extends State<HomePage> {
  Future<void> _addItemPage() async {
    // Navigator.push(
    //   context,
    //   MaterialPageRoute(builder: (ctx) => AddItemPage(refreshParent: refresh)),
    // );
    await Navigator.push(
      context,
      MaterialPageRoute(builder: (ctx) => AddItemPage(refreshParent: refresh)),
    ).then((value) {
      setState(() {
        if (value != null) {
          items.add(value);
        }
        getItems();
      });
    });
  }

  void getItems() async {
    final url = Uri.https(
      'c3114t3-default-rtdb.asia-southeast1.firebasedatabase.app',
      'data.json',
    );
    final resp = await http.get(url);
    final Map<String, dynamic>? list = json.decode(resp.body);

    items = [];
    if (list != null) {
      for (final item in list.entries) {
        Category category = categories.entries
            .firstWhere((e) => e.value.title == item.value['category'])
            .value;
        items.add(
          Item(
            id: item.key,
            name: item.value['name'],
            quantity: item.value['quantity'],
            category: category,
          ),
        );
      }
    }
    // print(items);
  }

  void refresh() => setState(() {});

  @override
  Widget build(BuildContext context) {
    getItems();
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
          itemBuilder: (context, index) {
            return Dismissible(
              background: Container(color: Colors.red),
              onDismissed: (direction) => items.remove(items[index]),
              key: Key(items[index].id),
              child: ListTile(
                leading: Tooltip(
                  message: items[index].category.title,
                  child: Container(
                    width: 32,
                    height: 32,
                    color: items[index].category.color,
                  ),
                ),
                title: Text(items[index].name),
                trailing: Text(
                  items[index].quantity.toString(),
                ),
              ),
            );
          }),
    );
  }
}
