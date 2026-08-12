import 'package:dartz/dartz.dart';
import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failures.dart';
import '../../domain/entities/product_entity.dart';
import '../../domain/repositories/products_repository.dart';
import '../data_source/products_local_data_source.dart';
import '../data_source/products_remote_data_source.dart';

class ProductsRepositoryImpl implements ProductsRepository {
  final ProductsRemoteDataSource remoteDataSource;
  final ProductsLocalDataSource localDataSource;

  ProductsRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
  });

  @override
  Future<Either<Failure, List<ProductEntity>>> getProducts() async {
    try {
      final remoteProducts = await remoteDataSource.getProducts();
      await localDataSource.cacheProducts(remoteProducts);
      return Right(remoteProducts);
    } on NetworkException catch (e) {
      try {
        final localProducts = localDataSource.getCachedProducts();
        return Right(localProducts);
      } catch (_) {
        return Left(NetworkFailure(message: e.message));
      }
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    } catch (e) {
      return const Left(ServerFailure(message: 'error_server'));
    }
  }

  @override
  Future<Either<Failure, ProductEntity>> getProductDetails(int id) async {
    try {
      final product = await remoteDataSource.getProductDetails(id);
      return Right(product);
    } on NetworkException catch (e) {
      return Left(NetworkFailure(message: e.message));
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    } on NotFoundException catch (e) {
      return Left(ServerFailure(message: e.message));
    } catch (e) {
      return const Left(ServerFailure(message: 'error_server'));
    }
  }

  @override
  Future<Either<Failure, List<ProductEntity>>> getProductsByCategory(
    String category,
  ) async {
    try {
      final products = await remoteDataSource.getProductsByCategory(category);
      return Right(products);
    } on NetworkException catch (e) {
      return Left(NetworkFailure(message: e.message));
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    } catch (e) {
      return const Left(ServerFailure(message: 'error_server'));
    }
  }

  @override
  Future<Either<Failure, List<String>>> getCategories() async {
    try {
      final categories = await remoteDataSource.getCategories();
      return Right(categories);
    } on NetworkException catch (e) {
      return Left(NetworkFailure(message: e.message));
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    } catch (e) {
      return const Left(ServerFailure(message: 'error_server'));
    }
  }

  @override
  Future<Either<Failure, ProductEntity>> addProduct(
    Map<String, dynamic> productData,
  ) async {
    try {
      final product = await remoteDataSource.addProduct(productData);
      return Right(product);
    } on NetworkException catch (e) {
      return Left(NetworkFailure(message: e.message));
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    } catch (e) {
      return const Left(ServerFailure(message: 'error_server'));
    }
  }

  @override
  Future<Either<Failure, ProductEntity>> updateProduct(
    int id,
    Map<String, dynamic> productData,
  ) async {
    try {
      final product = await remoteDataSource.updateProduct(id, productData);
      return Right(product);
    } on NetworkException catch (e) {
      return Left(NetworkFailure(message: e.message));
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    } catch (e) {
      return const Left(ServerFailure(message: 'error_server'));
    }
  }

  @override
  Future<Either<Failure, bool>> deleteProduct(int id) async {
    try {
      final result = await remoteDataSource.deleteProduct(id);
      return Right(result);
    } on NetworkException catch (e) {
      return Left(NetworkFailure(message: e.message));
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    } catch (e) {
      return const Left(ServerFailure(message: 'error_server'));
    }
  }
}
