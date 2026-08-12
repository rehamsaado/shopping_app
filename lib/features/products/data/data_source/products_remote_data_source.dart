import '../../../../core/constants/app_constants.dart';
import '../../../../core/network/api_service.dart';
import '../models/product_model.dart';

abstract class ProductsRemoteDataSource {
  Future<List<ProductModel>> getProducts();
  Future<ProductModel> getProductDetails(int id);
  Future<List<ProductModel>> getProductsByCategory(String category);
  Future<List<String>> getCategories();
  Future<ProductModel> addProduct(Map<String, dynamic> productData);
  Future<ProductModel> updateProduct(int id, Map<String, dynamic> productData);
  Future<bool> deleteProduct(int id);
}

class ProductsRemoteDataSourceImpl implements ProductsRemoteDataSource {
  final ApiService _apiService;

  ProductsRemoteDataSourceImpl({required ApiService apiService})
      : _apiService = apiService;

  @override
  Future<List<ProductModel>> getProducts() async {
    final response = await _apiService.get(path: ApiConstants.products);
    final data = response as List;
    return data.map((json) => ProductModel.fromJson(json as Map<String, dynamic>)).toList();
  }

  @override
  Future<ProductModel> getProductDetails(int id) async {
    final response = await _apiService.get(path: '${ApiConstants.products}/$id');
    final data = response as Map<String, dynamic>;
    return ProductModel.fromJson(data);
  }

  @override
  Future<List<ProductModel>> getProductsByCategory(String category) async {
    final response = await _apiService.get(path: '${ApiConstants.productsByCategory}/$category');
    final data = response as List;
    return data.map((json) => ProductModel.fromJson(json as Map<String, dynamic>)).toList();
  }

  @override
  Future<List<String>> getCategories() async {
    final response = await _apiService.get(path: ApiConstants.categories);
    final data = response as List;
    return data.map((category) => category.toString()).toList();
  }

  @override
  Future<ProductModel> addProduct(Map<String, dynamic> productData) async {
    final response = await _apiService.post(
      path: ApiConstants.products,
      data: productData,
    );
    final data = response as Map<String, dynamic>;
    return ProductModel.fromJson(data);
  }

  @override
  Future<ProductModel> updateProduct(int id, Map<String, dynamic> productData) async {
    final response = await _apiService.put(
      path: '${ApiConstants.products}/$id',
      data: productData,
    );
    final data = response as Map<String, dynamic>;
    return ProductModel.fromJson(data);
  }

  @override
  Future<bool> deleteProduct(int id) async {
    await _apiService.delete(path: '${ApiConstants.products}/$id');
    return true;
  }
}