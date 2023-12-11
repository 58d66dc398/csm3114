import 'package:flutter/material.dart';
import 'package:lab7/object/employee.dart';

class Screen1 extends StatelessWidget {
  Employee employee;

  Screen1(this.employee, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('Confirmation')),
        body: Container(
            padding: const EdgeInsets.all(32),
            alignment: Alignment.center,
            child: Column(mainAxisAlignment: MainAxisAlignment.center,
                children: [
              Text('You are voting:',
                  style: Theme.of(context).textTheme.headlineMedium),
              const SizedBox(height: 16),
              Text(employee.name,
                  style: Theme.of(context).textTheme.headlineLarge),
              const SizedBox(height: 8),
              Text('Score: ${employee.score} / 5.0',
                  style: Theme.of(context).textTheme.headlineSmall),
              const SizedBox(height: 32),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      shape: const StadiumBorder(),
                      padding: const EdgeInsets.symmetric(
                          vertical: 16, horizontal: 24)),
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text('You have voted ${employee.name}!'),
                    ));
                    Navigator.pushNamed(context, '/second');
                  },
                  child: const Text('Yeah, Vote It.',
                      style: TextStyle(fontSize: 16)))
            ])));
  }
}
