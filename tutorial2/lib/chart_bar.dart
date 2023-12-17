import 'package:flutter/material.dart';

class ChartBar extends StatelessWidget {
  final Map<String, Object> data;
  final double totalAmount;

  const ChartBar({super.key, required this.data, required this.totalAmount});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
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
                            color: Theme
                                .of(context)
                                .primaryColor,
                            borderRadius:
                            BorderRadius.circular(10)))),
              ],
            )),
        const SizedBox(height: 4),
        Text(data['day'].toString())
      ],
    );
  }

}