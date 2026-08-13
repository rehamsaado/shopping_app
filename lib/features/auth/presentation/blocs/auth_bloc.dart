import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/constants/user_session.dart';
import '../../../../core/error/failures.dart';
import '../../domain/repositories/auth_repository.dart';
import 'auth_event.dart';
import 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository authRepository;
  final UserSession userSession;

  final Map<String, String> _userMapping = {
    'johnd': '1',
    'mor_2314': '2',
    'kevinryan': '3',
    'donero': '4',
    'derek': '5',
    'david_r': '6',
    'snyder': '7',
    'hopkins': '8',
    'kate_h': '9',
    'jimmie_k': '10',
  };

  AuthBloc({required this.authRepository, required this.userSession})
    : super(AuthInitial()) {
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

    final resolvedUserId = _userMapping[event.username.trim()];
    if (resolvedUserId == null) {
      emit(const AuthFailure('user_not_found_mapping_error'));
      return;
    }

    final result = await authRepository.login(
      username: event.username,
      password: event.password,
    );

    await result.fold(
      (failure) async => emit(AuthFailure(_mapFailureToMessage(failure))),
      (userEntity) async {
        await userSession.saveUserId(resolvedUserId);
        emit(AuthSuccess(userEntity));
      },
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
      (userEntity) => emit(AuthSuccess(userEntity)),
    );
  }

  Future<void> _onCheckAuthStatusRequested(
    CheckAuthStatusRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());

    final result = await authRepository.getSavedUser();

    result.fold((_) => emit(Unauthenticated()), (userEntity) {
      if (userEntity != null) {
        emit(AuthSuccess(userEntity));
      } else {
        emit(Unauthenticated());
      }
    });
  }

  Future<void> _onLogoutRequested(
    LogoutRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());

    final result = await authRepository.logout();

    await result.fold(
      (failure) async => emit(AuthFailure(_mapFailureToMessage(failure))),
      (_) async {
        await userSession.clearSession();
        emit(Unauthenticated());
      },
    );
  }

  String _mapFailureToMessage(Failure failure) {
    if (failure is NetworkFailure) return failure.message;
    if (failure is UnauthorizedFailure) return failure.message;
    if (failure is ServerFailure) return failure.message;
    if (failure is CacheFailure) return failure.message;
    if (failure is ValidationFailure) return failure.message;
    return failure.message.isNotEmpty ? failure.message : 'حدث خطأ غير متوقع';
  }
}
