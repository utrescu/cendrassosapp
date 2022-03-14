import 'package:cendrassos/cendrassos_theme.dart';
import 'package:cendrassos/screens/profile_page.dart';
import 'package:flutter/material.dart';

class AppMenuBar extends StatelessWidget with PreferredSizeWidget {
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
          icon: Icon(Icons.account_circle_rounded),
          disabledColor: secondaryColor,
          onPressed: () {
            if (ModalRoute.of(context)?.settings.name !=
                ProfilePage.routeName) {
              Navigator.of(context).pushNamed(
                ProfilePage.routeName,
                arguments: <String, String>{'nom': nom},
              );
            }
          },
        ),
        IconButton(
          icon: Icon(Icons.switch_account),
          disabledColor: secondaryColorDark,
          onPressed: gotoUserPage,
        )
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
