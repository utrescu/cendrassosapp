import 'dart:io';

import 'package:background_fetch/background_fetch.dart';
import 'package:cendrassos/cendrassos_theme.dart';
import 'package:cendrassos/providers/djau.dart';
import 'package:cendrassos/screens/dashboard_page.dart';
import 'package:cendrassos/screens/loading_page.dart';
import 'package:cendrassos/screens/login_page.dart';
import 'package:cendrassos/screens/profile_page.dart';
import 'package:cendrassos/screens/scanqr_page.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'screens/register_page.dart';
import 'package:cendrassos/screens/users_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'config_cendrassos.dart';
import 'main.dart';
import 'navitator_key.dart';

class Routes {
  final String? initialRoute;

  var routes = {
    RegisterPage.routeName: (context) => const RegisterPage(),
    ScanqrPage.routeName: (context) => const ScanqrPage(),
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
          title: nomInstitut,
          localizationsDelegates: const [
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          locale: const Locale("ca", "ES"),
          supportedLocales: const [
            Locale("ca", "ES"),
          ],
          theme: cendrassosTheme,
          debugShowCheckedModeBanner: false,
          navigatorKey: navigatorKey,
          initialRoute: initialRoute,
          routes: routes),
    ));

    if (Platform.isAndroid || Platform.isIOS) {
      BackgroundFetch.registerHeadlessTask(backgroundFetchHeadlessTask);
    }
  }
}
