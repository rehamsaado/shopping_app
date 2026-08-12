import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../repositories/products_repository.dart';

class DeleteProductUseCase {
  final ProductsRepository _repository;

  const DeleteProductUseCase(this._repository);

  Future<Either<Failure, bool>> call(int id) async {
    return await _repository.deleteProduct(id);
  }
}