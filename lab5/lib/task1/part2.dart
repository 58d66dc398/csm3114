import 'package:flutter/material.dart';

class Task1Part2 extends StatelessWidget {
  const Task1Part2({super.key});

  ListTile getDummy() => ListTile(
    leading: const Icon(Icons.person),
    title: const Text('Person'),
    subtitle: const Text('person@domail.com'),
    trailing: const Icon(Icons.arrow_forward),
    onTap: () => print('Tapped ListTile'),
  );

  ListTile getTitledDummy(String title) => ListTile(title: Text(title));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('ListView Example')),
        body: ListView(
          children: [
            getTitledDummy('Front-end development with React'),
            getTitledDummy('Next.js Framework'),
            getTitledDummy('Restful API using Python'),
            getTitledDummy('Cross-platform mobile apps with Google Flutter'),
          ],
        ));
  }
}
