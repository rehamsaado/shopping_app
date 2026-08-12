import 'package:equatable/equatable.dart';

import '../../../domain/entities/cart_entity.dart';

enum CartDetailsStatus { initial, loading, success, failure }

class CartDetailsState extends Equatable {
  final CartDetailsStatus status;
  final CartEntity? cart;
  final String? errorMessage;


  final int? updatingProductId;

  const CartDetailsState({
    this.status = CartDetailsStatus.initial,
    this.cart,
    this.errorMessage,
    this.updatingProductId,
  });

  bool get isLoading => status == CartDetailsStatus.loading;

  CartDetailsState copyWith({
    CartDetailsStatus? status,
    CartEntity? cart,
    String? errorMessage,
    int? updatingProductId,
    bool clearUpdatingProductId = false,
  }) {
    return CartDetailsState(
      status: status ?? this.status,
      cart: cart ?? this.cart,
      errorMessage: errorMessage,
      updatingProductId: clearUpdatingProductId
          ? null
          : (updatingProductId ?? this.updatingProductId),
    );
  }

  @override
  List<Object?> get props => [status, cart, errorMessage, updatingProductId];
}
