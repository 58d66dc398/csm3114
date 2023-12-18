import 'package:flutter/material.dart';

import 'select_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(useMaterial3: true),
      home: const MainScreen(),
    );
  }
}

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() {
    return _MainScreenState();
  }
}

class _MainScreenState extends State<MainScreen> {
  Map<String, String> _selection = {
    'num': 'unregistered',
    'name': 'unregistered'
  };

  _userSelectScreen() async {
    final result = await Navigator.push(context,
        MaterialPageRoute(builder: (context) => SelectionScreen()));
    // print('#Debug main.dart : Passing await');
    setState(() =>
        _selection = result ?? {'num': 'impossible', 'name': 'impossible'});
    // print('#Debug main.dart : _selection = $_selection');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lab 8 Task 4'),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('Num# : ${_selection['num']}'),
            Text('Name : ${_selection['name']}'),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _userSelectScreen,
              child: const Text('Select Screen'),
            ),
          ],
        ),
      ),
    );
  }
}
