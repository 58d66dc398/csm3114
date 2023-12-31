import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'model_person.dart';

class AddPerson extends StatefulWidget {
  const AddPerson({super.key});

  @override
  State<AddPerson> createState() => _AddPersonState();
}

class _AddPersonState extends State<AddPerson> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  String name = "", ic = "";
  int pax = -1;

  @override
  Widget build(BuildContext context) {
    final MediaQueryData mediaQuery = MediaQuery.of(context);
    final double keyboardPadding = max(mediaQuery.viewInsets.bottom - 16, 0);

    return Container(
      padding: EdgeInsets.only(
        left: 16,
        top: 16,
        right: 16,
        bottom: keyboardPadding + 16,
      ),
      child: Form(
        key: formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Align(
              child: Text(
                "New Entry",
                style: Theme.of(context).textTheme.headlineSmall,
              ),
            ),
            TextFormField(
              decoration: const InputDecoration(
                labelText: "Name",
                hintText: "Full Name",
              ),
              validator: (value) =>
                  (value == null || value.isEmpty) ? "You have no name?" : null,
              onSaved: (value) => name = value!,
            ),
            TextFormField(
              keyboardType: TextInputType.number,
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.allow(RegExp(r'[0-9\-]'))
              ],
              decoration: const InputDecoration(
                labelText: "IC",
                hintText: "IC Number (no, we won't validate it, lol)",
              ),
              validator: (value) =>
                  (value == null || value.isEmpty) ? "No IC? Illegal." : null,
              onSaved: (value) => ic = value!,
            ),
            TextFormField(
              keyboardType: TextInputType.number,
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.digitsOnly,
              ],
              initialValue: '0',
              decoration: const InputDecoration(
                labelText: "Pax.",
                hintText:
                    "No. of persons in relief center (yes, we validate this)",
              ),
              validator: (value) {
                String? error;
                if (value == null || value.isEmpty) {
                  error = "No PAX";
                } else if (int.tryParse(value) == null) {
                  error = "Do you know math?";
                } else if (int.parse(value) < 0) {
                  error = "Woah negative person";
                }
                return error;
              },
              onSaved: (value) => pax = int.parse(value!),
            ),
            ButtonBar(
              children: [
                TextButton(
                  onPressed: () {
                    if (formKey.currentState!.validate()) {
                      formKey.currentState!.save();
                      Navigator.pop(
                          context, Person(name: name, ic: ic, pax: pax));
                    }
                    // print("DEBUG: $name, $ic, $pax");
                  },
                  child: const Text('Add'),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
