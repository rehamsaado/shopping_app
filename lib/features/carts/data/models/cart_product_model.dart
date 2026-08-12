import '../../../../core/constants/app_constants.dart';
import '../../domain/entities/cart_product_entity.dart';

class CartProductModel extends CartProductEntity {
  const CartProductModel({
    required super.productId,
    required super.quantity,
    required super.price,
  });

  factory CartProductModel.fromJson(Map<String, dynamic> json) {
    final int pId = json[ApiConstants.keyProductId] as int;
    final double parsedPrice =
        (json['price'] as num?)?.toDouble() ?? (pId * 15.0 + 10.0);

    return CartProductModel(
      productId: pId,
      quantity: json[ApiConstants.keyQuantity] as int,
      price: parsedPrice,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      ApiConstants.keyProductId: productId,
      ApiConstants.keyQuantity: quantity,
      'price': price,
    };
  }

  factory CartProductModel.fromEntity(CartProductEntity entity) {
    return CartProductModel(
      productId: entity.productId,
      quantity: entity.quantity,
      price: entity.price,
    );
  }
}
