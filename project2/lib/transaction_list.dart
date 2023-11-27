import 'package:first_app/chart.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'transaction.dart';

class Transactions extends StatelessWidget {
  final List<Transaction> transactions;

  const Transactions(this.transactions, {super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: transactions.isNotEmpty
            ? Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Chart(transactions),
                  Column(
                    children: transactions
                        .map((e) => Card(
                            child: Container(
                                margin: const EdgeInsets.all(8),
                                child: Column(children: [
                                  Text(e.title),
                                  Row(
                                    children: [
                                      Text("\$ ${e.amount}"),
                                      const Spacer(),
                                      Text(DateFormat('dd/MM/yyyy')
                                          .format(e.date))
                                    ],
                                  )
                                ]))))
                        .toList(),
                  ),
                ],
              )
            : Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Center(child: Text("Add some transactions!")),
                  SizedBox(
                    height: 200,
                    child: Image.asset('assets/images/waiting.png',
                        fit: BoxFit.fitHeight),
                  )
                ],
              ));
  }
}
