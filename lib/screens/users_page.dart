import '../config_cendrassos.dart';
import 'components/helpers.dart';
import 'dashboard_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/djau.dart';
import '../utils/global_navigator.dart';
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
      // No hi ha cap alumne, torna al registre
      gotoRegister();
    }
    _users.value = usuaris;
  }

  void gotoRegister() {
    GlobalNavigator.gotoRegister();
  }

  void _gotoDashboard(BuildContext context, String username) async {
    final djau = Provider.of<DjauModel>(context, listen: false);
    var result = await djau.loadAlumne(username);
    if (result.isLogged == DjauStatus.loaded) {
      // No sé si fer popuntil
      GlobalNavigator.go(Dashboard.routeName);
    } else {
      // No volen distingir els tipus d'errors
      GlobalNavigator.showAlertPopup("ERROR", result.errorMessage);
    }
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
          // Fa pop. Ok?
          gotoRegister();
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
            ? ListView(
                children: value.keys
                    .map(
                      (item) => UserItem(
                        nom: value[item] ?? "",
                        username: item,
                        enabled: item == username,
                        deleteItem: _deleteAlumne,
                        tryToGotoDashboard: _gotoDashboard,
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

typedef TryLoginCallBack = void Function(BuildContext context, String username);

class UserItem extends StatelessWidget {
  const UserItem(
      {Key? key,
      required this.username,
      required this.nom,
      required this.enabled,
      required this.deleteItem,
      required this.tryToGotoDashboard})
      : super(key: key);

  final String username;
  final String nom;
  final bool enabled;
  final DeleteAlumneCallBack deleteItem;
  final TryLoginCallBack tryToGotoDashboard;

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Theme.of(context).primaryColorLight.withOpacity(0.5),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(width: 1),
        ),
        child: Column(
          children: [
            Row(
              children: [
                Container(
                  height: MediaQuery.of(context).size.height * 0.15 -
                      2 * spaceAroundCells,
                  width: MediaQuery.of(context).size.width * 0.25 -
                      2 * spaceAroundCells,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/images/student2.png'),
                      fit: BoxFit.fitWidth,
                    ),
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(nom,
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.titleMedium),
                    const SizedBox(height: 2),
                  ],
                ),
              ],
            ),
          ],
        ));
  }
}
