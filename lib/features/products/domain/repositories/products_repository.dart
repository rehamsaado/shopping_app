import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/product_entity.dart';

abstract class ProductsRepository {
  // GET all
  Future<Either<Failure, List<ProductEntity>>> getProducts();

  // GET single
  Future<Either<Failure, ProductEntity>> getProductDetails(int id);

  // POST
  Future<Either<Failure, ProductEntity>> addProduct(
    Map<String, dynamic> productData,
  );

  // PUT
  Future<Either<Failure, ProductEntity>> updateProduct(
    int id,
    Map<String, dynamic> productData,
  );

  // DELETE
  Future<Either<Failure, bool>> deleteProduct(int id);

  Future<Either<Failure, List<ProductEntity>>> getProductsByCategory(
    String category,
  );

  Future<Either<Failure, List<String>>> getCategories();
}
