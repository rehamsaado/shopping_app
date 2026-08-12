import 'package:equatable/equatable.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object?> get props => [];
}

class LoginSubmitted extends AuthEvent {
  final String username;
  final String password;

  const LoginSubmitted({
    required this.username,
    required this.password,
  });

  @override
  List<Object?> get props => [username, password];
}

class RegisterSubmitted extends AuthEvent {
  final String email;
  final String username;
  final String password;
  final String firstName;
  final String lastName;

  const RegisterSubmitted({
    required this.email,
    required this.username,
    required this.password,
    required this.firstName,
    required this.lastName,
  });

  @override
  List<Object?> get props => [
    email,
    username,
    password,
    firstName,
    lastName,
  ];
}

class CheckAuthStatusRequested extends AuthEvent {}

class LogoutRequested extends AuthEvent {}