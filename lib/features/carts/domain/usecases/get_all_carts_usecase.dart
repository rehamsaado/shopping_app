import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/cart_entity.dart';
import '../repositories/cart_repository.dart';

class GetAllCartsUseCase {
  final CartRepository _repository;

  const GetAllCartsUseCase(this._repository);

  Future<Either<Failure, List<CartEntity>>> call() async {
    return await _repository.getAllCarts();
  }
}