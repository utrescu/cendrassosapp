/// Excepció de l'aplicació
class AppException implements Exception {
  final String? _message;
  final String? _prefix;

  AppException([this._message, this._prefix]);

  @override
  String toString() {
    return "$_prefix$_message";
  }
}

/// Excepció produïda quan s'intentava recuperar dades
class FetchDataException extends AppException {
  FetchDataException([String? message])
      : super(message, "Error During Communication: ");
}

/// Excepció per quan es rebi bad request en les peticions de l'API
class BadRequestException extends AppException {
  BadRequestException([message]) : super(message, "Invalid Request: ");
}

/// Excepció per problemes de permisos en les peticions de l'API
class UnauthorisedException extends AppException {
  UnauthorisedException([message]) : super(message, "Unauthorised: ");
}

/// Excepció per quan hi hagi dades incorrectes les peticions de l'API
class InvalidInputException extends AppException {
  InvalidInputException([String? message]) : super(message, "Invalid Input: ");
}
