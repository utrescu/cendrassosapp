import 'package:cendrassos/cendrassos_theme.dart';
import 'package:cendrassos/screens/Error.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/djau.dart';

class UsersPage extends StatefulWidget {
  static const routeName = '/users';

  const UsersPage({Key? key}) : super(key: key);

  @override
  _UsersPageState createState() => _UsersPageState();
}

class _UsersPageState extends State<UsersPage> {
  late Map<String, String> _usuaris;

  @override
  void initState() {
    super.initState();
  }

  Future<Map<String, String>> loadData() async {
    final djau = Provider.of<DjauModel>(context, listen: false);
    var _usuaris = await djau.getAlumnes();
    return _usuaris;
  }

  @override
  Widget build(BuildContext context) {
    final currentLogin = context.watch<DjauModel>();
    var nom = currentLogin.alumne.nom;

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
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
      body: FutureBuilder(
        future: loadData(),
        builder: (context, AsyncSnapshot<Map<String, String>> snapshot) =>
            snapshot.hasData
                ? GridView.count(
                    crossAxisCount: 2,
                    padding: EdgeInsets.all(8),
                    children: snapshot.data!.values
                        .map(
                          (i) => GridTile(
                            child: Container(
                              child: Padding(
                                padding: EdgeInsets.all(30),
                                child: Image.asset(
                                  'assets/images/usuari.png',
                                  fit: BoxFit.fill,
                                ),
                              ),
                            ),
                            footer: GridTileBar(
                              backgroundColor: primaryColorDark,
                              title: Center(
                                child: Text(
                                  i,
                                  style: TextStyle(
                                    color: secondaryColor,
                                    fontSize: defaultFontSize,
                                  ),
                                ),
                              ),
                            ),
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
