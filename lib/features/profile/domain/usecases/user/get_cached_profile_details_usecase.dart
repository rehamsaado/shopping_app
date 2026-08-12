import 'package:dartz/dartz.dart';

import '../../../../../core/error/failures.dart';
import '../../entity/profile_entity.dart';
import '../../repository/profile_repository.dart';

class GetCachedProfileDetailsUseCase {
  final ProfileRepository repository;

  GetCachedProfileDetailsUseCase(this.repository);

  Future<Either<Failure, ProfileEntity>> call() async {
    return await repository.getCachedProfileDetails();
  }
}
