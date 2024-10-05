import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';

void showInfoSnackBar(BuildContext context, String message) {
  Flushbar(
    margin: const EdgeInsets.all(8),
    borderRadius: BorderRadius.circular(8),
    title: null,
    message: message,
    icon: Icon(
      Icons.info_outline,
      size: 28.0,
      color: Colors.blue[300],
    ),
    leftBarIndicatorColor: Colors.blue[300],
    duration: const Duration(seconds: 3),
  ).show(context);
}

void showErrorSnackBar(BuildContext context, String message) {
  Flushbar(
    margin: const EdgeInsets.all(8),
    borderRadius: BorderRadius.circular(8),
    title: null,
    message: message,
    icon: Icon(
      Icons.warning,
      size: 28.0,
      color: Colors.red[300],
    ),
    leftBarIndicatorColor: Colors.red[300],
    duration: const Duration(seconds: 3),
  ).show(context);
}

void showSuccessSnackBar(BuildContext context, String message) {
  Flushbar(
    margin: const EdgeInsets.all(8),
    borderRadius: BorderRadius.circular(8),
    title: null,
    message: message,
    icon: Icon(
      Icons.check_circle,
      color: Colors.green[300],
    ),
    leftBarIndicatorColor: Colors.green[300],
    duration: const Duration(seconds: 3),
  ).show(context);
}
