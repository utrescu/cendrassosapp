import 'package:cendrassos/cendrassos_theme.dart';
import 'package:cendrassos/screens/Error.dart';
import 'package:cendrassos/screens/login_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/djau.dart';

class UsersPage extends StatelessWidget {
  static const routeName = '/users';
  final ValueNotifier<Map<String, String>> _users =
      new ValueNotifier<Map<String, String>>({});

  UsersPage({Key? key}) : super(key: key);

  void loadData(BuildContext context) async {
    final djau = Provider.of<DjauModel>(context, listen: false);
    _users.value = await djau.getAlumnes();
  }

  void _deleteAlumne(BuildContext context, String username) async {
    final djau = Provider.of<DjauModel>(context, listen: false);
    await djau.deleteAlumne(username);
    var usuaris = await djau.getAlumnes();
    if (usuaris.isEmpty) {
      Navigator.of(context).popUntil((route) => route.isFirst);
      Navigator.of(context).pushNamed(LoginPage.routeName);
    }
    _users.value = usuaris;
  }

  @override
  Widget build(BuildContext context) {
    final currentLogin = context.watch<DjauModel>();
    var nom = currentLogin.alumne.nom;
    var username = currentLogin.alumne.username;

    if (_users.value.isEmpty) {
      loadData(context);
    }

    return Scaffold(
      appBar: AppBar(
        // automaticallyImplyLeading: false,
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
      body: ValueListenableBuilder<Map<String, String>>(
        valueListenable: _users,
        builder: (context, value, _) => value.isNotEmpty
            ? GridView.count(
                crossAxisCount: 2,
                mainAxisSpacing: 8,
                crossAxisSpacing: 8,
                padding: EdgeInsets.all(8),
                children: value.entries
                    .map(
                      (item) => _UserItem(
                        username: item.key,
                        nom: item.value,
                        enabled: item.key == username,
                        deleteItem: _deleteAlumne,
                      ),
                    )
                    .toList(),
              )
            : Loading(
                loadingMessage: "Carregant",
              ),
      ),
    );
  }
}

typedef DeleteAlumneCallBack = void Function(
    BuildContext context, String username);

class _UserItem extends StatelessWidget {
  const _UserItem(
      {Key? key,
      required this.username,
      required this.nom,
      required this.enabled,
      required this.deleteItem})
      : super(key: key);

  final String username;
  final String nom;
  final bool enabled;
  final DeleteAlumneCallBack deleteItem;

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
            IconButton(
              icon: Icon(
                Icons.delete,
                color: primaryColor,
              ),
              onPressed: () => deleteItem(context, username),
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
    if (!enabled) {
      final djau = Provider.of<DjauModel>(context, listen: false);
      await djau.loadAlumne(username);
    }
    Navigator.pop(context);
  }
}
