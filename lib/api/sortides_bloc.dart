import 'dart:async';

import 'package:cendrassos/api/api_response.dart';
import 'package:cendrassos/api/notificacions_repository.dart';
import 'package:cendrassos/config_djau.dart';
import 'package:cendrassos/models/resum_sortida.dart';
import 'package:flutter/material.dart';

class SortidesBlock {
  String _token = "";
  NotificacionsRepository _notificacioRepository = NotificacionsRepository();
  StreamController<ApiResponse<List<ResumSortida>>> _resumSortidaListController =
      StreamController<ApiResponse<List<ResumSortida>>>();

  StreamSink<ApiResponse<List<ResumSortida>>> get resumSortidaListSink =>
      _resumSortidaListController.sink;

  Stream<ApiResponse<List<ResumSortida>>> get resumSortidaListStream =>
      _resumSortidaListController.stream;

  SortidesBlock(String token) {
    _resumSortidaListController =
        StreamController<ApiResponse<List<ResumSortida>>>();
    _notificacioRepository = NotificacionsRepository();
    _token = token;
    fetchSortides();
  }

  fetchSortides() async {
    resumSortidaListSink
        .add(ApiResponse.loading(carregantSortides, []));
    try {
      var dades = await _notificacioRepository.getSortides(_token);
      resumSortidaListSink.add(ApiResponse.completed(dades));
    } catch (e) {
      resumSortidaListSink.add(ApiResponse.error(e.toString(), []));
      debugPrint(e.toString());
    }
  }

  dispose() {
    _resumSortidaListController.close();
  }

  String getToken() {
    return _token;
  }

  void setToken(String token) {
    _token = token;
  }
}
