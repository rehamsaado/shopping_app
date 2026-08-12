import '../../../../core/constants/app_constants.dart';
import '../../../../core/error/exceptions.dart';
import '../../../../core/network/api_service.dart';
import '../models/user_model.dart';
import 'package:dio/dio.dart';

abstract class AuthRemoteDataSource {
  Future<UserModel> login({
    required String username,
    required String password,
  });

  Future<Map<String, dynamic>> register({
    required String email,
    required String username,
    required String password,
    required String firstName,
    required String lastName,
  });
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final ApiService _apiService;

  AuthRemoteDataSourceImpl({required ApiService apiService})
      : _apiService = apiService;

  @override
  Future<UserModel> login({
    required String username,
    required String password,
  }) async {
    try {
      final response = await _apiService.post(
        path: ApiConstants.login,
        data: {
          ApiConstants.keyUsername: username,
          ApiConstants.keyPassword: password,
        },
      );

      final data = response as Map<String, dynamic>;
      return UserModel.fromJson(data);
    } on DioException catch (e) {
      if (e.response?.statusCode == 401) {
        throw const UnauthorizedException();
      } else if (e.type == DioExceptionType.connectionTimeout ||
          e.type == DioExceptionType.receiveTimeout ||
          e.type == DioExceptionType.connectionError) {
        throw const NetworkException();
      } else {
        throw const ServerException();
      }
    } catch (_) {
      throw const ServerException();
    }
  }

  @override
  Future<Map<String, dynamic>> register({
    required String email,
    required String username,
    required String password,
    required String firstName,
    required String lastName,
  }) async {
    try {
      final response = await _apiService.post(
        path: ApiConstants.users,
        data: {
          ApiConstants.keyEmail: email,
          ApiConstants.keyUsername: username,
          ApiConstants.keyPassword: password,
          ApiConstants.keyName: {
            ApiConstants.keyFirstname: firstName,
            ApiConstants.keyLastname: lastName,
          },
        },
      );

      return response as Map<String, dynamic>;
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionTimeout ||
          e.type == DioExceptionType.receiveTimeout ||
          e.type == DioExceptionType.connectionError) {
        throw const NetworkException();
      } else {
        throw const ServerException();
      }
    } catch (_) {
      throw const ServerException();
    }
  }
}