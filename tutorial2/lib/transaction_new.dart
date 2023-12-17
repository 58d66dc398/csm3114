import 'package:flutter/material.dart';

class TransactionAdder extends StatelessWidget {
  final Function addTransaction;
  final titleController = TextEditingController();
  final amountController = TextEditingController();

  TransactionAdder(this.addTransaction, {super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
        child: GestureDetector(
            onTap: () {},
            child: Container(
                margin: const EdgeInsets.all(8),
                child: Column(
                  children: [
                    TextField(
                        decoration: const InputDecoration(labelText: "Title"),
                        controller: titleController),
                    TextField(
                        decoration: const InputDecoration(labelText: "Amount"),
                        controller: amountController),
                    ElevatedButton(
                        onPressed: () {
                          addTransaction(titleController.text,
                              double.parse(amountController.text));
                          Navigator.pop(context);
                        },
                        child: const Text("Add"))
                  ],
                ))));
  }
}
