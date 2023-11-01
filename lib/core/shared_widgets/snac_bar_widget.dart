import 'package:flutter/material.dart';

SnackBar customSnacBar({
  required context,
  required Color color,
  required Widget body,
  String direction = "bottom",
  Duration duration = const Duration(seconds: 1),
}) {
  return SnackBar(
    content: body,
    duration: duration,
    behavior: SnackBarBehavior.floating,
    backgroundColor: color,
    action: SnackBarAction(
      label: "close",
      textColor: Colors.white,
      onPressed: () => ScaffoldMessenger.of(context).hideCurrentSnackBar(),
    ),
  );
}
