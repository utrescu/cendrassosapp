import 'package:cendrassos/routes.dart';
import 'screens/login_page.dart';
import 'package:intl/date_symbol_data_local.dart';

void main() async {
  String initialRoute = LoginPage.routeName;

  initializeDateFormatting()
      .then((_) => new Routes(initialRoute: initialRoute));
}
