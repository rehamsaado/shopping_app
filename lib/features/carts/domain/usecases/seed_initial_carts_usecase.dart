import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/cart_entity.dart';
import '../repositories/cart_repository.dart';

class SeedInitialCartsIfEmptyUseCase {
  final CartRepository _repository;

  const SeedInitialCartsIfEmptyUseCase(this._repository);

  Future<Either<Failure, void>> call(List<CartEntity> carts) async {
    return await _repository.seedInitialCartsIfEmpty(carts);
  }
}