import 'package:cendrassos/cendrassos_theme.dart';
import 'package:cendrassos/models/djau.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatelessWidget {
  static const routeName = '/login';

  LoginPage({Key? key}) : super(key: key);

  TextEditingController usernameController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    final titol = Padding(
        padding: EdgeInsets.only(left: 15, bottom: 10),
        child: Text(
          "Identificació",
          textAlign: TextAlign.left,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(fontSize: titleFontSize),
        ));

    final logo = Padding(
      padding: EdgeInsets.all(20),
      child: Hero(
          tag: 'hero',
          child: CircleAvatar(
            radius: 56.0,
            child: Image.asset('images/logo_cendrassos.png'),
            backgroundColor: secondaryColor,
          )),
    );

    final inputUsername = Padding(
      padding: EdgeInsets.only(bottom: 10),
      child: TextFormField(
        // textAlign: TextAlign.center,
        textDirection: TextDirection.ltr,
        controller: usernameController,
        keyboardType: TextInputType.name,
        decoration: InputDecoration(
          hintText: 'Nom d\'usuari',
          contentPadding: EdgeInsets.symmetric(horizontal: 25, vertical: 20),
        ),
      ),
    );

    final inputPassword = Padding(
      padding: EdgeInsets.only(bottom: 20),
      child: TextFormField(
        controller: passwordController,
        textDirection: TextDirection.ltr,
        keyboardType: TextInputType.text,
        obscureText: true,
        decoration: InputDecoration(
          hintText: 'Paraula de pas',
          contentPadding: EdgeInsets.symmetric(horizontal: 25, vertical: 20),
        ),
      ),
    );

    final buttonLogin = Container(
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.symmetric(vertical: 15),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(5)),
        boxShadow: <BoxShadow>[
          BoxShadow(
              color: secondaryColor,
              offset: Offset(2, 4),
              blurRadius: 5,
              spreadRadius: 2)
        ],
      ),
      child: ElevatedButton(
        child: Text(
          'Inicia la sessió',
          style: TextStyle(fontSize: buttonFontSize),
        ),
        onPressed: () =>
            login(context) ? null : Navigator.pushNamed(context, '/dashboard'),
      ),
    );

    final buttonForgotPassword = TextButton(
        child: Text(
          'Obtenir o recuperar l\'accés',
        ),
        onPressed: null);

    return SafeArea(
        child: Scaffold(
      body: Center(
        child: ListView(
          shrinkWrap: true,
          padding: EdgeInsets.symmetric(horizontal: 20),
          children: <Widget>[
            logo,
            titol,
            inputUsername,
            inputPassword,
            buttonLogin,
            buttonForgotPassword
          ],
        ),
      ),
    ));
  }

  login(BuildContext context) {
    var loginCall = context.read<DjauModel>();

    loginCall.login(usernameController.text, passwordController.text);
    return loginCall.isLogged();
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    usernameController.dispose();
    passwordController.dispose();
  }
}
