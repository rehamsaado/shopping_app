import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../repositories/cart_repository.dart';

class DeleteCartUseCase {
  final CartRepository repository;

  const DeleteCartUseCase(this.repository);

  Future<Either<Failure, void>> call(int cartId) async {
    return await repository.deleteCart(cartId);
  }
}