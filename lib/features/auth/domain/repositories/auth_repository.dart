import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/user_entity.dart';

abstract class AuthRepository {
  Future<Either<Failure, UserEntity>> login({
    required String username,
    required String password,
  });

  Future<Either<Failure, UserEntity>> register({
    required String email,
    required String username,
    required String password,
    required String firstName,
    required String lastName,
  });

  Future<Either<Failure, bool>> isLoggedIn();

  Future<Either<Failure, UserEntity?>> getSavedUser();

  Future<Either<Failure, void>> logout();
}