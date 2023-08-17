

import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

import '../resources/app_url.dart';

@lazySingleton
class NetworkUtil {
  late Dio _dio;

  NetworkUtil({required Dio dio}) {
    _dio = dio;

    ///Create Dio Object using baseOptions set receiveTimeout,connectTimeout
    BaseOptions options = BaseOptions(
        receiveTimeout: const Duration(milliseconds: 20000),
        connectTimeout: const Duration(milliseconds: 20000));
    options.baseUrl = AppUrl.baseUrl;

    _dio.options = options;
  }

  ///used for calling Get Request
  Future<Response> get(String url, {Map<String, dynamic>? query}) async {
    Response response = await _dio.get(url,
        queryParameters: query,
        options: Options(responseType: ResponseType.json));

    return response;
  }
}
