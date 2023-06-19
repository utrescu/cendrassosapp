import 'package:cendrassos/screens/profile_page.dart';
import 'package:flutter/material.dart';

class AppMenuBar extends StatelessWidget implements PreferredSizeWidget {
  final String nom;
  final bool haveleading;
  final VoidCallback? gotoUserPage;

  const AppMenuBar(
      {Key? key,
      required this.nom,
      required this.haveleading,
      required this.gotoUserPage})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: haveleading,
      title: Text(
        nom,
      ),
      actions: [
        IconButton(
          icon: const Icon(Icons.account_circle_rounded),
          disabledColor: Theme.of(context).disabledColor,
          onPressed: enableProfileButton(
              context, ModalRoute.of(context)?.settings.name, {'nom': nom}),
        ),
        IconButton(
          icon: const Icon(Icons.switch_account),
          disabledColor: Theme.of(context).disabledColor,
          onPressed: gotoUserPage,
        )
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  VoidCallback? enableProfileButton(
      context, String? currentRoute, Map<String, String> arguments) {
    if (currentRoute != ProfilePage.routeName) {
      return () => Navigator.of(context)
          .pushNamed(ProfilePage.routeName, arguments: arguments);
    }
    return null;
  }
}
