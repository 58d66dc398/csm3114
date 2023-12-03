import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(theme: ThemeData.dark(), home: const MyMainPage()));
}

class MyMainPage extends StatefulWidget {
  const MyMainPage({super.key});

  @override
  State<StatefulWidget> createState() {
    return _MyMainPageState();
  }
}

class _MyMainPageState extends State<MyMainPage> {
  var todos = ['Task 1', 'Task 2', 'Task 3', 'Task 4'];

  void _addingTodo() {
    var input = '';

    showDialog(
        context: context,
        builder: (BuildContext context) => AlertDialog(
              title: const Text('Add To-Do'),
              content: TextField(onChanged: (i) => input = i),
              actions: <Widget>[
                TextButton(
                    onPressed: () => Navigator.of(context).pop(),
                    child: const Text('Cancel')),
                TextButton(
                    onPressed: () {
                      setState(() => todos.add(input));
                      Navigator.of(context).pop();
                    },
                    child: const Text('Submit')),
              ],
            ));
  }

  void _removingTodo(int index) {
    showDialog(
        context: context,
        builder: (BuildContext context) => AlertDialog(
              title: const Text('Confirmation'),
              content: Text('You sure you want to delete "${todos[index]}"?'),
              actions: <Widget>[
                TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text('Just Kidding')),
                TextButton(
                    onPressed: () {
                      setState(() => todos.removeAt(index));
                      Navigator.pop(context);
                    },
                    child: const Text('Yeah')),
              ],
            ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('To-Do List'),
      ),
      body: ListView.builder(
          itemCount: todos.length,
          itemBuilder: (context, index) {
            final todo = todos[index];
            return ListTile(
                title: Text(todo), onTap: () => _removingTodo(index));
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: _addingTodo,
        child: const Icon(Icons.add),
      ),
    );
  }
}
