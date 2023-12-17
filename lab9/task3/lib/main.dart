import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  final String title = 'Lab 9 - Focus Field';

  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: title,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blueGrey),
        fontFamily: 'Roboto',
      ),
      home: MyMainUI(title: title),
    );
  }
}

class MyMainUI extends StatefulWidget {
  final String title;

  const MyMainUI({super.key, required this.title});

  @override
  State<MyMainUI> createState() => _MyMainUIState();
}

class _MyMainUIState extends State<MyMainUI> {
  late FocusNode currentFocus;
  late TextEditingController myController;

  @override
  void initState() {
    super.initState();
    currentFocus = FocusNode();
    myController = TextEditingController();
  }

  @override
  void dispose() {
    currentFocus.dispose();
    myController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const SizedBox(height: 64),
            TextField(
              onChanged: (value) =>
                  print('# Debug : first field value update $value'),
              decoration: const InputDecoration(
                  labelText: 'Number',
                  hintText: 'Student Number',
                  // hintText: 'auto focus is set',
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(width: 2, color: Colors.blue))),
              autofocus: true,
            ),
            const SizedBox(height: 8),
            TextField(
              controller: myController,
              decoration: const InputDecoration(
                  labelText: 'Name',
                  hintText: 'Full Name',
                  // hintText: 'current focus is trigger',
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(width: 2, color: Colors.blue))),
              focusNode: currentFocus,
            ),
            // const TextField(
            //   decoration: InputDecoration(hintText: 'data 3'),
            // ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => currentFocus.requestFocus(),
        tooltip: 'click me to trigger focus',
        child: const Icon(Icons.star),
      ),
    );
  }
}
