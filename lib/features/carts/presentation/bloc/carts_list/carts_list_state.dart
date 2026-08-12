import 'package:equatable/equatable.dart';

import '../../../domain/entities/cart_entity.dart';

enum CartsListStatus { initial, loading, success, failure }

class CartsListState extends Equatable {
  final CartsListStatus status;
  final List<CartEntity> carts;
  final String? errorMessage;

  const CartsListState({
    this.status = CartsListStatus.initial,
    this.carts = const [],
    this.errorMessage,
  });

  bool get isLoading => status == CartsListStatus.loading;
  bool get isEmpty => status == CartsListStatus.success && carts.isEmpty;

  CartsListState copyWith({
    CartsListStatus? status,
    List<CartEntity>? carts,
    String? errorMessage,
  }) {
    return CartsListState(
      status: status ?? this.status,
      carts: carts ?? this.carts,
      errorMessage: errorMessage,
    );
  }

  @override
  List<Object?> get props => [status, carts, errorMessage];
}
