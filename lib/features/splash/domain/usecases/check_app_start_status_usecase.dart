import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../repositories/splash_repository.dart';

enum AppStartStatus { onboarding, authenticated, unauthenticated }

class CheckAppStartStatusUseCase {
  final SplashRepository _repository;

  const CheckAppStartStatusUseCase(this._repository);

  Future<Either<Failure, AppStartStatus>> call() async {
    final isFirstTimeResult = await _repository.isFirstTime();

    return isFirstTimeResult.fold(
          (failure) => Left(failure),
          (isFirst) async {
        if (isFirst) {
          return const Right(AppStartStatus.onboarding);
        }

        final isLoggedInResult = await _repository.isLoggedIn();

        return isLoggedInResult.fold(
              (failure) => Left(failure),
              (isLoggedIn) {
            if (isLoggedIn) {
              return const Right(AppStartStatus.authenticated);
            }
            return const Right(AppStartStatus.unauthenticated);
          },
        );
      },
    );
  }
}