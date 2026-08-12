import 'package:equatable/equatable.dart';

abstract class AppException extends Equatable implements Exception {
  final String message;
  final int? statusCode;

  const AppException(this.message, [this.statusCode]);

  @override
  List<Object?> get props => [message, statusCode];
}
class ServerException extends AppException {
  const ServerException([
    super.message = 'error_server',
    super.statusCode,
  ]);
}

class NetworkException extends AppException {
  const NetworkException([
    super.message = 'error_network',
  ]);
}

class UnauthorizedException extends AppException {
  const UnauthorizedException([
    super.message = 'error_unauthorized',
    int super.statusCode = 401,
  ]);
}

class NotFoundException extends AppException {
  const NotFoundException([
    super.message = 'error_not_found',
    int super.statusCode = 404,
  ]);
}

class TimeoutException extends AppException {
  const TimeoutException([
    super.message = 'error_timeout',
  ]);
}

class CacheException extends AppException {
  const CacheException([
    super.message = 'error_cache',
  ]);
}