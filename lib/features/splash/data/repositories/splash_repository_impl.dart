import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../domain/repositories/splash_repository.dart';
import '../datasources/splash_local_data_source.dart';

class SplashRepositoryImpl implements SplashRepository {
  final SplashLocalDataSource _localDataSource;

  SplashRepositoryImpl({required SplashLocalDataSource localDataSource})
    : _localDataSource = localDataSource;

  @override
  Future<Either<Failure, bool>> isFirstTime() async {
    try {
      final result = _localDataSource.isFirstTime();
      return Right(result);
    } catch (e) {
      return Left(CacheFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, bool>> isLoggedIn() async {
    try {
      final token = _localDataSource.getToken();
      if (token != null && token.isNotEmpty) {
        return const Right(true);
      }
      return const Right(false);
    } catch (e) {
      return Left(CacheFailure( message: e.toString(), ));
    }
  }
}
