import 'package:first_app/transaction_new.dart';
import 'package:flutter/material.dart';

import 'transaction.dart';
import 'transaction_list.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Expense Manager',
        theme: ThemeData(
          colorScheme: const ColorScheme.light(),
          fontFamily: 'Quicksand',
        ),
        home: const Expenses());
  }
}

class Expenses extends StatefulWidget {
  const Expenses({super.key});

  @override
  State<StatefulWidget> createState() {
    return _Expenses();
  }
}

class _Expenses extends State<Expenses> {
  List<Transaction> transactions = [
    Transaction(
        id: "1",
        title: "title 1",
        amount: 100.0,
        date: DateTime.now().subtract(const Duration(days: 1))),
    Transaction(id: "2", title: "title 2", amount: 200.0, date: DateTime.now()),
    Transaction(id: "3", title: "title 3", amount: 300.0, date: DateTime.now()),
    Transaction(id: "4", title: "title 4", amount: 400.0, date: DateTime.now()),
  ];

  final titleController = TextEditingController();
  final amountController = TextEditingController();

  void addTransaction(String title, double amount) {
    final transaction = Transaction(
        id: DateTime.now().toString(),
        title: title,
        amount: amount,
        date: DateTime.now());

    setState(() => transactions.add(transaction));
  }

  void startAddTransaction(BuildContext ctx) {
    showModalBottomSheet(
        context: ctx, builder: (_) => TransactionAdder(addTransaction));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:
          AppBar(title: const Text("Expenses"), centerTitle: true, actions: [
        IconButton(
            onPressed: () => startAddTransaction(context),
            icon: const Icon(Icons.add))
      ]),
      body: Transactions(transactions),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
          onPressed: () => startAddTransaction(context),
          child: const Icon(Icons.add)),
    );
  }
}
