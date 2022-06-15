import 'dart:io';
import 'package:cendrassos/api/exceptions.dart';
import 'package:cendrassos/config_cendrassos.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';

/// Classe base per fer peticions a qualsevol API.
/// Gestiona els errors a través d'excepcions
class ApiBaseHelper {
  /// Munta la URL a partir del path rebut
  /// - L'he creat perquè el cendrassos fa que les URL acabin sempre
  ///   amb guió
  static Uri createUrl(urlpath) {
    return Uri.parse("$baseUrl$urlpath$endBaseUrl");
  }

  /// Petició GET amb el [path] i capsaleres opcionals [headers]
  /// La resposta es passa a _returnResponse perquè la tracti
  /// Pot generar una excepció si falla la connexió de xarxa, que
  /// es converteix en [FetchDataException]
  Future<dynamic> get(String path, [dynamic headers]) async {
    debugPrint('Api Get, url $path');
    headers ??= {};
    dynamic responseJson;
    try {
      var url = createUrl(path);
      final response = await http.get(url, headers: headers);
      responseJson = _returnResponse(response);
    } on SocketException {
      debugPrint('No net');
      throw FetchDataException(noInternet);
    }
    return responseJson;
  }

  /// Petició POST a un [path] amb dades Json [body] i capsaleres [headers]
  /// La resposta es passa a _returnResponse perquè la tracti
  /// Pot generar una excepció si falla la connexió de xarxa, que
  /// es converteix en [FetchDataException]
  Future<dynamic> post(String path, dynamic body, [dynamic headers]) async {
    debugPrint('Api Post, url $path');
    headers ??= {};

    try {
      var url = createUrl(path);
      final response =
          await http.post(url, body: jsonEncode(body), headers: headers);
      var responseJson = _returnResponse(response);
      return responseJson;
    } on SocketException {
      debugPrint('No net');
      throw FetchDataException(noInternet);
    }
  }

  /// Petició PUT a un [path] amb dades Json [body]
  /// La resposta es passa a _returnResponse perquè la tracti
  /// Pot generar una excepció si falla la connexió de xarxa, que
  /// es converteix en [FetchDataException]
  /// * No es fa servir, per això no té capsalera
  Future<dynamic> put(String path, dynamic body) async {
    debugPrint('Api Put, url $path');
    try {
      var url = createUrl(path);
      final response = await http.put(url, body: body);
      var responseJson = _returnResponse(response);
      return responseJson;
    } on SocketException {
      debugPrint('No net');
      throw FetchDataException(noInternet);
    }
  }

  /// Petició DELETE amb el [path]
  /// La resposta es passa a _returnResponse perquè la tracti
  /// Pot generar una excepció si falla la connexió de xarxa, que
  /// es converteix en [FetchDataException]
  /// * No es fa servir, per això no té capsalera
  Future<dynamic> delete(String path) async {
    debugPrint('Api delete, url $path');
    try {
      var url = createUrl(path);
      final response = await http.delete(url);
      var apiResponse = _returnResponse(response);
      return apiResponse;
    } on SocketException {
      debugPrint('No net');
      throw FetchDataException(noInternet);
    }
  }
}

/// Processa la resposta de l'API [response] i decodifica el resultat
/// En cas de que hi hagi un error genera la excepció corresponent
dynamic _returnResponse(http.Response response) {
  if (response.statusCode == 200) {
    var responseJson = json.decode(utf8.decode(response.bodyBytes));
    return responseJson;
  } else {
    var result = jsonDecode(utf8.decode(response.bodyBytes));
    switch (response.statusCode) {
      case 400:
        throw BadRequestException(result.toString());
      case 401:
      case 403:
      case 405:
        throw UnauthorisedException(result.toString());
      case 500:
      default:
        throw FetchDataException(
            'Error en connectar amb el servidor. ${response.statusCode}:$result. Proveu-ho més tard');
    }
  }
}

  // Future<dynamic> get(String url) async {
  //   print('Api Get, url $url');
  //   var responseJson;
  //   try {
  //     final response = await http.get(Uri.parse(_baseUrl + url));
  //     responseJson = _returnResponse(response);
  //   } on SocketException {
  //     print('No net');
  //     throw FetchDataException(NOINTERNET);
  //   }
  //   return responseJson;
  // }

