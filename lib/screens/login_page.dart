import 'package:cendrassos/cendrassos_theme.dart';
import 'package:cendrassos/providers/djau.dart';
import 'package:cendrassos/utils/popup.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatelessWidget {
  static const routeName = '/login';
  static const NEEDUSERNAME = "Cal el codi de l'alumne";
  static const NEEDPASSWORD = 'Cal omplir la paraula de pas';

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
        validator: (val) => val == null || val.isEmpty ? NEEDPASSWORD : null,
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
        validator: (val) => val == null || val.isEmpty ? NEEDPASSWORD : null,
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
          onPressed: () async {
            var x = await login(context);
            if (x.isLogged) {
              Navigator.pop(context);
              Navigator.pushNamed(context, '/dashboard');
            } else {
              showAlertPopup(
                context,
                "ERROR",
                x.errorMessage,
              );
            }
          }),
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

  Future<LoginResult> login(BuildContext context) async {
    var loginCall = context.read<DjauModel>();

    var result =
        await loginCall.login(usernameController.text, passwordController.text);
    return result;
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    usernameController.dispose();
    passwordController.dispose();
  }
}
