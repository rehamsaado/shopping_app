import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/product_entity.dart';
import '../repositories/products_repository.dart';

class GetProductDetailsUseCase {
  final ProductsRepository _repository;

  const GetProductDetailsUseCase(this._repository);

  Future<Either<Failure, ProductEntity>> call(int id) async {
    return await _repository.getProductDetails(id);
  }
}