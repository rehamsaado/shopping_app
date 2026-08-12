import 'package:equatable/equatable.dart';

sealed class SplashState extends Equatable {
  const SplashState();

  @override
  List<Object?> get props => [];
}

final class SplashInitial extends SplashState {
  const SplashInitial();
}

final class SplashLoading extends SplashState {
  const SplashLoading();
}

final class SplashOnboarding extends SplashState {
  const SplashOnboarding();
}

final class SplashAuthenticated extends SplashState {
  const SplashAuthenticated();
}

final class SplashUnauthenticated extends SplashState {
  const SplashUnauthenticated();
}