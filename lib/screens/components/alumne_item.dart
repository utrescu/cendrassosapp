import 'package:cendrassos/config_cendrassos.dart';
import 'package:flutter/material.dart';

typedef DeleteAlumneCallBack = void Function(
    BuildContext context, String username);

typedef TryLoginCallBack = void Function(BuildContext context, String username);

class AlumneItem extends StatelessWidget {
  const AlumneItem(
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
    return Dismissible(
      direction: DismissDirection.endToStart,
      key: Key(username),
      background: Container(
        alignment: AlignmentDirectional.centerEnd,
        color: Theme.of(context).primaryColorDark,
        child: const Padding(
          padding: EdgeInsets.fromLTRB(0.0, 0.0, 10.0, 0.0),
          child: Icon(Icons.delete, color: Colors.white),
        ),
      ),
      onDismissed: (direction) {
        deleteItem(context, username);
      },
      child: GestureDetector(
        onTap: () => tryToGotoDashboard(context, username),
        child: alumneItemContent(context),
      ),
    );
  }

  Widget alumneItemContent(BuildContext context) {
    return ListTile(
      tileColor: Theme.of(context).cardColor,
      leading: Padding(
        padding: const EdgeInsets.all(10),
        child: Image.asset('assets/images/student2.png', fit: BoxFit.cover),
      ),
      title: Text(
        nom,
        textAlign: TextAlign.left,
        style: Theme.of(context).textTheme.titleLarge,
      ),
      subtitle: const Text(nomInstitut),
      trailing: enabled
          ? Icon(
              Icons.check_circle,
              color: Theme.of(context).primaryColor,
            )
          : Icon(
              Icons.circle_outlined,
              color: Theme.of(context).disabledColor,
            ),
    );

  }
}
