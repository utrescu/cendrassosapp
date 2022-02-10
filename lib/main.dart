import 'package:cendrassos/routes.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'screens/login_page.dart';
import 'package:intl/date_symbol_data_local.dart';

final _storage = const FlutterSecureStorage();

void main() async {
  String initialRoute = LoginPage.routeName;

  initializeDateFormatting()
      .then((_) => new Routes(initialRoute: initialRoute));
}
