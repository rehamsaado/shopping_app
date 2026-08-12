import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/user_entity.dart';
import '../repositories/auth_repository.dart';

class GetSavedUserUseCase {
  final AuthRepository _repository;

  const GetSavedUserUseCase(this._repository);

  Future<Either<Failure, UserEntity?>> call() async {
    return await _repository.getSavedUser();
  }
}