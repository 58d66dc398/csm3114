import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import 'chart.dart';
import 'transaction.dart';
import 'transaction_list.dart';
import 'transaction_new.dart';

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

DateTime lazyDate(int d) => DateTime.now().add(Duration(days: d));

class _Expenses extends State<Expenses> {
  List<Transaction> transactions = [
    Transaction(id: "1", title: "title 1", amount: 100.0, date: lazyDate(-4)),
    Transaction(id: "2", title: "title 2", amount: 400.0, date: lazyDate(-2)),
    Transaction(id: "3", title: "title 3", amount: 200.0, date: lazyDate(-1)),
    Transaction(id: "4", title: "title 4", amount: 300.0, date: DateTime.now()),
  ];

  final titleController = TextEditingController();
  final amountController = TextEditingController();

  bool visible = false;

  void addTransaction(String title, double amount) {
    final transaction = Transaction(
        id: DateTime.now().toString(),
        title: title,
        amount: amount,
        date: DateTime.now());

    setState(() => transactions.add(transaction));
  }

  void removeTransaction(int index) =>
      setState(() => transactions.removeAt(index));

  void startAddTransaction(BuildContext ctx) {
    showModalBottomSheet(
        context: ctx, builder: (_) => TransactionAdder(addTransaction));
  }

  @override
  Widget build(BuildContext context) {
    final appBar =
        AppBar(title: const Text("Expenses"), centerTitle: true, actions: [
      IconButton(
          onPressed: () => startAddTransaction(context),
          icon: const Icon(Icons.add))
    ]);

    final mediaQuery = MediaQuery.of(context);
    final screenHeight = mediaQuery.size.height;
    final topPadding = mediaQuery.padding.top;
    final freeHeight = screenHeight - topPadding - appBar.preferredSize.height;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: appBar,
      body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: transactions.isNotEmpty
              ? Column(children: <Widget>[
                  Visibility(
                      visible: visible,
                      child: Container(
                          padding: const EdgeInsets.only(top: 16),
                          height: freeHeight * 0.3,
                          child: Chart(transactions))),
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                    const Text('Show Graph'),
                    Switch(
                        value: visible,
                        onChanged: (e) => setState(() => visible = !visible))
                  ]),
                  Expanded(
                      child: Transactions(
                          data: transactions, onPressed: removeTransaction))
                ])
              : Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Center(child: Text("Add some transactions!")),
                    const SizedBox(height: 16),
                    SizedBox(
                      height: 200,
                      child: Image.asset('assets/images/waiting.png',
                          fit: BoxFit.fitHeight),
                    )
                  ],
                )),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
          onPressed: () => startAddTransaction(context),
          child: const Icon(Icons.add)),
    );
  }
}
