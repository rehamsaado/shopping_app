import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/user_entity.dart';
import '../repositories/auth_repository.dart';

class RegisterUseCase {
  final AuthRepository _repository;

  const RegisterUseCase(this._repository);

  Future<Either<Failure, UserEntity>> call({
    required String email,
    required String username,
    required String password,
    required String firstName,
    required String lastName,
  }) async {
    return await _repository.register(
      email: email,
      username: username,
      password: password,
      firstName: firstName,
      lastName: lastName,
    );
  }
}