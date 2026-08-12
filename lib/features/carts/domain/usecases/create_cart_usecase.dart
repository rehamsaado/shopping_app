import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/cart_entity.dart';
import '../repositories/cart_repository.dart';

class CreateCartUseCase {
  final CartRepository _repository;

  const CreateCartUseCase(this._repository);

  Future<Either<Failure, CartEntity>> call(CartEntity cart) async {
    return await _repository.createCart(cart);
  }
}