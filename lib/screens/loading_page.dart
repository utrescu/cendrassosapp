import 'package:cendrassos/cendrassos_theme.dart';
import 'package:cendrassos/providers/djau.dart';
import 'package:cendrassos/screens/Error.dart';
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
  static String carregant = "Carregant";
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: new Stack(
        fit: StackFit.expand,
        children: <Widget>[
          /// Paint the area where the inner widgets are loaded with the
          /// background to keep consistency with the screen background
          new Container(
            decoration: BoxDecoration(color: secondaryColor),
          ),

          /// Render the Title widget, loader and messages below each other
          new Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Padding(
                      padding:
                          EdgeInsets.all(MediaQuery.of(context).size.width / 4),
                      child: Image.asset('assets/images/icon.png'),
                    ),

                    /// Loader Animation Widget
                    _errorMessage.isEmpty
                        ? Loading(loadingMessage: _message)
                        : Error(
                            errorMessage: _errorMessage, onRetryPressed: _load)
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
