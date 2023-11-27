import 'package:flutter/material.dart';

class Task2Part2 extends StatelessWidget {
  const Task2Part2({super.key});

  final List<City> cities = const [
    City(code: 'KUL', cityName: 'Kuala Lumpur'),
    City(code: 'AKL', cityName: 'Auckland'),
    City(code: 'DTM', cityName: 'Dortmund'),
    City(code: 'LPL', cityName: 'Liverpool'),
    City(code: 'IBZ', cityName: 'Ibiza'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('Object List')),
        body: ListView(
            padding: const EdgeInsets.all(8),
            clipBehavior: Clip.none,
            children: cities
                .map((e) => Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: ListTile(
                        leading: const Icon(Icons.flight),
                        title: Text(e.code),
                        subtitle: Text(e.cityName),
                        trailing: const Icon(Icons.arrow_forward),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)),
                        tileColor: const Color(0xffeeeeee))))
                .toList()));
  }
}

class City {
  final String code, cityName;

  const City({required this.code, required this.cityName});
}
