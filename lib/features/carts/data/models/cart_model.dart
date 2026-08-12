import '../../../../core/constants/app_constants.dart';
import '../../domain/entities/cart_entity.dart';
import '../../domain/entities/cart_product_entity.dart';
import 'cart_product_model.dart';

class CartModel extends CartEntity {
  const CartModel({
    required super.id,
    required super.userId,
    required super.date,
    required super.products,
    super.name,
  });

  factory CartModel.fromJson(Map<String, dynamic> json) {
    return CartModel(
      id: json[ApiConstants.keyId] as int,
      userId: json[ApiConstants.keyUserId] as int,
      date: DateTime.parse(json[ApiConstants.keyDate] as String),
      products: (json[ApiConstants.keyProducts] as List<dynamic>)
          .map((p) => CartProductModel.fromJson(p as Map<String, dynamic>))
          .toList(),
      name: json['name'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      ApiConstants.keyId: id,
      ApiConstants.keyUserId: userId,
      ApiConstants.keyDate: date.toIso8601String(),
      ApiConstants.keyProducts: products
          .map((p) => CartProductModel.fromEntity(p).toJson())
          .toList(),
      'name': name,
      '__v': 0,
    };
  }

  factory CartModel.fromEntity(CartEntity entity) {
    return CartModel(
      id: entity.id,
      userId: entity.userId,
      date: entity.date,
      products: entity.products
          .map((p) => CartProductModel.fromEntity(p))
          .toList(),
      name: entity.name,
    );
  }

  @override
  CartModel copyWith({
    int? id,
    int? userId,
    DateTime? date,
    List<CartProductEntity>? products,
    String? name,
  }) {
    return CartModel(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      date: date ?? this.date,
      products: products ?? this.products,
      name: name ?? this.name,
    );
  }

  CartModel copyWithProducts(List<CartProductEntity> products) {
    return CartModel(
      id: id,
      userId: userId,
      date: date,
      products: products,
      name: name,
    );
  }
}