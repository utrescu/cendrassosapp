import 'dart:io';

import 'package:cendrassos/screens/register_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../navitator_key.dart';
import '../providers/djau.dart';
import '../screens/dashboard_page.dart';
import '../screens/login_page.dart';

class GlobalNavigator {
  static gotoNewAlumne() {
    if (Platform.isAndroid || Platform.isIOS) {
      // Sistemes mòbils
      gotoRegister();
    } else {
      // Escriptori
      gotoLogin();
    }
  }

  static gotoLogin() {
    var context = navigatorKey.currentContext!;
    Navigator.of(context).popUntil((route) => route.isFirst);
    Navigator.of(context).pushNamed(LoginPage.routeName);
  }

  static gotoRegister() {
    var context = navigatorKey.currentContext!;
    Navigator.of(context).popUntil((route) => route.isFirst);
    Navigator.of(context).pushNamed(RegisterPage.routeName);
  }

  static gotoAlumne(context, String username) async {
    final djau = Provider.of<DjauModel>(context, listen: false);
    await djau.loadAlumne(username);
    GlobalNavigator.go(Dashboard.routeName);
  }

  static forgetAndGo(String initialRoute) =>
      Navigator.popAndPushNamed(navigatorKey.currentContext!, initialRoute);

  static void goBack() {
    Navigator.pop(navigatorKey.currentContext!);
  }

  static void goBackAndReturn(String key) {
    Navigator.pop(navigatorKey.currentContext!, key);
  }

  static void forgetAndGoAndReturn(String route, String value) {
    Navigator.popAndPushNamed(navigatorKey.currentContext!, route,
        result: value);
  }

  static go(String route) =>
      Navigator.pushNamed(navigatorKey.currentContext!, route);

  static showAlertDialog(String detail) {
    showDialog(
      barrierDismissible: false,
      context: navigatorKey.currentContext!,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Text(detail),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.pop(context, true);
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  static showAlertPopup(String title, String detail) async {
    void showDemoDialog<T>(
        {required BuildContext context, required Widget child}) {
      showDialog<T>(
        context: navigatorKey.currentContext!,
        barrierDismissible: false,
        builder: (BuildContext context) => child,
      );
    }

    return showDemoDialog<void>(
        context: navigatorKey.currentContext!,
        child: AlertDialog(
          title: Text(title),
          content: Text(detail),
          actions: [
            ElevatedButton(
                child: const Text('OK'),
                onPressed: () {
                  Navigator.pop(navigatorKey.currentContext!);
                }),
          ],
        ));
  }
}
