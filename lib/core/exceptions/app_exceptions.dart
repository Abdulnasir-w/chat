import 'dart:io';

class AppException implements Exception {
  final String message;
  final StackTrace? stackTrace;

  AppException({required this.message, this.stackTrace});
}

class NetworkException extends SocketException {
  NetworkException(super.message);
}

class AppAuthException extends AppException {
  AppAuthException({required super.message, super.stackTrace});
}

class AppDatabaseException extends AppException {
  AppDatabaseException({required super.message});
}
