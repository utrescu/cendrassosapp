import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:background_fetch/background_fetch.dart';
import 'package:cendrassos/api/api_response.dart';
import 'package:cendrassos/providers/djau.dart';
import 'package:cendrassos/screens/components/calendari_notificacions.dart';
import 'package:cendrassos/screens/components/helpers.dart';
import 'package:cendrassos/screens/users_page.dart';
import 'package:cendrassos/services/background_tasks.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cendrassos/api/notifications_bloc.dart';
import 'package:table_calendar/table_calendar.dart';

import '../cendrassos_theme.dart';
import '../config_cendrassos.dart';
import '../main.dart';
import '../models/notificacio.dart';
import 'components/app_menu_bar.dart';

class Dashboard extends StatefulWidget {
  static const routeName = '/dashboard';

  const Dashboard({
    Key? key,
  }) : super(key: key);

  @override
  State<Dashboard> createState() => _DashBoardState();
}

class _DashBoardState extends State<Dashboard> {
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay = DateTime.now();
  int _month = 0;
  List<Notificacio> _notificacions = [];

  CalendarFormat _format = CalendarFormat.month;

  late NotificacioBloc _bloc;

  @override
  void initState() {
    super.initState();
    if (Platform.isAndroid || Platform.isIOS) {
      initPlatformState();
    }

    _month = _focusedDay.month;
    final djau = Provider.of<DjauModel>(context, listen: false);
    _bloc = NotificacioBloc(djau.alumne.token);
  }

  Future<void> initPlatformState() async {
    // Configure BackgroundFetch.
    BackgroundFetch.configure(
            BackgroundFetchConfig(
                minimumFetchInterval: intervalNotificacions,
                forceAlarmManager: true,
                stopOnTerminate: false,
                startOnBoot: true,
                enableHeadless: true,
                requiresBatteryNotLow: false,
                requiresCharging: false,
                requiresStorageNotLow: false,
                requiresDeviceIdle: false,
                requiredNetworkType: NetworkType.ANY),
            _onBackgroundFetch)
        .then((int status) {
      log('[BackgroundFetch] configure success: $status');
      // Fer post configuraci???
    }).catchError((e) {
      log('[BackgroundFetch] configure ERROR: $e');
    });
  }

  @override
  void dispose() {
    _bloc.dispose();
    super.dispose();
  }

  void _onBackgroundFetch(String taskId) async {
    // if (Platform.isAndroid) {
    //       SharedPreferencesAndroid.registerWith();}
    // if (Platform.isIOS) {
    //   SharedPreferencesIOS.registerWith();}

    // v.2.11
    // DartPluginRegistrant.ensureInitialized();

    // This is the fetch-event callback.
    log("[BackgroundFetch] Event received $taskId");
    BackgroundTask background = BackgroundTask();
    await background.checkNewNotificacions(onNotification);

    // IMPORTANT:  You must signal completion of your task or the OS can punish your app
    // for taking too long in the background.
    BackgroundFetch.finish(taskId);
  }

  void _retryComunicacion() {
    setState(() {
      _bloc.fetchNotificacions(_month);
    });
  }

  void _onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    if (!DateUtils.isSameDay(_selectedDay, selectedDay)) {
      setState(() {
        _selectedDay = selectedDay;
        _focusedDay = focusedDay;
        _month = focusedDay.month;
      });
    }
  }

  void _onFormatChanged(CalendarFormat nou) {
    setState(() {
      _format = nou;
    });
  }

  void _changeMonth(DateTime value) {
    setState(() {
      _month = value.month;
      _focusedDay = value;
      _selectedDay = null;
      _bloc.fetchNotificacions(_month);
    });
  }

  FutureOr onGoBack(dynamic value) {
    final djau = Provider.of<DjauModel>(context, listen: false);
    if (_bloc.getToken() != djau.alumne.token) {
      _bloc.setToken(djau.alumne.token);
      _retryComunicacion();
    }
  }

  void gotoUserPage() {
    Navigator.of(context).pushNamed(UsersPage.routeName).then(onGoBack);
  }

  @override
  Widget build(BuildContext context) {
    final currentLogin = context.watch<DjauModel>();

    var nom = currentLogin.alumne.nom;

    return Scaffold(
      appBar:
          AppMenuBar(nom: nom, haveleading: false, gotoUserPage: gotoUserPage),
      body: RefreshIndicator(
        onRefresh: () => _bloc.fetchNotificacions(_month),
        child: StreamBuilder<ApiResponse<List<Notificacio>>>(
            stream: _bloc.notificationsListStream,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                switch (snapshot.data!.status) {
                  case Status.loading:
                    return Loading(loadingMessage: snapshot.data!.message);
                  case Status.completed:
                    _notificacions = snapshot.data!.data;
                    return CalendariNotificacions(
                      notificacions: _notificacions,
                      focusedDay: _focusedDay,
                      selectedDay: _selectedDay,
                      format: _format,
                      onMonthChange: _changeMonth,
                      onSelectDay: _onDaySelected,
                      onFormatChanged: _onFormatChanged,
                    );
                  case Status.error:
                    return ErrorRetry(
                      errorMessage: snapshot.data!.message,
                      textBoto: missatgeTornaAProvar,
                      onRetryPressed: _retryComunicacion,
                    );
                }
              } else {
                return const Loading(loadingMessage: missatgeCarregantDades);
              }
            }),
      ),
    );
  }
}
