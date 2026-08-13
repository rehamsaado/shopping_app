import 'package:equatable/equatable.dart';

import '../../../domain/entities/cart_entity.dart';

abstract class CartsListEvent extends Equatable {
  const CartsListEvent();

  @override
  List<Object?> get props => [];
}

class LoadCartsListEvent extends CartsListEvent {
  final int? userId;

  const LoadCartsListEvent({this.userId});

  @override
  List<Object?> get props => [userId];
}

class CreateCartEvent extends CartsListEvent {
  final CartEntity cart;

  const CreateCartEvent(this.cart);

  @override
  List<Object?> get props => [cart];
}

class DeleteCartEvent extends CartsListEvent {
  final int cartId;

  const DeleteCartEvent(this.cartId);

  @override
  List<Object> get props => [cartId];
}