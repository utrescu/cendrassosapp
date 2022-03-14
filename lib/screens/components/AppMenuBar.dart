import 'package:cendrassos/cendrassos_theme.dart';
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
