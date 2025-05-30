import 'package:cendrassos/models/resum_sortida.dart';
import 'package:cendrassos/screens/components/helpers.dart';
import 'package:flutter/material.dart';

typedef TryShowDetail = void Function(BuildContext context, int id);

class SortidaListItem extends StatelessWidget {
  const SortidaListItem({
    Key? key,
    required this.sortida,
    required this.showDetail,
  }) : super(key: key);

  final ResumSortida sortida;
  final TryShowDetail showDetail;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => showDetail(context, sortida.id),
      child: sortidaItemContent(context),
    );
  }

  Widget sortidaItemContent(BuildContext context) {
    return ListTile(
      tileColor: Theme.of(context).cardColor,
      title: Text(
        sortida.titol,
        textAlign: TextAlign.left,
      ),
      subtitle: Text(convertirDataAmerica(context, sortida.data)),
      trailing: !sortida.realitzat
          ? Icon(
              Icons.payment,
              color: Theme.of(context).primaryColor,
            )
          : Icon(
              Icons.output,
              color: Theme.of(context).disabledColor,
            ),
    );
  }
}
