import 'dart:io';
import 'package:cendrassos/api/exceptions.dart';
import 'package:cendrassos/config_cendrassos.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';

class ApiBaseHelper {
  static Uri createUrl(urlpath) {
    return Uri.parse("$baseUrl$urlpath");
  }

  static const String noInternet =
      "Hi ha problemes per accedir a la xarxa. Proveu-ho més tard";

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

dynamic _returnResponse(http.Response response) {
  if (response.statusCode == 200) {
    var responseJson = json.decode(response.body);
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
