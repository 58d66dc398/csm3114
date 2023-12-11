import 'package:flutter/material.dart';
import 'package:lab7/object/employee.dart';
import 'package:lab7/widget/screen3.dart';

void main() {
  List<Employee> employees = [
    Employee('John Smith',
        staffNo: '1', department: 'Department of Literacy', score: 5),
    Employee('George Peterson',
        staffNo: '2', department: 'AI Department', score: 6.9),
    Employee('Sara',
        staffNo: 'a', department: 'International Department', score: 3.4),
    Employee('Person A', staffNo: '3', department: 'Espionage Sector', score: 0)
  ];

  runApp(MaterialApp(initialRoute: '/second', routes: {
    // '/': (context) => const Screen1(),
    // '/first': (context) => const Screen2(),
    '/second': (context) => Screen3(employees: employees)
  }));
}
