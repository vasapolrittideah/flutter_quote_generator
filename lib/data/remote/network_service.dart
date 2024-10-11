import 'dart:io';

import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

import 'package:flutter_quote_generator/data/remote/network_info.dart';

@injectable
class NetworkService {
  NetworkService(this._dio);

  final Dio _dio;

  Future<Response> get(
    String url, {
    String? token,
    Map<String, String>? headers,
  }) async {
    try {
      return _dio.get(
        url,
        options: Options(
          headers: {
            if (token != null) 'Authorization': 'Bearer $token',
            ...?headers,
          },
        ),
      );
    } catch (error) {
      rethrow;
    }
  }

  Future<Response> post<T extends Object?>(
    String url, {
    T? data,
    String? token,
    Map<String, String>? headers,
  }) async {
    try {
      return _dio.post(
        url,
        data: data,
        options: Options(
          headers: {
            if (token != null) 'Authorization': 'Bearer $token',
            ...?headers,
          },
        ),
      );
    } catch (error) {
      rethrow;
    }
  }

  Future<Response> patch<T extends Object?>(
    String url, {
    T? data,
    String? token,
    Map<String, String>? headers,
  }) async {
    try {
      return _dio.patch(
        url,
        data: data,
        options: Options(
          headers: {
            if (token != null) 'Authorization': 'Bearer $token',
            ...?headers,
          },
        ),
      );
    } catch (error) {
      rethrow;
    }
  }
}
