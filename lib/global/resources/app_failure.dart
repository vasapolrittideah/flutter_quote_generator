import 'dart:io';

import 'package:dio/dio.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'app_failure.freezed.dart';

@freezed
class AppFailure with _$AppFailure {
  const factory AppFailure.network([String? message]) = _Network;
  const factory AppFailure.badRequest([String? message]) = _BadRequest;
  const factory AppFailure.cancel([String? message]) = _Cancel;
  const factory AppFailure.timeout([String? message]) = _Timeout;
  const factory AppFailure.server([String? message]) = _Server;
  const factory AppFailure.notFound([String? message]) = _NotFound;
  const factory AppFailure.unknown([String? message]) = _Unknown;

  factory AppFailure.fromException(Exception? error) {
    if (error is DioException) {
      String? errorMessage = error.message;

      switch (error.type) {
        case DioExceptionType.connectionError:
          return error.error is SocketException
              ? AppFailure.network(errorMessage)
              : AppFailure.unknown(errorMessage);
        case DioExceptionType.badResponse:
          return AppFailure._handleHttpStatus(
            error.response?.statusCode,
            errorMessage,
          );
        case DioExceptionType.cancel:
          return AppFailure.cancel(errorMessage);
        case DioExceptionType.receiveTimeout:
        case DioExceptionType.sendTimeout:
          return AppFailure.timeout(errorMessage);
        default:
          return AppFailure.unknown(errorMessage);
      }
    }

    return AppFailure.unknown(error?.toString());
  }

  static AppFailure _handleHttpStatus(int? statusCode, String? message) {
    switch (statusCode) {
      case HttpStatus.badRequest:
        return AppFailure.badRequest(message);
      case HttpStatus.notFound:
        return AppFailure.notFound(message);
      case HttpStatus.internalServerError:
      case HttpStatus.serviceUnavailable:
        return AppFailure.server(message);
      default:
        return AppFailure.unknown(message);
    }
  }
}
