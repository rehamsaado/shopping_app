import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/usecases/check_app_start_status_usecase.dart';
import 'splash_state.dart';

class SplashCubit extends Cubit<SplashState> {
  final CheckAppStartStatusUseCase _checkAppStartStatusUseCase;

  SplashCubit({
    required CheckAppStartStatusUseCase checkAppStartStatusUseCase,
  })  : _checkAppStartStatusUseCase = checkAppStartStatusUseCase,
        super(const SplashInitial());

  Future<void> checkStatus() async {
    emit(const SplashLoading());

    await Future.delayed(const Duration(seconds: 2));

    final result = await _checkAppStartStatusUseCase();

    result.fold(
          (failure) => emit(const SplashUnauthenticated()),
          (status) {
        switch (status) {
          case AppStartStatus.onboarding:
            emit(const SplashOnboarding());
            break;
          case AppStartStatus.authenticated:
            emit(const SplashAuthenticated());
            break;
          case AppStartStatus.unauthenticated:
            emit(const SplashUnauthenticated());
            break;
        }
      },
    );
  }
}