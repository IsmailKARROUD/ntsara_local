import 'package:flutter/material.dart';

void snackBarMessage({
  required BuildContext context,
  required String message,
  required bool isItError,
  Duration? duration,
}) {
  if (duration == null) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      elevation: 1,
      behavior: SnackBarBehavior.floating,
      margin: const EdgeInsets.all(8),
      content: Text(message),
      backgroundColor: isItError
          ? Theme.of(context).colorScheme.error.withOpacity(0.75)
          : Colors.grey.withOpacity(0.75),
    ));
  } else {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      elevation: 1,
      behavior: SnackBarBehavior.floating,
      margin: const EdgeInsets.all(8),
      duration: duration,
      content: Text(message),
      backgroundColor: isItError
          ? Theme.of(context).colorScheme.error.withOpacity(0.75)
          : Colors.grey.withOpacity(0.75),
    ));
  }
}
