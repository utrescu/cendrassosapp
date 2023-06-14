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
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Card(
        color: Theme.of(context).cardColor,
        elevation: 3.0,
        clipBehavior: Clip.antiAlias,
        child: Column(
          children: [
            GestureDetector(
              onTap: () => tryToGotoDashboard(context, username),
              child: alumneItemContent(context),
            ),
            Container(
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
              ),
              child: ButtonBar(
                alignment: MainAxisAlignment.end,
                children: [
                  IconButton(
                    icon: Icon(
                      Icons.delete,
                      color: Theme.of(context).colorScheme.onPrimary,
                    ),
                    onPressed: () => deleteItem(context, username),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget alumneItemContent(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.20,
            child: Padding(
              padding: const EdgeInsets.all(10),
              child:
                  Image.asset('assets/images/student2.png', fit: BoxFit.cover),
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width * 0.6,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 3.0),
              child: Text(nom,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.titleLarge),
            ),
          ),
        ],
      ),
    );
  }
}
