import 'dart:async';
import 'dart:io';

import 'package:background_fetch/background_fetch.dart';
import 'package:cendrassos/api/api_response.dart';
import 'package:cendrassos/providers/djau.dart';
import 'package:cendrassos/screens/CalendariNotificacions.dart';
import 'package:cendrassos/screens/Error.dart';
import 'package:cendrassos/screens/users_page.dart';
import 'package:cendrassos/services/background_tasks.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cendrassos/api/notifications_bloc.dart';

import '../config_cendrassos.dart';
import '../models/notificacio.dart';

class Dashboard extends StatefulWidget {
  static const routeName = '/dashboard';

  const Dashboard({
    Key? key,
  }) : super(key: key);

  @override
  _DashBoardState createState() => _DashBoardState();
}

class _DashBoardState extends State<Dashboard> {
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay = DateTime.now();
  int _month = 0;
  List<Notificacio> _notificacions = [];

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
      print('[BackgroundFetch] configure success: $status');
      // Fer post configuració?
    }).catchError((e) {
      print('[BackgroundFetch] configure ERROR: $e');
    });
  }

  @override
  void dispose() {
    _bloc.dispose();
    super.dispose();
  }

  void _onBackgroundFetch(String taskId) async {
    // This is the fetch-event callback.
    print("[BackgroundFetch] Event received $taskId");
    BackgroundTask _background = BackgroundTask();
    await _background.checkNewNotificacions();

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
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          'Alumne: $nom',
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.account_box),
            onPressed: gotoUserPage,
          )
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () => _bloc.fetchNotificacions(_month),
        child: StreamBuilder<ApiResponse<List<Notificacio>>>(
            stream: _bloc.notificationsListStream,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                switch (snapshot.data!.status) {
                  case Status.LOADING:
                    return Loading(loadingMessage: snapshot.data!.message);
                  case Status.COMPLETED:
                    _notificacions = snapshot.data!.data;
                    return CalendariNotificacions(
                      notificacions: _notificacions,
                      focusedDay: _focusedDay,
                      selectedDay: _selectedDay,
                      onMonthChange: _changeMonth,
                      onSelectDay: _onDaySelected,
                    );
                  case Status.ERROR:
                    return Error(
                      errorMessage: snapshot.data!.message,
                      onRetryPressed: _retryComunicacion,
                    );
                }
              } else {
                return Loading(loadingMessage: "Carregant dades");
              }
            }),
      ),
    );
  }
}
