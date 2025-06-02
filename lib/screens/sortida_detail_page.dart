import 'package:cendrassos/api/exceptions.dart';
import 'package:cendrassos/config_djau.dart';
import 'package:cendrassos/djau_theme.dart';
import 'package:cendrassos/models/sortida.dart';
import 'package:cendrassos/providers/djau.dart';
import 'package:cendrassos/screens/components/app_menu_bar.dart';
import 'package:cendrassos/screens/components/helpers.dart';
import 'package:cendrassos/screens/sortides_page.dart';
import 'package:cendrassos/screens/users_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SortidaDetailPage extends StatelessWidget {
  final int id;
  const SortidaDetailPage({Key? key, this.id = 0}) : super(key: key);

  static const routeName = '/sortida';

  @override
  Widget build(BuildContext context) {
    final djau = Provider.of<DjauModel>(context, listen: false);
    final arguments = (ModalRoute.of(context)?.settings.arguments ??
        <String, dynamic>{}) as Map;

    return Scaffold(
      appBar: AppMenuBar(
        nom: "Pagaments",
        haveleading: true,
        gotoUserPage: () =>
            {Navigator.of(context).pushNamed(UsersPage.routeName)},
        gotoSortides: () =>
            {Navigator.of(context).pushNamed(SortidesPage.routeName)},
      ),
      body: SingleChildScrollView(
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                const SizedBox(
                  height: 10,
                ),
                FutureBuilder<Sortida>(
                    future: djau.loadSortida(arguments['id']),
                    builder:
                        (BuildContext build, AsyncSnapshot<Sortida> snapshot) {
                      if (snapshot.connectionState == ConnectionState.done &&
                          snapshot.hasData) {
                        return showData(context, snapshot.data as Sortida);
                      } else if (snapshot.connectionState ==
                              ConnectionState.done &&
                          snapshot.hasError) {
                        var e = snapshot.error as AppException;
                        return ErrorRetry(
                          errorType: e.prefix(),
                          errorMessage: e.message(),
                          textBoto: missatgeOk,
                          onRetryPressed: () => Navigator.pop(context),
                        );
                      } else {
                        return const Loading(
                            loadingMessage: missatgeCarregantDades);
                      }
                    }),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget showData(BuildContext context, Sortida data) {
    var width = MediaQuery.of(context).size.width * 0.9;

    return SizedBox(
      width: width,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.7,
            child: SortidaDescription(
              sortida: data,
            ),
          ),
          showButton(width, data, context)
        ],
      ),
    );
  }

  Container showButton(double width, Sortida sortida, BuildContext context) {
    if (sortida.idPagament == null) {
      return Container();
    }
    return Container(
      width: width,
      padding: const EdgeInsets.symmetric(vertical: 15),
      alignment: Alignment.center,
      child: ElevatedButton(
          style: ElevatedButton.styleFrom(
              foregroundColor: Theme.of(context).secondaryHeaderColor,
              backgroundColor: Theme.of(context).primaryColor),
          onPressed: (!sortida.realitzat)
              ? () async {
                  // TODO
                }
              : null,
          child: const Text(
            'Pagar',
          )),
    );
  }
}

class SortidaDescription extends StatelessWidget {
  const SortidaDescription({
    Key? key,
    required this.sortida,
  }) : super(key: key);

  final Sortida sortida;

  @override
  Widget build(BuildContext context) {
    return Card.outlined(
      elevation: 4.0,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            color: Theme.of(context).primaryColor,
            width: MediaQuery.of(context).size.width,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                sortida.titol,
                style: Theme.of(context)
                    .textTheme
                    .titleLarge
                    ?.apply(color: backgroundColor),
              ),
            ),
          ),
          ListTile(
            title: Text(
                (sortida.preu != "0") ? "${sortida.preu} €" : "gratuita",
                style: Theme.of(context).textTheme.titleLarge),
            subtitle: Text(
                "${convertirDataPeninsular(context, sortida.desde)}\n${convertirDataPeninsular(context, sortida.finsa)}"),
            leading: const Icon(Icons.business_center),
          ),
          //  Container(
          //    height: 200.0,
          //    child: Ink.image(
          //      image: cardImage,
          //      fit: BoxFit.cover,
          //    ),
          //  ),
          Container(
            padding: const EdgeInsets.all(16.0),
            alignment: Alignment.centerLeft,
            child: Text(sortida.programa),
          ),
          Container(
            padding: const EdgeInsets.all(16.0),
            alignment: Alignment.centerLeft,
            child: (sortida.idPagament == null)
                ? Container()
                : Text(
                    "Data límit pel Pagament:\n  ${convertirDataAmerica(context, sortida.dataLimit)}",
                    style: Theme.of(context).textTheme.labelMedium),
          ),
        ],
      ),
    );
  }
}
