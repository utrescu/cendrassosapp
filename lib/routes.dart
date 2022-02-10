import 'package:cendrassos/cendrassos_theme.dart';
import 'package:cendrassos/models/djau.dart';
import 'package:cendrassos/screens/dashboard.dart';
import 'package:cendrassos/screens/login_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Routes {
  final String? initialRoute;

  var routes = {
    LoginPage.routeName: (context) => LoginPage(),
    Dashboard.routeName: (context) => Dashboard(),
  };

  Routes({this.initialRoute}) {
    runApp(MultiProvider(
      providers: [
        // ChangeNotifierProvider(create: (_)=> CurrentLanguage("ca"))),
        ChangeNotifierProvider(create: (_) => DjauModel()),
        Provider<BuildContext>(create: (c) => c),
      ],
      child: new MaterialApp(
          title: "Institut Cendrassos",
          theme: cendrassosTheme,
          debugShowCheckedModeBanner: false,
          initialRoute: initialRoute,
          routes: routes),
    ));
  }
}
