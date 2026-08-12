import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/product_entity.dart';
import '../repositories/products_repository.dart';

class UpdateProductUseCase {
  final ProductsRepository _repository;

  const UpdateProductUseCase(this._repository);

  Future<Either<Failure, ProductEntity>> call(int id, Map<String, dynamic> productData) async {
    return await _repository.updateProduct(id, productData);
  }
}