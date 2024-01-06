import 'package:flutter/material.dart';

// https://stackoverflow.com/questions/45948168
void snack(ScaffoldMessengerState state, String message) {
  state
    ..removeCurrentSnackBar()
    ..showSnackBar(SnackBar(content: Text(message)));
}
