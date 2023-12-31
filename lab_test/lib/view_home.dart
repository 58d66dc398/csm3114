import 'package:flutter/material.dart';
import 'package:lab_test/part_add_person.dart';

import 'data_persons.dart';
import 'model_person.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<StatefulWidget> createState() {
    return _HomePageState();
  }
}

class _HomePageState extends State<HomePage> {
  List<Person> victims = [];

  void getVictims() {
    // TODO: get data from actual source
    if (victims.isEmpty) {
      victims = [...dummyVictims];
    }
  }

  Container lazyBackground(Alignment alignment) {
    return Container(
      padding: const EdgeInsets.all(18),
      color: Colors.red,
      child: FittedBox(
        alignment: alignment,
        child: const Icon(Icons.delete_outline),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    getVictims();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Flood Victim List'),
        centerTitle: true,
        backgroundColor: Theme.of(context).secondaryHeaderColor,
      ),
      body: Column(
        children: [
          Container(
              padding: const EdgeInsets.only(top: 16, right: 18),
              alignment: Alignment.centerRight,
              child: const Text("PAX")),
          ListView.builder(
            shrinkWrap: true,
            itemCount: victims.length,
            itemBuilder: (BuildContext context, int index) {
              return Dismissible(
                key: UniqueKey(),
                background: lazyBackground(Alignment.centerLeft),
                secondaryBackground: lazyBackground(Alignment.centerRight),
                onDismissed: (_) => victims.removeAt(index),
                child: ListTile(
                  title: Text(victims[index].name),
                  subtitle: Text(victims[index].ic),
                  trailing: Text(victims[index].pax.toString()),
                ),
              );
            },
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => showModalBottomSheet(
          isScrollControlled: true,
          context: context,
          builder: (_) => const AddPerson(),
        ).then((value) {
          if (value != null && value is Person) {
            setState(() {
              victims.add(value);
            });
            // print('DEBUG: successfully added person');
          }
        }),
        child: const Icon(Icons.person),
      ),
    );
  }
}
