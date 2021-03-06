import 'package:flutter/material.dart';

void showAlertPopup(BuildContext context, String title, String detail) async {
  void showDemoDialog<T>(
      {required BuildContext context, required Widget child}) {
    showDialog<T>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) => child,
    );
  }

  return showDemoDialog<void>(
      context: context,
      child: AlertDialog(
        title: Text(title),
        content: Text(detail),
        actions: [
          ElevatedButton(
              child: const Text('OK'),
              onPressed: () {
                Navigator.pop(context);
              }),
        ],
      ));
}
