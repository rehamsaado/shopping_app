import 'package:dartz/dartz.dart';
import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failures.dart';
import '../../domain/entities/user_entity.dart';
import '../../domain/repositories/auth_repository.dart';
import '../data_source/auth_local_data_source.dart';
import '../data_source/auth_remote_data_source.dart';
import '../models/user_model.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;
  final AuthLocalDataSource localDataSource;

  AuthRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
  });

  @override
  Future<Either<Failure, UserEntity>> login({
    required String username,
    required String password,
  }) async {
    try {
      final userModel = await remoteDataSource.login(
        username: username,
        password: password,
      );

      await localDataSource.saveToken(userModel.token ?? "");
      await localDataSource.saveUser(userModel);

      return Right(userModel);
    } on UnauthorizedException catch (e) {
      return Left(UnauthorizedFailure(message: e.message));
    } on NetworkException catch (e) {
      return Left(NetworkFailure(message: e.message));
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    } catch (e) {
      return const Left(ServerFailure(message: 'error_server'));
    }
  }

  @override
  Future<Either<Failure, UserEntity>> register({
    required String email,
    required String username,
    required String password,
    required String firstName,
    required String lastName,
  }) async {
    try {
      final response = await remoteDataSource.register(
        email: email,
        username: username,
        password: password,
        firstName: firstName,
        lastName: lastName,
      );

      final userModel = UserModel.fromJson(response);

      await localDataSource.saveToken(userModel.token ?? "");
      await localDataSource.saveUser(userModel);

      return Right(userModel);
    } on NetworkException catch (e) {
      return Left(NetworkFailure(message: e.message));
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    } catch (e) {
      return const Left(ServerFailure(message: 'error_server'));
    }
  }

  @override
  Future<Either<Failure, bool>> isLoggedIn() async {
    try {
      final token = localDataSource.getToken();
      return Right(token != null && token.isNotEmpty);
    } catch (e) {
      return const Left(CacheFailure(message: 'error_cache'));
    }
  }

  @override
  Future<Either<Failure, UserEntity?>> getSavedUser() async {
    try {
      final user = localDataSource.getUser();
      return Right(user);
    } catch (e) {
      return const Left(CacheFailure(message: 'error_cache'));
    }
  }

  @override
  Future<Either<Failure, void>> logout() async {
    try {
      await localDataSource.clearAuthData();
      return const Right(null);
    } catch (e) {
      return const Left(CacheFailure(message: 'error_cache'));
    }
  }
}