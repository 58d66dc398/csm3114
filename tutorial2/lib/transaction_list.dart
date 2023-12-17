import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'transaction.dart';

class Transactions extends StatelessWidget {
  final List<Transaction> data;
  final Function onPressed;

  const Transactions({super.key, required this.data, required this.onPressed});
  
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: data.length,
        itemBuilder: (BuildContext context, int index) => ListTile(
            leading: Text(data[index].title),
            title: Text("\$ ${data[index].amount}"),
            subtitle: Text(DateFormat('dd/MM/yyyy')
                .format(data[index].date)),
            trailing: IconButton(
              icon: const Icon(Icons.delete),
              onPressed: () => onPressed(index),
            )));
  }
}
