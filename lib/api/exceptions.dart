import 'package:cendrassos/config_djau.dart';

class AppException implements Exception {
  final String? _message;
  final String? _prefix;

  AppException([this._message, this._prefix]);

  String message() {
    return _message ?? undefinedError;
  }

  String prefix() {
    return _prefix ?? defaultErrorMessage;
  }

  @override
  String toString() {
    return "$_prefix$_message";
  }
}

class FetchDataException extends AppException {
  FetchDataException([String? message])
      : super(message, communicationExceptionMessage);
}

class BadRequestException extends AppException {
  BadRequestException([message])
      : super(message, invalidPetitionExceptionMessage);
}

class UnauthorisedException extends AppException {
  UnauthorisedException([message])
      : super(message, notAuthorizedExceptionMessage);
}

class InvalidInputException extends AppException {
  InvalidInputException([String? message])
      : super(message, invalidInputExceptionMessage);
}
