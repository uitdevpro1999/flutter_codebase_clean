// ignore_for_file: implementation_imports
import 'dart:io';
import 'package:curl_logger_dio_interceptor/curl_logger_dio_interceptor.dart';
import 'package:dio/dio.dart';
import 'package:dio/src/adapters/io_adapter.dart';
import 'package:flutter_codebase_clean/core/constants/constants.dart';
import 'package:flutter_codebase_clean/core/local_storage/share_preferences.dart';
import 'package:flutter_codebase_clean/flavors.dart';
import 'package:flutter_codebase_clean/injection_container.dart';
import 'package:injectable/injectable.dart';


const _defaultConnectTimeout = 5 * Duration.millisecondsPerMinute;
const _defaultReceiveTimeout = 5 * Duration.millisecondsPerMinute;

@module
abstract class NetworkProvider {
  @singleton
  Dio service() => getIt<AppNetworkClient>();
}

@LazySingleton(order: -1)
class AppNetworkClient with DioMixin implements Dio {
  final AppPreferences pref = getIt<AppPreferences>();
  AppNetworkClient() {
    options = BaseOptions(
      baseUrl: F.apiUrl,
      receiveTimeout: const Duration(milliseconds: 60 * 1000 * 2),
      connectTimeout: const Duration(milliseconds: 60 * 1000 * 2),
      contentType: 'application/json',
    )
      ..connectTimeout = const Duration(milliseconds: _defaultConnectTimeout)
      ..receiveTimeout = const Duration(milliseconds: _defaultReceiveTimeout);
    httpClientAdapter = IOHttpClientAdapter();
    interceptors.add(InterceptorsWrapper(
      onRequest: _requestInterceptor,
      onResponse: _responseInterceptor,
      onError: _errorInterceptor,
    ));
    interceptors.addAll([CurlLoggerDioInterceptor(printOnSuccess: true)]);
  }

  Future<void> _requestInterceptor(
      RequestOptions options, RequestInterceptorHandler handler) async {
    final String? accessToken = pref.authToken;
    if (options.headers["Authorization"] != Consts.basicAuth) {
      if (accessToken?.isNotEmpty ?? false) {
        options.headers["Authorization"] = 'Bearer $accessToken';
        this.options.headers["Authorization"] = 'Bearer $accessToken';
      } else {
        options.headers.remove("Authorization");
        this.options.headers.remove("Authorization");
      }
    }
    return handler.next(options);
  }

  Future<void> _responseInterceptor(
      response, ResponseInterceptorHandler handler) async {
    return handler.next(response);
  }

  Future<void> _errorInterceptor(
      DioException error, ErrorInterceptorHandler handler) async {
    return handler.next(error); //continue
  }
}
