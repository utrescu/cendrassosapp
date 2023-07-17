import 'dart:io';

import 'package:cendrassos/config_djau.dart';
import 'package:cendrassos/providers/djau.dart';
import 'package:cendrassos/screens/components/helpers.dart';
import 'package:cendrassos/screens/dashboard_page.dart';
import 'package:cendrassos/screens/login_page.dart';
import 'package:cendrassos/screens/users_page.dart';
import 'package:cendrassos/utils/global_navigator.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoadingPage extends StatefulWidget {
  static const routeName = '/loading';

  const LoadingPage({Key? key}) : super(key: key);

  @override
  State<LoadingPage> createState() => _LoadingPageState();
}

class _LoadingPageState extends State<LoadingPage> {
  static String carregant = missatgeCarregantDades;
  String _message = carregant;
  String _errorMessage = "";
  String _errorType = "";

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future _load() async {
    String initialRoute = UsersPage.routeName;
    setState(() {
      _message = carregant;
      _errorMessage = "";
      _errorType = "";
    });

    var djau = Provider.of<DjauModel>(context, listen: false);
    // Comprovar si tots els alumnes poden fer login:
    // - Si: Carregar el darrer alumne i mirar si pot fer login
    // - No hi ha dades: scanqr_page
    // - Alguns: users_page
    var desti = await djau.determineInitialPage();

    if (djau.isError()) {
      setState(() {
        _message = "";
        _errorMessage = djau.errorMessage;
        _errorType = djau.errorType;
      });
      return;
    }

    switch (desti) {
      case 0: // No hi ha alumnes, demanar registre
        GlobalNavigator.gotoNewAlumneWithPop();
        break;
      case 1: // Hi ha alumnes sense confirmar
        GlobalNavigator.forgetAndGo(UsersPage.routeName);
        break;
      case 2: // Tots els alumnes estan confirmats
        await djau.loadDefaultAlumne();
        if (djau.isLogged()) {
          initialRoute = Dashboard.routeName;
        }
        GlobalNavigator.forgetAndGo(initialRoute);
        break;
    }
  }

  void _gotoLogin() {
    var route = UsersPage.routeName;
    if (!Platform.isAndroid && !Platform.isIOS) {
      route = LoginPage.routeName;
    }
    GlobalNavigator.forgetAndGo(route);
  }

  @override
  Widget build(BuildContext context) {
    var margew = MediaQuery.of(context).size.width / 4;
    var margeh = MediaQuery.of(context).size.height / 4;
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          // Background
          Container(
            decoration: const BoxDecoration(),
          ),

          /// Render the Title widget, loader and messages below each other

          Column(
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
                      errorType: _errorType,
                      errorMessage: _errorMessage,
                      onRetryPressed: _load,
                      onLogin: _gotoLogin,
                    ),
            ],
          ),
        ],
      ),
    );
  }
}
