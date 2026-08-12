import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/cart_entity.dart';
import '../repositories/cart_repository.dart';

class UpdateProductQuantityUseCase {
  final CartRepository _repository;

  const UpdateProductQuantityUseCase(this._repository);

  Future<Either<Failure, CartEntity>> call({
    required int cartId,
    required int productId,
    required int newQuantity,
  }) async {
    return await _repository.updateProductQuantity(
      cartId: cartId,
      productId: productId,
      newQuantity: newQuantity,
    );
  }
}