import 'package:dartz/dartz.dart';

import '../../../../../core/error/failures.dart';
import '../../entity/profile_entity.dart';
import '../../repository/profile_repository.dart';

class GetProfileDetailsUseCase {
  final ProfileRepository repository;

  GetProfileDetailsUseCase(this.repository);

  Future<Either<Failure, ProfileEntity>> call(String userId) async {
    return await repository.getProfileDetails(userId);
  }
}
