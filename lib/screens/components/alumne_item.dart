import 'package:cendrassos/config_djau.dart';
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
      required this.tryToGotoDashboard})
      : super(key: key);

  final String username;
  final String nom;
  final bool enabled;
  final TryLoginCallBack tryToGotoDashboard;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () => tryToGotoDashboard(context, username),
        child: alumneItemContent(context),
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
      ),
      subtitle: const Text(nomInstitut),
      trailing: enabled
          ? Icon(
              Icons.check_circle,
              color: Theme.of(context).primaryColor,
            )
          : Icon(
              Icons.more_horiz,
              color: Theme.of(context).disabledColor,
            ),
    );
  }
}
