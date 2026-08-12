import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import '../local/app_preferences.dart';


class ApiInterceptor extends Interceptor {
  final AppPreferences _appPreferences;

  ApiInterceptor(this._appPreferences);

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {

    options.headers['Content-Type'] = 'application/json';
    options.headers['Accept'] = 'application/json';


    final token = _appPreferences.getData(key: 'user_token') as String?;
    if (token != null && token.isNotEmpty) {
      options.headers['Authorization'] = 'Bearer $token';
    }


    if (kDebugMode) {
      print('🚀 [REQUEST] ${options.method} => PATH: ${options.path}');
    }

    super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    if (kDebugMode) {
      print('✅ [RESPONSE] ${response.statusCode} => PATH: ${response.requestOptions.path}');
    }
    super.onResponse(response, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    if (kDebugMode) {
      print('❌ [ERROR] ${err.response?.statusCode} => MESSAGE: ${err.message}');
    }
    super.onError(err, handler);
  }
}