import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'transaction.dart';

class Chart extends StatelessWidget {
  final List<Transaction> recentTransactions;

  const Chart(this.recentTransactions, {super.key});

  List<Map<String, Object>> get groupedTransactionValues {
    return List.generate(7, (index) {
      final weekday = DateTime.now().subtract(Duration(days: index));
      double total = 0.0;

      for (var i = 0; i < recentTransactions.length; i++) {
        if (recentTransactions[i].date.day == weekday.day &&
            recentTransactions[i].date.month == weekday.month &&
            recentTransactions[i].date.year == weekday.year) {
          total += recentTransactions[i].amount;
        }
      }

      final weekDate = DateFormat.E().format(weekday);

      print(weekDate);
      print(total);

      return {'day': weekDate.substring(0, 1), 'amount': total};
    });
  }

  double get totalAmount {
    return groupedTransactionValues.fold(0.0, (sum, item) {
      return sum + (item['amount'] as double);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
        elevation: 5,
        child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: groupedTransactionValues
                  .map((data) => Flexible(
                      fit: FlexFit.tight,
                      child: Column(
                        children: [
                          FittedBox(
                              child: Text(
                                  'RM${(data['amount'] as double).toStringAsFixed(0)}')),
                          const SizedBox(height: 4),
                          SizedBox(
                              height: 60,
                              width: 10,
                              child: Stack(
                                alignment: Alignment.bottomCenter,
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                            color: Colors.grey, width: 1),
                                        color: const Color.fromRGBO(
                                            220, 220, 220, 1),
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                  ),
                                  FractionallySizedBox(
                                      heightFactor: totalAmount == 0.0
                                          ? 0.0
                                          : (data['amount'] as double) /
                                              totalAmount,
                                      child: Container(
                                          decoration: BoxDecoration(
                                              color: Theme.of(context)
                                                  .primaryColor,
                                              borderRadius:
                                                  BorderRadius.circular(10)))),
                                ],
                              )),
                          const SizedBox(height: 4),
                          Text(data['day'].toString())
                        ],
                      )))
                  .toList(),
            )));
  }
}
