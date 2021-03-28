import 'package:flutter/material.dart';

mixin OkitoWidgets {
  BuildContext? context;

  void showSnackbar(SnackBar snackBar) {
    ScaffoldMessenger.of(context!).showSnackBar(snackBar);
  }
}
