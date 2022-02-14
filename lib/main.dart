import 'package:cendrassos/routes.dart';
import 'package:cendrassos/screens/loading_page.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/date_symbol_data_local.dart';

SharedPreferences? prefs;
Future<void> main() async {
  String initialRoute = LoadingPage.routeName;

  initializeDateFormatting()
      .then((_) => new Routes(initialRoute: initialRoute));
}
