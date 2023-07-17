import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void makingSurePopUp(
    {required BuildContext context,
    required String title,
    String message = "",
    String firstRespond = "Yes",
    required VoidCallback? firstOnPressed,
    String secondRespond = "No",
    VoidCallback? secondOnPressed,
    bool isit2responds = true}) {
  if (Platform.isIOS) {
    showCupertinoDialog<String>(
      context: context,
      builder: (BuildContext context) => CupertinoAlertDialog(
        title: Text(title),
        content: message != "" ? Text(message) : null,
        actions: <Widget>[
          TextButton(
            onPressed: firstOnPressed,
            child: Text(firstRespond),
          ),
          if (isit2responds)
            TextButton(
              onPressed: secondOnPressed,
              child: Text(secondRespond),
            ),
        ],
      ),
    );
  } else {
    {
      showDialog<String>(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
          title: Text(title),
          content: message != "" ? Text(message) : null,
          actions: <Widget>[
            TextButton(
              onPressed: firstOnPressed,
              child: Text(firstRespond),
            ),
            if (isit2responds)
              TextButton(
                onPressed: secondOnPressed,
                child: Text(secondRespond),
              ),
          ],
        ),
      );
    }
  }
}
