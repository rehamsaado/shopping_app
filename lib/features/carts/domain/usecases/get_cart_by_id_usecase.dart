import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/cart_entity.dart';
import '../repositories/cart_repository.dart';

class GetCartByIdUseCase {
  final CartRepository _repository;

  const GetCartByIdUseCase(this._repository);

  Future<Either<Failure, CartEntity>> call(int cartId) async {
    return await _repository.getCartById(cartId);
  }
}