import 'package:flutter/material.dart';
import 'package:lab7/object/employee.dart';

import 'screen1.dart';

class Screen2 extends StatelessWidget {
  final Employee employee;

  const Screen2(this.employee, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('About')),
        body: Container(
            padding: const EdgeInsets.all(32),
            alignment: Alignment.center,
            child: Column(children: [
              Text(employee.department,
                  style: Theme.of(context).textTheme.headlineLarge),
              const SizedBox(height: 24),
              const CircleAvatar(
                  radius: 64,
                  backgroundColor: Colors.redAccent,
                  child: Icon(Icons.person, size: 96, color: Colors.white)),
              const SizedBox(height: 16),
              Text(employee.name,
                  style: Theme.of(context).textTheme.headlineLarge),
              const SizedBox(height: 8),
              Text('Staff No. ${employee.staffNo}',
                  style: Theme.of(context).textTheme.headlineSmall),
              const SizedBox(height: 32),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      shape: const StadiumBorder(),
                      padding: const EdgeInsets.symmetric(
                          vertical: 16, horizontal: 24)),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => Screen1(employee)));
                  },
                  child: const Text('Vote Candidate',
                      style: TextStyle(fontSize: 16)))
            ])));
  }
}
