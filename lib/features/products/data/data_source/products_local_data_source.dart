import 'dart:convert';
import '../../../../core/local/app_preferences.dart';
import '../../../../core/error/exceptions.dart';
import '../models/product_model.dart';

abstract class ProductsLocalDataSource {
  Future<void> cacheProducts(List<ProductModel> products);
  List<ProductModel> getCachedProducts();
  Future<void> clearCachedProducts();
}

class ProductsLocalDataSourceImpl implements ProductsLocalDataSource {
  final AppPreferences _appPreferences;

  static const String _cachedProductsKey = 'cached_products';

  ProductsLocalDataSourceImpl({required AppPreferences appPreferences})
      : _appPreferences = appPreferences;

  @override
  Future<void> cacheProducts(List<ProductModel> products) async {
    try {
      final jsonList = products.map((product) => product.toJson()).toList();
      final jsonString = jsonEncode(jsonList);
      await _appPreferences.setData(key: _cachedProductsKey, value: jsonString);
    } catch (_) {
      throw const CacheException();
    }
  }

  @override
  List<ProductModel> getCachedProducts() {
    final jsonString = _appPreferences.getData(key: _cachedProductsKey) as String?;
    if (jsonString == null || jsonString.isEmpty) {
      throw const CacheException();
    }

    try {
      final jsonList = jsonDecode(jsonString) as List;
      return jsonList
          .map((json) => ProductModel.fromJson(json as Map<String, dynamic>))
          .toList();
    } catch (_) {
      throw const CacheException();
    }
  }

  @override
  Future<void> clearCachedProducts() async {
    await _appPreferences.removeData(key: _cachedProductsKey);
  }
}