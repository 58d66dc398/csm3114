import 'package:flutter/material.dart';

class Task2Part3 extends StatelessWidget {
  const Task2Part3({super.key});

  final List<Person> peoples = const [
    Person(name: 'Andy', paid: true),
    Person(name: 'Baal', paid: false),
    Person(name: 'Cain', paid: true),
    Person(name: 'Dave', paid: true),
    Person(name: 'Ezra', paid: false),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('Object List')),
        body: ListView(
            padding: const EdgeInsets.all(8),
            clipBehavior: Clip.none,
            children: peoples
                .map((e) => Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: ListTile(
                        leading: const Icon(Icons.people),
                        title: Text(e.name),
                        subtitle: Text(e.paid ? 'Completed' : 'Unpaid'),
                        trailing: const Icon(Icons.arrow_forward),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)),
                        textColor: e.paid ? Colors.black : Colors.white,
                        tileColor:
                            e.paid ? Colors.greenAccent : Colors.redAccent)))
                .toList()));
  }
}

class Person {
  final String name;
  final bool paid;

  const Person({required this.name, required this.paid});
}
