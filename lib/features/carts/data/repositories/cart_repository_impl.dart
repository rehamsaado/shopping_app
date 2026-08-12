import 'package:dartz/dartz.dart';

import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failures.dart';
import '../../domain/entities/cart_entity.dart';
import '../../domain/entities/cart_product_entity.dart';
import '../../domain/repositories/cart_repository.dart';
import '../datasources/cart_local_data_source.dart';
import '../datasources/cart_remote_data_source.dart';
import '../models/cart_model.dart';

class CartRepositoryImpl implements CartRepository {
  final CartLocalDataSource localDataSource;
  final CartRemoteDataSource remoteDataSource;

  const CartRepositoryImpl({
    required this.localDataSource,
    required this.remoteDataSource,
  });

  @override
  Future<Either<Failure, List<CartEntity>>> getAllCarts() async {
    try {
      final localCarts = await localDataSource.getAllCarts();
      final localCartsMap = {for (var c in localCarts) c.id: c};

      try {
        final remoteCarts = await remoteDataSource.getAllCarts();
        final List<CartModel> cartsToSave = [];
        for (var remoteCart in remoteCarts) {
          if (localCartsMap.containsKey(remoteCart.id)) {
            cartsToSave.add(
              CartModel.fromEntity(localCartsMap[remoteCart.id]!),
            );
          } else {
            cartsToSave.add(CartModel.fromEntity(remoteCart));
          }
        }
        await localDataSource.saveAllCarts(cartsToSave);
      } catch (_) {}

      final finalLocalCarts = await localDataSource.getAllCarts();
      return Right(finalLocalCarts);
    } catch (e) {
      return Left(CacheFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, CartEntity>> getCartById(int cartId) async {
    try {
      final cart = await localDataSource.getCartById(cartId);
      return Right(cart);
    } on NotFoundException catch (e) {
      return Left(CacheFailure(message: e.message));
    } on CacheException catch (e) {
      return Left(CacheFailure(message: e.message));
    } catch (e) {
      return Left(CacheFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, CartEntity>> createCart(CartEntity cart) async {
    try {
      final model = CartModel.fromEntity(cart);
      await localDataSource.saveCart(model);
      return Right(model);
    } on CacheException catch (e) {
      return Left(CacheFailure(message: e.message));
    } catch (e) {
      return Left(CacheFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, CartEntity>> saveCart(CartEntity cart) async {
    try {
      final model = CartModel.fromEntity(cart);
      await localDataSource.saveCart(model);
      return Right(model);
    } on CacheException catch (e) {
      return Left(CacheFailure(message: e.message));
    } catch (e) {
      return Left(CacheFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, CartEntity>> updateProductQuantity({
    required int cartId,
    required int productId,
    required int newQuantity,
  }) async {
    try {
      final cart = await localDataSource.getCartById(cartId);

      final productExists = cart.products.any((p) => p.productId == productId);
      if (!productExists) {
        return const Left(
          ValidationFailure(message: 'product_not_found_in_cart'),
        );
      }

      List<CartProductEntity> updatedProducts;

      if (newQuantity <= 0) {
        updatedProducts = cart.products
            .where((p) => p.productId != productId)
            .toList();
      } else {
        final Map<int, CartProductEntity> productMap = {};
        for (var p in cart.products) {
          if (p.productId == productId) {
            productMap[productId] = p.copyWith(quantity: newQuantity);
          } else {
            productMap[p.productId] = p;
          }
        }
        updatedProducts = productMap.values.toList();
      }

      final updatedCart = cart.copyWithProducts(updatedProducts);
      await localDataSource.saveCart(updatedCart);
      return Right(updatedCart);
    } on NotFoundException catch (e) {
      return Left(CacheFailure(message: e.message));
    } on CacheException catch (e) {
      return Left(CacheFailure(message: e.message));
    } catch (e) {
      return Left(CacheFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, CartEntity>> removeProductFromCart({
    required int cartId,
    required int productId,
  }) async {
    return updateProductQuantity(
      cartId: cartId,
      productId: productId,
      newQuantity: 0,
    );
  }

  @override
  Future<Either<Failure, void>> seedInitialCartsIfEmpty(
      List<CartEntity> carts,
      ) async {
    try {
      final isEmpty = await localDataSource.isEmpty();
      if (isEmpty) {
        final models = carts.map((c) => CartModel.fromEntity(c)).toList();
        await localDataSource.saveAllCarts(models);
      }
      return const Right(null);
    } on CacheException catch (e) {
      return Left(CacheFailure(message: e.message));
    } catch (e) {
      return Left(CacheFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> deleteCart(int cartId) async {
    try {
      await localDataSource.deleteCart(cartId);
      return const Right(null);
    } catch (e) {
      return Left(CacheFailure(message: e.toString()));
    }
  }
}