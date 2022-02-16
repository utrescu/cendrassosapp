import 'package:cendrassos/api/api_response.dart';
import 'package:cendrassos/providers/djau.dart';
import 'package:cendrassos/screens/CalendariNotificacions.dart';
import 'package:cendrassos/screens/Error.dart';
import 'package:cendrassos/screens/users_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cendrassos/api/notifications_bloc.dart';

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

    _month = _focusedDay.month;
    final djau = Provider.of<DjauModel>(context, listen: false);
    _bloc = NotificacioBloc(djau.alumne.token);
  }

  @override
  void dispose() {
    _bloc.dispose();
    super.dispose();
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

  @override
  Widget build(BuildContext context) {
    final currentLogin = context.watch<DjauModel>();
    // if (!currentLogin.isLogged()) {
    //   Navigator.pushNamed(context, LoginPage.routeName);
    // }
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
            onPressed: () {
              Navigator.of(context).pushNamed(UsersPage.routeName);
            },
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