import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/error/failures.dart';
import '../../domain/repositories/auth_repository.dart';
import 'auth_event.dart';
import 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository authRepository;

  AuthBloc({required this.authRepository}) : super(AuthInitial()) {
    on<LoginSubmitted>(_onLoginSubmitted);
    on<RegisterSubmitted>(_onRegisterSubmitted);
    on<CheckAuthStatusRequested>(_onCheckAuthStatusRequested);
    on<LogoutRequested>(_onLogoutRequested);
  }

  Future<void> _onLoginSubmitted(
      LoginSubmitted event,
      Emitter<AuthState> emit,
      ) async {
    emit(AuthLoading());

    final result = await authRepository.login(
      username: event.username,
      password: event.password,
    );

    result.fold(
          (failure) => emit(AuthFailure(_mapFailureToMessage(failure))),
          (user) => emit(AuthSuccess(user)),
    );
  }

  Future<void> _onRegisterSubmitted(
      RegisterSubmitted event,
      Emitter<AuthState> emit,
      ) async {
    emit(AuthLoading());

    final result = await authRepository.register(
      email: event.email,
      username: event.username,
      password: event.password,
      firstName: event.firstName,
      lastName: event.lastName,
    );

    result.fold(
          (failure) => emit(AuthFailure(_mapFailureToMessage(failure))),
          (user) => emit(AuthSuccess(user)),
    );
  }

  Future<void> _onCheckAuthStatusRequested(
      CheckAuthStatusRequested event,
      Emitter<AuthState> emit,
      ) async {
    emit(AuthLoading());

    final result = await authRepository.getSavedUser();

    result.fold(
          (_) => emit(Unauthenticated()),
          (user) {
        if (user != null) {
          emit(AuthSuccess(user));
        } else {
          emit(Unauthenticated());
        }
      },
    );
  }

  Future<void> _onLogoutRequested(
      LogoutRequested event,
      Emitter<AuthState> emit,
      ) async {
    emit(AuthLoading());

    final result = await authRepository.logout();

    result.fold(
          (failure) => emit(AuthFailure(_mapFailureToMessage(failure))),
          (_) => emit(Unauthenticated()),
    );
  }

  String _mapFailureToMessage(Failure failure) {
    if (failure is NetworkFailure) {
      return failure.message;
    }
    if (failure is UnauthorizedFailure) {
      return failure.message;
    }
    if (failure is ServerFailure) {
      return failure.message;
    }
    if (failure is CacheFailure) {
      return failure.message;
    }
    if (failure is ValidationFailure) {
      return failure.message;
    }
    return failure.message.isNotEmpty ? failure.message : 'حدث خطأ غير متوقع';
  }
}