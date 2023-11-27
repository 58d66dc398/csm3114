import 'package:flutter/material.dart';

class Task3 extends StatelessWidget {
  const Task3({super.key});

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
        appBar: AppBar(title: const Text('ListView.builder')),
        body: ListView.builder(
            padding: const EdgeInsets.all(8),
            clipBehavior: Clip.none,
            itemCount: cities.length,
            itemBuilder: (context, index) {
              return Padding(
                  padding: const EdgeInsets.all(8),
                  child: ListTile(
                      leading: CircleAvatar(child: Text(cities[index].code)),
                      title: Text(cities[index].cityName),
                      trailing: const Icon(Icons.more_vert),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)),
                      tileColor: const Color(0xffeeeeee)));
            }));
  }
}

class City {
  final String code, cityName;

  const City({required this.code, required this.cityName});
}
