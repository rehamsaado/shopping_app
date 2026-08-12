import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../entities/cart_entity.dart';

abstract class CartRepository {
  Future<Either<Failure, List<CartEntity>>> getAllCarts();

  Future<Either<Failure, CartEntity>> getCartById(int cartId);

  Future<Either<Failure, CartEntity>> createCart(CartEntity cart);
  Future<Either<Failure, void>> deleteCart(int cartId);
  Future<Either<Failure, CartEntity>> saveCart(CartEntity cart);

  Future<Either<Failure, CartEntity>> updateProductQuantity({
    required int cartId,
    required int productId,
    required int newQuantity,
  });

  Future<Either<Failure, CartEntity>> removeProductFromCart({
    required int cartId,
    required int productId,
  });

  Future<Either<Failure, void>> seedInitialCartsIfEmpty(List<CartEntity> carts);
}
