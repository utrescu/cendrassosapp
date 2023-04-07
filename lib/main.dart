import 'dart:io';

import 'package:background_fetch/background_fetch.dart';
import 'package:cendrassos/routes.dart';
import 'package:cendrassos/screens/loading_page.dart';
import 'package:cendrassos/services/background_tasks.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;
import 'package:flutter_timezone/flutter_timezone.dart';
// import 'package:shared_preferences_android/shared_preferences_android.dart';
// import 'package:shared_preferences_ios/shared_preferences_ios.dart';

@pragma('vm:entry-point')
void backgroundFetchHeadlessTask(HeadlessTask task) async {
  // if (Platform.isAndroid) {
  //       SharedPreferencesAndroid.registerWith();}
  // if (Platform.isIOS) {
  //   SharedPreferencesIOS.registerWith();
  // }

  // v.2.11
  // DartPluginRegistrant.ensureInitialized();

  String taskId = task.taskId;
  bool isTimeout = task.timeout;
  if (isTimeout) {
    // This task has exceeded its allowed running-time.
    // You must stop what you're doing and immediately .finish(taskId)
    debugPrint("[BackgroundFetch] Headless task timed-out: $taskId");
    BackgroundFetch.finish(taskId);
    return;
  }
  debugPrint('[BackgroundFetch] Headless event received.');

  // Do your work here...
  var tasca = BackgroundTask();
  await tasca.checkNewNotificacions(onNotification);

  BackgroundFetch.finish(taskId);
}

void onNotification(String? payload) async {
  // TODO: Posar el payload a defaultuser

  Routes(initialRoute: LoadingPage.routeName);
}

Future<void> _configureLocalTimeZone() async {
  if (kIsWeb || Platform.isLinux) {
    return;
  }
  tz.initializeTimeZones();
  final String timeZoneName = await FlutterTimezone.getLocalTimezone();
  tz.setLocalLocation(tz.getLocation(timeZoneName));
}

Future<void> main() async {
  String initialRoute = LoadingPage.routeName;

  WidgetsFlutterBinding.ensureInitialized();

  await _configureLocalTimeZone();

  initializeDateFormatting().then((_) => {Routes(initialRoute: initialRoute)});
}
