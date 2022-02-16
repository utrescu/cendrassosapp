import 'package:cendrassos/cendrassos_theme.dart';
import 'package:cendrassos/screens/Error.dart';
import 'package:cendrassos/screens/loading_page.dart';
import 'package:cendrassos/screens/login_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/djau.dart';

class UsersPage extends StatelessWidget {
  static const routeName = '/users';

  const UsersPage({Key? key}) : super(key: key);

  Future<Map<String, String>> loadData(BuildContext context) async {
    final djau = Provider.of<DjauModel>(context, listen: false);
    return await djau.getAlumnes();
  }

  @override
  Widget build(BuildContext context) {
    final currentLogin = context.watch<DjauModel>();
    var nom = currentLogin.alumne.nom;
    var username = currentLogin.alumne.username;

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          'Alumne: $nom',
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.account_box),
            disabledColor: secondaryColorDark,
            onPressed: null,
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Anar a pàgina de login per afegir un alumne nou
          // He de fer pop?
          Navigator.pushNamed(context, LoginPage.routeName);
        },
        backgroundColor: primaryColor,
        child: Icon(
          Icons.add,
          color: secondaryColor,
        ),
      ),
      body: FutureBuilder(
        future: loadData(context),
        builder: (context, AsyncSnapshot<Map<String, String>> snapshot) =>
            snapshot.hasData
                ? GridView.count(
                    crossAxisCount: 3,
                    mainAxisSpacing: 8,
                    crossAxisSpacing: 8,
                    padding: EdgeInsets.all(8),
                    children: snapshot.data!.entries
                        .map((item) => _UserItem(
                            username: item.key,
                            nom: item.value,
                            enabled: item.key == username))
                        .toList(),
                  )
                : Loading(
                    loadingMessage: "Carregant",
                  ),
      ),
    );
  }
}

class _UserItem extends StatelessWidget {
  const _UserItem(
      {Key? key,
      required this.username,
      required this.nom,
      required this.enabled})
      : super(key: key);

  final String username;
  final String nom;
  final bool enabled;

  @override
  Widget build(BuildContext context) {
    return GridTile(
      child: GestureDetector(
        onTap: () {
          if (enabled) {
            Navigator.pop(context);
          } else {
            gotoAlumne(context, username);
          }
        },
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: primaryColor,
              width: 2.0,
            ),
            // gradient: LinearGradient(
            //   colors: [primaryColor, primaryColorLight],
            // ),
          ),
          child: Center(
            child: Padding(
              padding: EdgeInsets.all(5),
              child: Text(
                nom,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: primaryColor,
                  fontSize: titleFontSize,
                ),
              ),
            ),
          ),
        ),
      ),
      footer: GridTileBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Icon(
              enabled ? Icons.check_circle : null,
              color: primaryColor,
            ),
          ],
        ),
        // backgroundColor: Colors.black45,
      ),
      // header: GridTileBar(
      //   backgroundColor: primaryColorDark,
      //   title: Center(
      //     child: Text(
      //       item.value,
      //       style: TextStyle(
      //         color: secondaryColor,
      //         fontSize: defaultFontSize,
      //       ),
      //     ),
      //   ),
      // ),
    );
  }

  void gotoAlumne(context, String username) async {
    final djau = Provider.of<DjauModel>(context, listen: false);
    await djau.setDefaultAlumne(username);
    Navigator.pop(context);
    Navigator.pushNamed(context, LoadingPage.routeName);
  }
}
