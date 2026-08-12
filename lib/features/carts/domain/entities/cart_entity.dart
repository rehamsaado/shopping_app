import 'package:equatable/equatable.dart';

import 'cart_product_entity.dart';

class CartEntity extends Equatable {
  final int id;
  final int userId;
  final DateTime date;
  final List<CartProductEntity> products;
  final String? name;

  const CartEntity({
    required this.id,
    required this.userId,
    required this.date,
    required this.products,
    this.name,
  });

  int get totalProductsCount => products.length;

  int get totalQuantity =>
      products.fold(0, (sum, product) => sum + product.quantity);

  bool get isEmpty => products.isEmpty;

  CartEntity copyWith({
    int? id,
    int? userId,
    DateTime? date,
    List<CartProductEntity>? products,
    String? name,
  }) {
    return CartEntity(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      date: date ?? this.date,
      products: products ?? this.products,
      name: name ?? this.name,
    );
  }

  @override
  List<Object?> get props => [
    id,
    userId,
    date,
    name,
   products.map((p) => '${p.productId}-${p.quantity}-${p.price}').toList(),
  ];
}
