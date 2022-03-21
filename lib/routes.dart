import 'dart:io';

import 'package:background_fetch/background_fetch.dart';
import 'package:cendrassos/cendrassos_theme.dart';
import 'package:cendrassos/providers/djau.dart';
import 'package:cendrassos/screens/dashboard_page.dart';
import 'package:cendrassos/screens/loading_page.dart';
import 'package:cendrassos/screens/login_page.dart';
import 'package:cendrassos/screens/profile_page.dart';
import 'package:cendrassos/screens/users_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'main.dart';

class Routes {
  final String? initialRoute;

  var routes = {
    LoginPage.routeName: (context) => const LoginPage(),
    Dashboard.routeName: (context) => const Dashboard(),
    LoadingPage.routeName: (context) => const LoadingPage(),
    UsersPage.routeName: (context) => UsersPage(),
    ProfilePage.routeName: (context) => const ProfilePage(),
  };

  Routes({this.initialRoute}) {
    runApp(MultiProvider(
      providers: [
        // ChangeNotifierProvider(create: (_)=> CurrentLanguage("ca"))),
        ChangeNotifierProvider(create: (_) => DjauModel()),
        Provider<BuildContext>(create: (c) => c),
      ],
      child: MaterialApp(
          title: "Institut Cendrassos",
          theme: cendrassosTheme,
          debugShowCheckedModeBanner: false,
          initialRoute: initialRoute,
          routes: routes),
    ));

    if (Platform.isAndroid || Platform.isIOS) {
      BackgroundFetch.registerHeadlessTask(backgroundFetchHeadlessTask);
    }
  }
}
