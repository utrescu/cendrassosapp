import 'package:cendrassos/config_cendrassos.dart';
import 'package:cendrassos/models/perfil.dart';
import 'package:cendrassos/providers/djau.dart';
import 'package:cendrassos/screens/components/app_menu_bar.dart';
import 'package:cendrassos/screens/components/helpers.dart';
import 'package:cendrassos/screens/users_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProfilePage extends StatelessWidget {
  static const routeName = '/profile';

  const ProfilePage({Key? key}) : super(key: key);

  Widget redText(String text, TextStyle? estil) {
    return Text(
      text,
      style: estil,
    );
  }

  Widget responsableColumn(context, String nom, String email, String telefon) {
    return Column(
      children: [
        Container(
          child: redText(nom, Theme.of(context).textTheme.headlineSmall),
        ),
        const Divider(
          indent: 20,
          endIndent: 20,
        ),
        ListTile(
          leading: Icon(
            Icons.email,
            color: Theme.of(context).primaryColor,
          ),
          title: redText(email, Theme.of(context).textTheme.bodyText1),
        ),
        ListTile(
          leading: Icon(
            Icons.phone,
            color: Theme.of(context).colorScheme.primary,
          ),
          title: redText(telefon, Theme.of(context).textTheme.bodyText1),
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
                    backgroundImage:
                        const AssetImage('assets/images/student.png'),
                    backgroundColor: Theme.of(context).primaryColor,
                  ),
                ]),
          ],
        ),
        Center(
          child: redText(dades.grup, Theme.of(context).textTheme.headlineSmall),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Column(children: [
            ListTile(
              leading: Icon(
                Icons.cake,
                color: Theme.of(context).primaryColor,
              ),
              title: redText(
                  dades.datanaixement, Theme.of(context).textTheme.bodyText1),
            ),
            ListTile(
              leading: Icon(
                Icons.home,
                color: Theme.of(context).colorScheme.primary,
              ),
              title:
                  redText(dades.adreca, Theme.of(context).textTheme.bodyText1),
            ),
            ListTile(
              leading: Icon(
                Icons.phone,
                color: Theme.of(context).colorScheme.primary,
              ),
              title:
                  redText(dades.telefon, Theme.of(context).textTheme.bodyText1),
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
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              const SizedBox(
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
                        errorMessage: '$errorCarregant: ${snapshot.error}',
                        textBoto: missatgeOk,
                        onRetryPressed: () => Navigator.pop(context),
                      );
                    } else {
                      return const Loading(
                          loadingMessage: missatgeCarregantDades);
                    }
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
