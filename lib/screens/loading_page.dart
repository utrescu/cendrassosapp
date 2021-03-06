import 'package:cendrassos/providers/djau.dart';
import 'package:cendrassos/screens/components/helpers.dart';
import 'package:cendrassos/screens/dashboard_page.dart';
import 'package:cendrassos/screens/login_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../cendrassos_theme.dart';

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
    }
    gotoPath(initialRoute);
  }

  void gotoPath(String initialRoute) =>
      Navigator.popAndPushNamed(context, initialRoute);

  void _gotoLogin() {
    gotoPath(LoginPage.routeName);
  }

  @override
  Widget build(BuildContext context) {
    var margew = MediaQuery.of(context).size.width / 4;
    var margeh = MediaQuery.of(context).size.height / 4;
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          // Background
          Container(
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.background,
            ),
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
