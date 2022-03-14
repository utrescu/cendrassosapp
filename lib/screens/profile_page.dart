import 'package:cendrassos/cendrassos_theme.dart';
import 'package:cendrassos/screens/components/AppMenuBar.dart';
import 'package:cendrassos/screens/users_page.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  static const routeName = '/profile';

  const ProfilePage({Key? key}) : super(key: key);

  Widget redText(String text, double size) {
    return Text(
      text,
      style: TextStyle(
        fontSize: size,
        color: primaryColor,
      ),
    );
  }

  Widget responsableCard(String nom, String email, String telefon) {
    return Card(
      elevation: 4.0,
      color: secondaryColor,
      shadowColor: primaryColorLight,
      child: Column(
        children: [
          Container(
            child: redText(nom, buttonFontSize),
          ),
          Divider(
            indent: 20,
            endIndent: 20,
          ),
          ListTile(
            title: Center(child: redText("email", defaultFontSize)),
            subtitle: Center(
              child: Text(email),
            ),
          ),
          ListTile(
            title: Center(child: redText("telèfon", defaultFontSize)),
            subtitle: Center(
              child: Text(telefon),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final arguments = (ModalRoute.of(context)?.settings.arguments ??
        <String, dynamic>{}) as Map;

    return Scaffold(
      appBar: AppMenuBar(
        nom: arguments['nom'],
        haveleading: true,
        gotoUserPage: () =>
            {Navigator.of(context).pushNamed(UsersPage.routeName)},
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              SizedBox(
                height: 20,
              ),
              Card(
                color: secondaryColor,
                shadowColor: primaryColorLight,
                child: Column(
                  children: [
                    Text(
                      "Curs: 1r ESO A",
                      style: TextStyle(
                        fontSize: titleFontSize,
                        color: primaryColor,
                      ),
                    ),
                    Divider(
                      indent: 20,
                      endIndent: 20,
                    ),
                    ListTile(
                      title: Center(
                        child: redText("data de naixement", defaultFontSize),
                      ),
                      subtitle: Center(
                        child: Text("27/2/2009"),
                      ),
                    ),
                    ListTile(
                      title: Center(
                        child: redText("adreça", defaultFontSize),
                      ),
                      subtitle: Center(
                        child: Text("C\ del pecat, 23 - 2n A"),
                      ),
                    ),
                    ListTile(
                      title: Center(
                        child: redText("telèfon", defaultFontSize),
                      ),
                      subtitle: Center(
                        child: Text("666000666"),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 10,
              ),
              responsableCard("Manuel Garcia Pimiento", "pepet@cendrassos.net",
                  "600666666"),
              responsableCard(
                  "Filomena Pi Boronat", "filo@cendrassos.net", "972505050")
            ],
          ),
        ),
      ),
    );
  }
}
