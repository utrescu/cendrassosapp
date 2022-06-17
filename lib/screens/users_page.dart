import 'package:cendrassos/screens/components/helpers.dart';
import 'package:cendrassos/screens/dashboard_page.dart';
import 'package:cendrassos/screens/login_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../cendrassos_theme.dart';
import '../providers/djau.dart';
import 'components/app_menu_bar.dart';

const spaceAroundCells = 10.0;

class UsersPage extends StatelessWidget {
  static const routeName = '/users';
  final ValueNotifier<Map<String, String>> _users =
      ValueNotifier<Map<String, String>>({});

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
      // No hi ha cap alumne, torna a fer login
      gotoLogin(context);
    }
    _users.value = usuaris;
  }

  void gotoLogin(BuildContext context) {
    Navigator.of(context).popUntil((route) => route.isFirst);
    Navigator.of(context).pushNamed(LoginPage.routeName);
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
      appBar: AppMenuBar(nom: nom, haveleading: true, gotoUserPage: null),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Anar a pàgina de login per afegir un alumne nou
          // He de fer pop?
          Navigator.pushNamed(context, LoginPage.routeName);
        },
        backgroundColor: Theme.of(context).primaryColor,
        child: Icon(
          Icons.add,
          color: Theme.of(context).colorScheme.onPrimary,
        ),
      ),
      body: ValueListenableBuilder<Map<String, String>>(
        valueListenable: _users,
        builder: (context, value, _) => value.isNotEmpty
            ? GridView.count(
                crossAxisCount: 2,
                crossAxisSpacing: spaceAroundCells,
                mainAxisSpacing: spaceAroundCells,
                padding: const EdgeInsets.all(10),
                children: value.entries
                    .map(
                      (item) => UserItem(
                        username: item.key,
                        nom: item.value,
                        enabled: item.key == username,
                        deleteItem: _deleteAlumne,
                      ),
                    )
                    .toList(),
              )
            : const Loading(
                loadingMessage: missatgeCarregantDades,
              ),
      ),
    );
  }
}

typedef DeleteAlumneCallBack = void Function(
    BuildContext context, String username);

class UserItem extends StatelessWidget {
  const UserItem(
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
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: GridTile(
        footer: GridTileBar(
          backgroundColor: Theme.of(context).primaryColor,
          title: const Text(""),
          trailing: IconButton(
            icon: const Icon(
              Icons.delete,
              // color: Theme.of(context).colorScheme.primary,
            ),
            onPressed: () => deleteItem(context, username),
          ),
        ),
        child: GestureDetector(
          onTap: () {
            if (enabled) {
              Navigator.popUntil(
                  context, ModalRoute.withName(Dashboard.routeName));
            } else {
              gotoAlumne(context, username);
            }
          },
          child: gridContent(context),
        ),
      ),
    );
  }

  Widget gridContent(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: Theme.of(context).primaryColor,
          width: 2.0,
        ),
        color: enabled
            ? Theme.of(context).primaryColorLight.withOpacity(0.5)
            : Theme.of(context).colorScheme.onPrimary,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(
            height:
                MediaQuery.of(context).size.width * 0.25 - 2 * spaceAroundCells,
            child: Image.asset('assets/images/student2.png', fit: BoxFit.cover),
          ),
          Container(
            width:
                MediaQuery.of(context).size.width * 0.5 - 2 * spaceAroundCells,
            decoration: BoxDecoration(color: Colors.white.withOpacity(0.5)),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5.0),
              child: Text(nom,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.titleMedium),
            ),
          ),
        ],
      ),
    );
  }

  void gotoAlumne(context, String username) async {
    final djau = Provider.of<DjauModel>(context, listen: false);
    await djau.loadAlumne(username);
    Navigator.pushNamed(context, Dashboard.routeName);
  }
}
