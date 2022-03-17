import 'package:cendrassos/cendrassos_theme.dart';
import 'package:cendrassos/config_cendrassos.dart';
import 'package:cendrassos/models/Perfil.dart';
import 'package:cendrassos/providers/djau.dart';
import 'package:cendrassos/screens/components/AppMenuBar.dart';
import 'package:cendrassos/screens/components/Error.dart';
import 'package:cendrassos/screens/users_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProfilePage extends StatelessWidget {
  static const routeName = '/profile';

  const ProfilePage({Key? key}) : super(key: key);

  Widget redText(context, String text, double size, {bool weight = false}) {
    return Text(
      text,
      style: TextStyle(
          fontSize: size,
          color: Theme.of(context).colorScheme.primary,
          fontWeight: weight == true ? FontWeight.bold : FontWeight.normal),
    );
  }

  Widget responsableColumn(context, String nom, String email, String telefon) {
    return Column(
      children: [
        Container(
          child: redText(context, nom, buttonFontSize, weight: true),
        ),
        Divider(
          indent: 20,
          endIndent: 20,
        ),
        ListTile(
          leading: Icon(
            Icons.email,
            color: Theme.of(context).colorScheme.primary,
          ),
          title: redText(context, email, defaultFontSize),
        ),
        ListTile(
          leading: Icon(
            Icons.phone,
            color: Theme.of(context).colorScheme.primary,
          ),
          title: redText(context, telefon, defaultFontSize),
        ),
      ],
    );
  }

  Widget showData(context, Perfil dades) {
    return Column(
      children: <Widget>[
        Stack(
          clipBehavior: Clip.none,
          alignment: Alignment.bottomCenter,
          children: [
            Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  CircleAvatar(
                    radius: 50,
                    backgroundImage: AssetImage('assets/images/student.png'),
                    backgroundColor: Theme.of(context).primaryColor,
                  ),
                ]),
          ],
        ),
        Center(
          child: redText(context, dades.grup,
              Theme.of(context).textTheme.headline5?.fontSize ?? 20),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 30),
          child: Column(children: [
            ListTile(
              leading: Icon(
                Icons.cake,
                color: Theme.of(context).colorScheme.primary,
              ),
              title: redText(context, dades.datanaixement, defaultFontSize),
            ),
            ListTile(
              leading: Icon(
                Icons.home,
                color: Theme.of(context).colorScheme.primary,
              ),
              title: redText(context, dades.adreca, defaultFontSize),
            ),
            ListTile(
              leading: Icon(
                Icons.phone,
                color: Theme.of(context).colorScheme.primary,
              ),
              title: redText(context, dades.telefon, defaultFontSize),
            ),
          ]),
        ),
        Card(
          elevation: 4.0,
          color: Theme.of(context).colorScheme.background,
          shadowColor: Theme.of(context).primaryColorLight,
          child: Column(
              children: dades.responsables
                  .map((element) => responsableColumn(
                        context,
                        element.nom,
                        element.mail,
                        element.telefon,
                      ))
                  .toList()),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final djau = Provider.of<DjauModel>(context, listen: false);

    final arguments = (ModalRoute.of(context)?.settings.arguments ??
        <String, dynamic>{}) as Map;

    return Scaffold(
      appBar: AppMenuBar(
        nom: arguments['nom'],
        haveleading: true,
        gotoUserPage: () =>
            {Navigator.of(context).pushNamed(UsersPage.routeName)},
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              SizedBox(
                height: 10,
              ),
              FutureBuilder<Perfil>(
                  future: djau.loadPerfil(),
                  builder:
                      (BuildContext build, AsyncSnapshot<Perfil> snapshot) {
                    if (snapshot.connectionState == ConnectionState.done &&
                        snapshot.hasData) {
                      return showData(context, snapshot.data as Perfil);
                    } else if (snapshot.connectionState ==
                            ConnectionState.done &&
                        snapshot.hasError) {
                      return ErrorRetry(
                        errorMessage: ErrorCarregant,
                        textBoto: MissatgeOk,
                        onRetryPressed: () => Navigator.pop(context),
                      );
                    } else {
                      return Loading(loadingMessage: MissatgeCarregantDades);
                    }
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
