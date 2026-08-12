import 'package:equatable/equatable.dart';

class CartProductEntity extends Equatable {
  final int productId;
  final int quantity;
  final double price;

  const CartProductEntity({
    required this.productId,
    required this.quantity,
    required this.price,
  });

  CartProductEntity copyWith({
    int? productId,
    int? quantity,
    double? price,
  }) {
    return CartProductEntity(
      productId: productId ?? this.productId,
      quantity: quantity ?? this.quantity,
      price: price ?? this.price,
    );
  }

  @override
  List<Object?> get props => [productId, quantity, price];
}