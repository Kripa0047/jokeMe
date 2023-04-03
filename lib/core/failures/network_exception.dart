import 'package:dio/dio.dart';

class NetworkException extends DioError {
  NetworkException(
    RequestOptions r,
    String message,
  ) : super(
          requestOptions: r,
          error: message,
        );

  @override
  String toString() {
    return error.toString();
  }
}

class TimeoutException extends DioError {
  TimeoutException(
    RequestOptions r,
    String message,
  ) : super(
          requestOptions: r,
          error: message,
        );
  @override
  String toString() {
    return error.toString();
  }
}

class BadRequestException extends DioError {
  BadRequestException(
    RequestOptions r,
    String message,
  ) : super(
          requestOptions: r,
          error: message,
        );
  @override
  String toString() {
    return error.toString();
  }
}

class ForbiddenException extends DioError {
  ForbiddenException(
    RequestOptions r,
    String message,
  ) : super(
          requestOptions: r,
          error: message,
        );
  @override
  String toString() {
    return error.toString();
  }
}

class InternalServerErrorException extends DioError {
  InternalServerErrorException(
    RequestOptions r,
    String message,
  ) : super(
          requestOptions: r,
          error: message,
        );
  @override
  String toString() {
    return error.toString();
  }
}

class UnauthorizedException extends DioError {
  UnauthorizedException(
    RequestOptions r,
    String message,
  ) : super(
          requestOptions: r,
          error: message,
        );
  @override
  String toString() {
    return error.toString();
  }
}

class NotFoundException extends DioError {
  NotFoundException(
    RequestOptions r,
    String message,
  ) : super(
          requestOptions: r,
          error: message,
        );
  @override
  String toString() {
    return error.toString();
  }
}
