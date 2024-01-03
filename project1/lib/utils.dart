import 'package:flutter/material.dart';

void snack(ScaffoldMessengerState state, String message) {
  state
    ..removeCurrentSnackBar()
    ..showSnackBar(SnackBar(content: Text(message)));
}
