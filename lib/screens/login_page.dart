import 'package:cendrassos/config_cendrassos.dart';
import 'package:cendrassos/providers/djau.dart';
import 'package:cendrassos/utils/global_navigator.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class LoginPage extends StatefulWidget {
  static const routeName = '/login';

  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formkey = GlobalKey<FormState>();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

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
              padding: const EdgeInsets.symmetric(horizontal: 20),
              children: [
                SizedBox(height: height * 0.20),
                Center(
                  child: SizedBox(
                    width: width * 0.8,
                    child: Image.asset('assets/images/logo_cendrassos.png'),
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
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  alignment: Alignment.center,
                  child: ElevatedButton(
                      child: const Text(
                        'Inicia la sessió',
                      ),
                      onPressed: () async {
                        if (_formkey.currentState!.validate()) {
                          var x = await _login(context);
                          if (mounted) {
                            gotoDashboard(x, context);
                          }
                        }
                      }),
                ),
                TextButton(
                    child: const Text(
                      'recuperar l\'accés',
                    ),
                    onPressed: () async {
                      var url = Uri.parse(recuperarUrl);
                      if (await canLaunchUrl(url)) {
                        await launchUrl(url);
                      } else {
                        () async {
                          GlobalNavigator.showAlertPopup(
                            "No s'obre el navegador",
                            "Intenteu anar manualment a $baseUrl per recuperar la contrasenya",
                          );
                        };
                      }
                    }),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void gotoDashboard(LoginResult x, BuildContext context) {
    if (x.isLogged == DjauStatus.loaded) {
      GlobalNavigator.forgetAndGo('/dashboard');
    } else {
      GlobalNavigator.showAlertPopup(
        x.errorType,
        x.errorMessage,
      );
    }
  }
}
