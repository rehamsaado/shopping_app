import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/cart_entity.dart';
import '../repositories/cart_repository.dart';

class SaveCartUseCase {
  final CartRepository _repository;

  const SaveCartUseCase(this._repository);

  Future<Either<Failure, CartEntity>> call(CartEntity cart) async {
    return await _repository.saveCart(cart);
  }
}