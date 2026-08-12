import 'package:equatable/equatable.dart';

abstract class CartDetailsEvent extends Equatable {
  const CartDetailsEvent();

  @override
  List<Object?> get props => [];
}

class LoadCartDetailsEvent extends CartDetailsEvent {
  final int cartId;
  const LoadCartDetailsEvent(this.cartId);

  @override
  List<Object?> get props => [cartId];
}

class IncrementProductQuantityEvent extends CartDetailsEvent {
  final int productId;
  const IncrementProductQuantityEvent(this.productId);

  @override
  List<Object?> get props => [productId];
}

class DecrementProductQuantityEvent extends CartDetailsEvent {
  final int productId;
  const DecrementProductQuantityEvent(this.productId);

  @override
  List<Object?> get props => [productId];
}

class RemoveProductEvent extends CartDetailsEvent {
  final int productId;
  const RemoveProductEvent(this.productId);

  @override
  List<Object?> get props => [productId];
}
