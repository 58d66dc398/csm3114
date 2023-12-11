import 'package:flutter/material.dart';
import 'package:lab7/object/employee.dart';

import '../object/product.dart';
import 'prod_screen.dart';
import 'screen1.dart';
import 'screen2.dart';
import 'view_stocks.dart';

class Screen3 extends StatefulWidget {
  List<Employee> employees = [];

  List<Product> products = [
    Product(code: 'c001', description: 'nasi lemak'),
    Product(code: 'c002', description: 'nasi ayam'),
    Product(code: 'c003', description: 'nasi minyak'),
  ];

  Screen3({super.key, required this.employees});

  @override
  State<StatefulWidget> createState() {
    return _Screen3tate();
  }
}

class _Screen3tate extends State<Screen3> {
  Employee? choice;

  _Screen3tate();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            automaticallyImplyLeading: true, title: const Text('Employees')),
        drawer: Drawer(
            child: ListView(
          children: [
            DrawerHeader(
                decoration:
                    BoxDecoration(color: Theme.of(context).primaryColor),
                child: Text('Drawer Header',
                    style: Theme.of(context).textTheme.headlineMedium)),
            ListTile(
                title: const Text('Product'),
                onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ProductScreen(
                              products: widget.products,
                            )))),
            ListTile(
                title: const Text('Stock'),
                onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const ViewStocks()))),
            ListTile(
                title: const Text('Close'),
                onTap: () => Navigator.pop(context)),
          ],
        )),
        body: Column(children: [
          Expanded(
              child: ListView.builder(
                  itemCount: widget.employees.length,
                  itemBuilder: (context, index) => ListTile(
                      contentPadding: const EdgeInsets.all(8),
                      leading: Radio<Employee>(
                          value: widget.employees[index],
                          groupValue: choice,
                          onChanged: (Employee? value) =>
                              setState(() => choice = value)),
                      title: Text(widget.employees[index].name),
                      trailing: IconButton(
                          icon: const Icon(Icons.arrow_right),
                          onPressed: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      Screen2(widget.employees[index]))))))),
          Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      shape: const StadiumBorder(),
                      padding: const EdgeInsets.symmetric(
                          vertical: 16, horizontal: 24)),
                  onPressed: () {
                    if (choice == null) {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text("Pick a candidate first."),
                      ));
                      return;
                    }
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => Screen1(choice!)));
                  },
                  child: const Text('Vote Candidate',
                      style: TextStyle(fontSize: 16))))
        ]));
  }
}
