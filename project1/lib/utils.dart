import 'package:flutter/material.dart';

void snack(ScaffoldMessengerState state, String message) {
  state
    ..removeCurrentSnackBar()
    ..showSnackBar(SnackBar(content: Text(message)));
}

void snackUndo(
  ScaffoldMessengerState state,
  String message,
  void Function() onUndo,
) {
  state.showSnackBar(
    SnackBar(
      content: Text(message),
      action: SnackBarAction(label: 'Undo', onPressed: onUndo),
    ),
  );
}
