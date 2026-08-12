import 'package:dartz/dartz.dart';

import '../../../../../core/error/failures.dart';
import '../../entity/profile_entity.dart';
import '../../repository/profile_repository.dart';

class CacheProfileDetailsUseCase {
  final ProfileRepository repository;

  CacheProfileDetailsUseCase(this.repository);

  Future<Either<Failure, Unit>> call(ProfileEntity profile) async {
    return await repository.cacheProfileDetails(profile);
  }
}
