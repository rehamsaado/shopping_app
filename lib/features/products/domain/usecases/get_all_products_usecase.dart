import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/product_entity.dart';
import '../repositories/products_repository.dart';

class GetProductsUseCase {
  final ProductsRepository _repository;

  const GetProductsUseCase(this._repository);

  Future<Either<Failure, List<ProductEntity>>> call() async {
    return await _repository.getProducts();
  }
}