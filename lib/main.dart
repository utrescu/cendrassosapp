import 'package:background_fetch/background_fetch.dart';
import 'package:cendrassos/routes.dart';
import 'package:cendrassos/screens/loading_page.dart';
import 'package:cendrassos/services/background_tasks.dart';
import 'package:intl/date_symbol_data_local.dart';

void backgroundFetchHeadlessTask(HeadlessTask task) async {
  String taskId = task.taskId;
  bool isTimeout = task.timeout;
  if (isTimeout) {
    // This task has exceeded its allowed running-time.
    // You must stop what you're doing and immediately .finish(taskId)
    print("[BackgroundFetch] Headless task timed-out: $taskId");
    BackgroundFetch.finish(taskId);
    return;
  }
  print('[BackgroundFetch] Headless event received.');

  // Do your work here...
  var tasca = BackgroundTask();
  await tasca.checkNewNotificacions();

  BackgroundFetch.finish(taskId);
}

Future<void> main() async {
  String initialRoute = LoadingPage.routeName;

  initializeDateFormatting().then((_) => {Routes(initialRoute: initialRoute)});
}
