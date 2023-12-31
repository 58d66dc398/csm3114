import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;

import '../data/categories.dart';
import '../data/dummy_items.dart';
import '../models/category.dart';
import '../models/item.dart';

class AddItemPage extends StatefulWidget {
  final VoidCallback refreshParent;

  const AddItemPage({super.key, required this.refreshParent});

  @override
  State<StatefulWidget> createState() {
    return _AddItemPageState();
  }
}

class _AddItemPageState extends State<AddItemPage> {
  String? _name;
  int? _quantity;
  Category? _category;

  final _formKey = GlobalKey<FormState>();

  void _addItem() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      final url = Uri.https(
        'c3114t3-default-rtdb.asia-southeast1.firebasedatabase.app',
        'data.json',
      );
      await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
        },
        body: json.encode({
          'name': _name,
          'quantity': _quantity,
          'category': _category!.title,
        }),
      );
      // Item item = Item(
      //   id: items.length.toString(),
      //   name: _name!,
      //   quantity: _quantity!,
      //   category: _category!,
      // );
      // items.add(item);
      // widget.refreshParent();
      // Navigator.pop(context, item);
      if (context.mounted) {
        Navigator.pop(context);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Add Item'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                maxLength: 64,
                decoration: const InputDecoration(labelText: 'Name'),
                validator: (value) => (value == null ||
                        value.isEmpty ||
                        // value.trim().length <= 1 ||
                        value.trim().length > 50)
                    ? 'Must be between 1 and 50 characters.'
                    : null,
                onSaved: (value) {
                  _name = value;
                },
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Expanded(
                    child: TextFormField(
                      decoration: const InputDecoration(labelText: 'Quantity'),
                      keyboardType: TextInputType.number,
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.digitsOnly
                      ],
                      initialValue: '1',
                      validator: (value) => (value == null ||
                              value.isEmpty ||
                              int.tryParse(value) == null ||
                              int.tryParse(value)! <= 0)
                          ? 'Must be a valid, positive number.'
                          : null,
                      onSaved: (value) {
                        _quantity = int.tryParse(value!);
                      },
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: DropdownButtonFormField(
                      items: [
                        for (final category in categories.entries)
                          DropdownMenuItem(
                              value: category.value,
                              child: Row(
                                children: [
                                  Container(
                                    width: 16,
                                    height: 16,
                                    color: category.value.color,
                                  ),
                                  const SizedBox(width: 16),
                                  Text(category.value.title),
                                ],
                              ))
                      ],
                      decoration: const InputDecoration(hintText: 'Category'),
                      validator: (value) {
                        return (value == null)
                            ? 'You forgot about category'
                            : null;
                      },
                      onChanged: (value) {
                        _category = value;
                      },
                    ),
                  ),
                ],
              ),
              ButtonBar(
                children: [
                  ElevatedButton(
                    onPressed: () => _formKey.currentState!.reset(),
                    child: const Text('Reset'),
                  ),
                  ElevatedButton(
                    onPressed: _addItem,
                    child: const Text('Submit'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
