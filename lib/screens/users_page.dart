import '../config_cendrassos.dart';
import 'components/helpers.dart';
import 'components/alumne_item.dart';
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
    _users.value.remove(username);
    final djau = Provider.of<DjauModel>(context, listen: false);
    await djau.deleteAlumne(username);
    var usuaris = await djau.getAlumnes();
    if (usuaris.isEmpty) {
      // No hi ha cap alumne, torna al registre
      GlobalNavigator.gotoNewAlumneWithPop();
    }
  }

  void gotoNewAlumne() {
    GlobalNavigator.gotoNewAlumne();
  }

  void _gotoDashboard(BuildContext context, String username) async {
    final djau = Provider.of<DjauModel>(context, listen: false);
    var result = await djau.loadAlumne(username);
    if (result.isLogged == DjauStatus.loaded) {
      // No sé si fer popuntil
      GlobalNavigator.go(Dashboard.routeName);
    } else {
      // No volen distingir els tipus d'errors
      GlobalNavigator.showAlertPopup(result.errorType, result.errorMessage);
    }
  }

  @override
  Widget build(BuildContext context) {
    final currentLogin = context.watch<DjauModel>();
    var nom = currentLogin.alumne.nom;
    var currentusername = currentLogin.alumne.username;

    if (_users.value.isEmpty) {
      loadData(context);
    }

    return Scaffold(
      appBar: AppMenuBar(nom: nom, haveleading: true, gotoUserPage: null),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Anar a pàgina de login per afegir un alumne nou
          // Fa pop. Ok?
          gotoNewAlumne();
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
            ? ListView.separated(
                itemCount: _users.value.length,
                itemBuilder: (context, index) {
                  String username = _users.value.keys.elementAt(index);
                  var nom = _users.value[username];

                  return Dismissible(
                    direction: DismissDirection.endToStart,
                    background: Container(
                      alignment: AlignmentDirectional.centerEnd,
                      color: Theme.of(context).primaryColorDark,
                      child: const Padding(
                        padding: EdgeInsets.fromLTRB(0.0, 0.0, 10.0, 0.0),
                        child: Icon(Icons.delete, color: Colors.white),
                      ),
                    ),
                    key: Key(username),
                    onDismissed: (direction) {
                      _deleteAlumne(context, username);
                      ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text("$missatgeEliminant $nom")));
                    },
                    child: AlumneItem(
                      username: username,
                      nom: nom ?? "...",
                      enabled: username == currentusername,
                      tryToGotoDashboard: _gotoDashboard,
                    ),
                  );
                },
                separatorBuilder: (context, index) {
                  return const Divider();
                },
              )
            : const Loading(
                loadingMessage: missatgeCarregantDades,
              ),
      ),
    );
  }
}
