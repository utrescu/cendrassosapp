import 'package:cendrassos/config_cendrassos.dart';
import 'package:cendrassos/providers/djau.dart';
import 'package:cendrassos/utils/popup.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class LoginPage extends StatefulWidget {
  static const routeName = '/login';

  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formkey = GlobalKey<FormState>();
  final _usernameController = new TextEditingController();
  final _passwordController = new TextEditingController();

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  String? _isNotNull(String? value) {
    if (value == null || value.isEmpty) {
      return "Aquest camp no es pot deixar en blanc";
    }
    return null;
  }

  Future<LoginResult> _login(BuildContext context) async {
    var loginCall = context.read<DjauModel>();

    var result = await loginCall.login(
        _usernameController.text, _passwordController.text);
    return result;
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Form(
            key: _formkey,
            child: ListView(
              shrinkWrap: true,
              padding: EdgeInsets.symmetric(horizontal: 20),
              children: [
                SizedBox(height: height * 0.20),
                Center(
                  child: Container(
                    child: Image.asset('assets/images/logo_cendrassos.png'),
                    width: width * 0.8,
                  ),
                ),
                SizedBox(height: height * 0.1),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: width / 15),
                  child: TextFormField(
                      controller: _usernameController,
                      keyboardType: TextInputType.name,
                      decoration: InputDecoration(
                        labelText: 'Usuari',
                        labelStyle:
                            TextStyle(color: Theme.of(context).primaryColor),
                        hintText: 'Entreu el nom d\'usuari',
                      ),
                      validator: (valor) => _isNotNull(valor)),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: width / 15),
                  child: TextFormField(
                    obscureText: true,
                    controller: _passwordController,
                    decoration: InputDecoration(
                        labelText: 'Contrasenya',
                        labelStyle:
                            TextStyle(color: Theme.of(context).primaryColor),
                        hintText: 'Entreu la contrasenya'),
                    validator: (valor) =>
                        _isNotNull(valor), //Function to check validation
                  ),
                ),
                SizedBox(height: height * 0.05),
                Container(
                  width: width,
                  padding: EdgeInsets.symmetric(vertical: 15),
                  alignment: Alignment.center,
                  child: ElevatedButton(
                      child: Text(
                        'Inicia la sessió',
                        //style: TextStyle(fontSize: buttonFontSize),
                      ),
                      onPressed: () async {
                        if (_formkey.currentState!.validate()) {
                          var x = await _login(context);
                          if (x.isLogged == DjauStatus.Loaded) {
                            Navigator.pop(context);
                            Navigator.pushNamed(context, '/dashboard');
                          } else {
                            showAlertPopup(
                              context,
                              "ERROR",
                              x.errorMessage,
                            );
                          }
                        }
                      }),
                ),
                TextButton(
                    child: Text(
                      'recuperar l\'accés',
                    ),
                    onPressed: () async {
                      var url = recuperarUrl;
                      if (await canLaunch(url)) {
                        await launch(url);
                      } else {
                        showAlertPopup(
                          context,
                          "No s'obre el navegador",
                          "Intenteu anar manualment a $djauUrl per recuperar la contrasenya",
                        );
                      }
                    }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
