import 'package:dartz/dartz.dart';
import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/network/network_info.dart';
import '../../domain/entity/profile_entity.dart';
import '../../domain/repository/profile_repository.dart';
import '../data_source/profile_local_data_source.dart';
import '../data_source/profile_remote_data_source.dart';
import '../model/profile_model.dart';

class ProfileRepositoryImpl implements ProfileRepository {
  final ProfileRemoteDataSource remoteDataSource;
  final ProfileLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  ProfileRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, ProfileEntity>> getProfileDetails(
      String userId,
      ) async {
    if (await networkInfo.isConnected) {
      try {
        final remoteProfile = await remoteDataSource.getProfileDetails(userId);
        await localDataSource.cacheProfileDetails(remoteProfile);
        return Right(remoteProfile);
      } on ServerException catch (e) {
        return Left(ServerFailure(message: e.message));
      }
    } else {
      try {
        final localProfile = await localDataSource.getCachedProfileDetails();
        return Right(localProfile);
      } on CacheException {
        return const Left(CacheFailure(message: 'no_cached_data_available'));
      }
    }
  }

  @override
  Future<Either<Failure, Unit>> cacheProfileDetails(
      ProfileEntity profile,
      ) async {
    try {
      final profileModel = ProfileModel(
        id: profile.id,
        email: profile.email,
        username: profile.username,
        password: profile.password,
        name: profile.name,
        address: profile.address,
        phone: profile.phone,
      );
      await localDataSource.cacheProfileDetails(profileModel);
      return const Right(unit);
    } on CacheException {
      return const Left(CacheFailure(message: 'failed_to_cache_profile'));
    }
  }

  @override
  Future<Either<Failure, ProfileEntity>> getCachedProfileDetails() async {
    try {
      final localProfile = await localDataSource.getCachedProfileDetails();
      return Right(localProfile);
    } on CacheException {
      return const Left(CacheFailure(message: 'no_cached_profile_found'));
    }
  }
}