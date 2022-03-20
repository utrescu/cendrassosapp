import 'dart:math';

import 'package:cendrassos/config_cendrassos.dart';
import 'package:cendrassos/providers/djau.dart';
import 'package:cendrassos/screens/components/Error.dart';
import 'package:cendrassos/screens/dashboard_page.dart';
import 'package:cendrassos/screens/login_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoadingPage extends StatefulWidget {
  static const routeName = '/loading';

  const LoadingPage({Key? key}) : super(key: key);

  @override
  _LoadingPageState createState() => _LoadingPageState();
}

class _LoadingPageState extends State<LoadingPage> {
  static String carregant = MissatgeCarregantDades;
  String _message = carregant;
  String _errorMessage = "";

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future _load() async {
    String initialRoute = LoginPage.routeName;
    setState(() {
      _message = carregant;
      _errorMessage = "";
    });

    var djau = Provider.of<DjauModel>(context, listen: false);
    // Carregar el darrer alumne i mirar si pot fer login
    await djau.loadDefaultAlumne();

    if (djau.isError()) {
      setState(() {
        _message = "";
        _errorMessage = djau.errorMessage;
      });
      return;
    }

    if (djau.isLogged()) {
      initialRoute = Dashboard.routeName;
    } else
      Navigator.pop(context);
    Navigator.pushNamed(context, initialRoute);
  }

  void _gotoLogin() {
    Navigator.pop(context);
    Navigator.of(context).pushNamed(LoginPage.routeName);
  }

  @override
  Widget build(BuildContext context) {
    var margew = MediaQuery.of(context).size.width / 4;
    var margeh = MediaQuery.of(context).size.height / 4;
    return Scaffold(
      backgroundColor: Colors.black,
      body: new Stack(
        fit: StackFit.expand,
        children: <Widget>[
          // Background
          new Container(
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.background,
            ),
          ),

          /// Render the Title widget, loader and messages below each other
          new Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Image.asset(
                  'assets/images/icon.png',
                  height: margeh,
                  width: margew,
                ),

                /// Loader Animation Widget
                _errorMessage.isEmpty
                    ? Loading(loadingMessage: _message)
                    : ErrorRetryLogin(
                        errorMessage: _errorMessage,
                        onRetryPressed: _load,
                        onLogin: _gotoLogin,
                      ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
