import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:joke_me/config/apis.dart';
import 'package:joke_me/core/failures/network_exception.dart';
import 'package:joke_me/core/utils/network.dart';

class HTTP {
  final Dio client = createClient();

  static Dio createClient() {
    final dio = Dio(
      BaseOptions(
        baseUrl: APIs.baseURL,
        contentType: Headers.jsonContentType,
      ),
    );

    dio.interceptors.addAll({
      AppInterceptors(dio),
    });
    return dio;
  }
}

class AppInterceptors extends Interceptor {
  final Dio dio;

  AppInterceptors(this.dio);

  @override
  void onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    NetworkInfo networkInfo = NetworkInfoImpl(
      InternetConnectionChecker(),
    );
    if (!await networkInfo.isConnected) {
      return handler.reject(DioError(
        requestOptions: options,
        error: NetworkException(options, "Network error"),
      ));
    } else {
      return handler.next(options);
    }
  }

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) async {
    switch (err.type) {
      case DioErrorType.connectionTimeout:
      case DioErrorType.sendTimeout:
      case DioErrorType.receiveTimeout:
        return handler.reject(
          TimeoutException(
            err.requestOptions,
            "Connection timeout",
          ),
        );

      case DioErrorType.badResponse:
        String errorMessage = "";
        if (err.response?.data == "") {
          errorMessage = "Something went wrong";
        } else {
          errorMessage = err.response?.data?["message"];
        }

        switch (err.response?.statusCode) {
          case 400:
            return handler.reject(
              BadRequestException(
                err.requestOptions,
                errorMessage,
              ),
            );
          case 401:
            return handler.reject(
              UnauthorizedException(
                err.requestOptions,
                errorMessage,
              ),
            );
          case 403:
            return handler.reject(
              ForbiddenException(
                err.requestOptions,
                errorMessage,
              ),
            );
          case 404:
            return handler.reject(
              NotFoundException(
                err.requestOptions,
                errorMessage,
              ),
            );
          case 500:
            return handler.reject(
              InternalServerErrorException(
                err.requestOptions,
                errorMessage,
              ),
            );
        }
        break;
      case DioErrorType.cancel:
        break;
      case DioErrorType.unknown:
        return handler.reject(
          BadRequestException(
            err.requestOptions,
            "Something went wrong",
          ),
        );
    }

    return handler.next(err);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    debugPrint("Response Data >> ${response.data}");
    super.onResponse(response, handler);
  }
}
