import 'dart:async';

import 'package:cendrassos/api/api_response.dart';
import 'package:cendrassos/api/sortides_bloc.dart';
import 'package:cendrassos/config_djau.dart';
import 'package:cendrassos/models/resum_sortida.dart';
import 'package:cendrassos/providers/djau.dart';
import 'package:cendrassos/screens/components/app_menu_bar.dart';
import 'package:cendrassos/screens/components/helpers.dart';
import 'package:cendrassos/screens/components/sortida_list_item.dart';
import 'package:cendrassos/screens/users_page.dart';
import 'package:cendrassos/utils/global_navigator.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SortidesPage extends StatefulWidget {
  static const routeName = '/sortides';
  const SortidesPage({Key? key}) : super(key: key);

  @override
  State<SortidesPage> createState() => _SortidesPageState();
}

class _SortidesPageState extends State<SortidesPage> {
  List<ResumSortida> _sortides = [];

  late SortidesBlock _bloc;

  @override
  void initState() {
    super.initState();
    final djau = Provider.of<DjauModel>(context, listen: false);
    _bloc = SortidesBlock(djau.alumne.token);
  }

  @override
  void dispose() {
    _bloc.dispose();
    super.dispose();
  }

  void _retryComunicacion() {
    setState(() {
      _bloc.fetchSortides();
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

  void _gotoUsuaris() {
    GlobalNavigator.forgetAndGo(UsersPage.routeName);
  }

  @override
  Widget build(BuildContext context) {
    final currentLogin = context.watch<DjauModel>();

    var nom = currentLogin.alumne.nom;

    return Scaffold(
      appBar: AppMenuBar(
          nom: nom,
          haveleading: false,
          gotoUserPage: gotoUserPage,
          gotoSortides: null),
      body: RefreshIndicator(
        onRefresh: () => _bloc.fetchSortides(),
        child: StreamBuilder<ApiResponse<List<ResumSortida>>>(
            stream: _bloc.resumSortidaListStream,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                switch (snapshot.data!.status) {
                  case Status.loading:
                    return Loading(loadingMessage: snapshot.data!.message);
                  case Status.completed:
                    _sortides = snapshot.data!.data;
                    return buildLlistaSortides(_sortides);
                  case Status.error:
                    return ErrorRetryLogin(
                      errorType: "ERROR",
                      errorMessage: snapshot.data!.message,
                      onLogin: _gotoUsuaris,
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

  void _showDetails(BuildContext context, int id) async {
    // Mostrar el detall. Dialeg? Pàgina nova?
  }

  Widget buildLlistaSortides(List<ResumSortida> sortides) {
    return ListView.builder(
      itemCount: sortides.length,
      itemBuilder: (context, index) {
        final post = sortides[index];
        return SortidaListItem(
          sortida: post,
          showDetail: _showDetails,
        );
      },
    );
  }
}
