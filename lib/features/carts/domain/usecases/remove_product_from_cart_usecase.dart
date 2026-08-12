import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/cart_entity.dart';
import '../repositories/cart_repository.dart';

class RemoveProductFromCartUseCase {
  final CartRepository _repository;

  const RemoveProductFromCartUseCase(this._repository);

  Future<Either<Failure, CartEntity>> call({
    required int cartId,
    required int productId,
  }) async {
    return await _repository.removeProductFromCart(
      cartId: cartId,
      productId: productId,
    );
  }
}