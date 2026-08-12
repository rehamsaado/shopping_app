import 'package:dio/dio.dart';
import '../constants/app_constants.dart';
import '../error/exceptions.dart';
import 'api_interceptors.dart';

class ApiService {
  late final Dio _dio;

  ApiService(ApiInterceptor interceptor) {
    _dio = Dio(
      BaseOptions(
        baseUrl: ApiConstants.baseUrl,
        connectTimeout: ApiConstants.connectTimeout,
        receiveTimeout: ApiConstants.receiveTimeout,
      ),
    );
    _dio.interceptors.add(interceptor);
  }

  Future<dynamic> get({
    required String path,
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      final response = await _dio.get(path, queryParameters: queryParameters);
      return response.data;
    } on DioException catch (e) {
      _handleDioError(e);
    }
  }

  Future<dynamic> post({
    required String path,
    dynamic data,
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      final response = await _dio.post(
        path,
        data: data,
        queryParameters: queryParameters,
      );
      return response.data;
    } on DioException catch (e) {
      _handleDioError(e);
    }
  }

  Future<dynamic> put({required String path, dynamic data}) async {
    try {
      final response = await _dio.put(path, data: data);
      return response.data;
    } on DioException catch (e) {
      _handleDioError(e);
    }
  }

  Future<dynamic> delete({required String path}) async {
    try {
      final response = await _dio.delete(path);
      return response.data;
    } on DioException catch (e) {
      _handleDioError(e);
    }
  }

  Never _handleDioError(DioException error) {
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        throw const TimeoutException();

      case DioExceptionType.badResponse:
        final statusCode = error.response?.statusCode;
        if (statusCode == 401) {
          throw const UnauthorizedException();
        } else if (statusCode == 404) {
          throw const NotFoundException();
        } else {
          throw ServerException(
            error.response?.data?['message'] ?? 'Server error occurred',
            statusCode,
          );
        }

      case DioExceptionType.connectionError:
        throw const NetworkException();

      default:
        throw const ServerException();
    }
  }
}