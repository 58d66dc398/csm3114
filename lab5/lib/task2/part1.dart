import 'package:flutter/material.dart';

class Task2Part1 extends StatelessWidget {
  Task2Part1({super.key});

  final List<String> books = [
    'Front-end development with React',
    'Next.js Framework',
    'Restful API using Python',
    'Cross-platform mobile apps with Google Flutter'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('Populate List')),
        body: ListView(
            padding: const EdgeInsets.all(8),
            clipBehavior: Clip.none,
            children: books
                .map((e) => Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: ListTile(
                        title: Text(e),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)),
                        tileColor: const Color(0xffeeeeee))))
                .toList()));
  }
}
