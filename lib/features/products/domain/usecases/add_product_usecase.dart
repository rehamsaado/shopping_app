import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/product_entity.dart';
import '../repositories/products_repository.dart';

class AddProductUseCase {
  final ProductsRepository _repository;

  const AddProductUseCase(this._repository);

  Future<Either<Failure, ProductEntity>> call(Map<String, dynamic> productData) async {
    return await _repository.addProduct(productData);
  }
}