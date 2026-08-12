import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  final String message;
  final int? statusCode;

  const Failure({required this.message, this.statusCode});

  @override
  List<Object?> get props => [message, statusCode];
}

class ServerFailure extends Failure {
  const ServerFailure({super.message = 'error_server', super.statusCode});
}

class UnauthorizedFailure extends Failure {
  const UnauthorizedFailure({
    super.message = 'error_unauthorized',
    super.statusCode = 401,
  });
}

class CacheFailure extends Failure {
  const CacheFailure({super.message = 'error_cache'});
}

class NetworkFailure extends Failure {
  const NetworkFailure({super.message = 'error_network'});
}

class AiFailure extends Failure {
  const AiFailure({super.message = 'error_ai'});
}

class ValidationFailure extends Failure {
  const ValidationFailure({required super.message});
 }
