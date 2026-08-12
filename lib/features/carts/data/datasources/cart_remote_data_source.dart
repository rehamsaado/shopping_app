import '../../../../core/constants/app_constants.dart';
import '../../../../core/network/api_service.dart';
import '../models/cart_model.dart';

abstract class CartRemoteDataSource {
  Future<List<CartModel>> getAllCarts();
  Future<CartModel> getCartById(int cartId);
}

class CartRemoteDataSourceImpl implements CartRemoteDataSource {
  final ApiService _apiService;

  const CartRemoteDataSourceImpl(this._apiService);

  @override
  Future<List<CartModel>> getAllCarts() async {
    final response = await _apiService.get(path: ApiConstants.carts);

    final List<dynamic> data = response as List<dynamic>;
    return data
        .map((json) => CartModel.fromJson(json as Map<String, dynamic>))
        .toList();
  }

  @override
  Future<CartModel> getCartById(int cartId) async {
    final response = await _apiService.get(path: '${ApiConstants.carts}/$cartId');

    return CartModel.fromJson(response as Map<String, dynamic>);
  }
}