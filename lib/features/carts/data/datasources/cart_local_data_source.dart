import 'dart:convert';

import '../../../../core/error/exceptions.dart';
import '../../../../core/local/app_preferences.dart';
import '../models/cart_model.dart';
import '../models/cart_product_model.dart';

abstract class CartLocalDataSource {
  Future<List<CartModel>> getAllCarts();

  Future<CartModel> getCartById(int cartId);

  Future<void> saveCart(CartModel cart);

  Future<void> saveAllCarts(List<CartModel> carts);

  Future<void> deleteCart(int cartId);

  Future<bool> isEmpty();

  static const String cartsStorageKey = 'CARTS_LOCAL_DATA';
  static const String deletedCartsStorageKey = 'DELETED_CARTS_LOCAL_IDS';
}

class CartLocalDataSourceImpl implements CartLocalDataSource {
  final AppPreferences appPreferences;

  const CartLocalDataSourceImpl(this.appPreferences);

  List<CartModel> _readAll() {
    final raw = appPreferences.getData(
      key: CartLocalDataSource.cartsStorageKey,
    );

    if (raw == null || raw is! String || raw.isEmpty) return [];

    try {
      final List<dynamic> decoded = jsonDecode(raw) as List<dynamic>;
      return decoded
          .map((e) => CartModel.fromJson(e as Map<String, dynamic>))
          .toList();
    } catch (e) {
      throw CacheException('failed_to_read_local_carts: $e');
    }
  }

  Future<void> _writeAll(List<CartModel> carts) async {
    try {
      final jsonStr = jsonEncode(carts.map((c) => c.toJson()).toList());
      final success = await appPreferences.setData(
        key: CartLocalDataSource.cartsStorageKey,
        value: jsonStr,
      );
      if (!success) {
        throw const CacheException('failed_to_save_local_carts');
      }
    } on CacheException {
      rethrow;
    } catch (e) {
      throw CacheException('failed_to_save_local_carts: $e');
    }
  }

  List<int> _getDeletedIds() {
    final raw = appPreferences.getData(
      key: CartLocalDataSource.deletedCartsStorageKey,
    );
    if (raw == null || raw is! String || raw.isEmpty) return [];
    try {
      final List<dynamic> decoded = jsonDecode(raw) as List<dynamic>;
      return decoded.map((e) => e as int).toList();
    } catch (_) {
      return [];
    }
  }

  Future<void> _addDeletedId(int cartId) async {
    final deletedIds = _getDeletedIds();
    if (!deletedIds.contains(cartId)) {
      deletedIds.add(cartId);
      await appPreferences.setData(
        key: CartLocalDataSource.deletedCartsStorageKey,
        value: jsonEncode(deletedIds),
      );
    }
  }

  @override
  Future<void> deleteCart(int cartId) async {
    final carts = _readAll();
    carts.removeWhere((c) => c.id == cartId);
    await _writeAll(carts);
    await _addDeletedId(cartId);
  }

  @override
  Future<void> saveCart(CartModel cart) async {
    if (_getDeletedIds().contains(cart.id)) return;

    final carts = _readAll();

    if (cart.products.isEmpty) {
      await deleteCart(cart.id);
      return;
    }

    final index = carts.indexWhere((c) => c.id == cart.id);
    if (index >= 0) {
      final existingCart = carts[index];

      final Map<int, CartProductModel> productMap = {
        for (var p in existingCart.products)
          p.productId: (p is CartProductModel
              ? p
              : CartProductModel.fromEntity(p)),
      };

      for (var newP in cart.products) {
        final cartProductModel = newP is CartProductModel
            ? newP
            : CartProductModel.fromEntity(newP);
        if (productMap.containsKey(newP.productId)) {
          final oldP = productMap[newP.productId]!;
          productMap[newP.productId] = CartProductModel(
            productId: oldP.productId,
            quantity: newP.quantity,
            price: newP.price,
          );
        } else {
          productMap[newP.productId] = cartProductModel;
        }
      }

      carts[index] = CartModel(
        id: existingCart.id,
        userId: existingCart.userId,
        date: cart.date,
        products: productMap.values.toList(),
        name: cart.name ?? existingCart.name,
      );
    } else {
      carts.add(cart);
    }
    await _writeAll(carts);
  }

  @override
  Future<List<CartModel>> getAllCarts() async {
    var carts = _readAll();
    final deletedIds = _getDeletedIds();

    if (deletedIds.isNotEmpty) {
      carts = carts.where((c) => !deletedIds.contains(c.id)).toList();
    }

    carts.sort((a, b) => b.date.compareTo(a.date));
    return carts;
  }

  @override
  Future<CartModel> getCartById(int cartId) async {
    if (_getDeletedIds().contains(cartId)) {
      throw NotFoundException('cart_not_found_locally');
    }

    final carts = _readAll();
    final matches = carts.where((c) => c.id == cartId);
    if (matches.isEmpty) {
      throw NotFoundException('cart_not_found_locally');
    }
    return matches.first;
  }

  @override
  Future<void> saveAllCarts(List<CartModel> carts) async {
    final deletedIds = _getDeletedIds();
    final filteredCarts = carts
        .where((c) => !deletedIds.contains(c.id))
        .toList();

    final current = _readAll();
    final merged = {for (final c in current) c.id: c};
    for (final c in filteredCarts) {
      merged[c.id] = c;
    }
    await _writeAll(merged.values.toList());
  }

  @override
  Future<bool> isEmpty() async {
    final carts = await getAllCarts();
    return carts.isEmpty;
  }
}
