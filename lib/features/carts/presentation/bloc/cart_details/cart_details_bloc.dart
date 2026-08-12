import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/entities/cart_product_entity.dart';
import '../../../domain/usecases/get_cart_by_id_usecase.dart';
import '../../../domain/usecases/remove_product_from_cart_usecase.dart';
import '../../../domain/usecases/update_product_quantity_usecase.dart';
import 'cart_details_event.dart';
import 'cart_details_state.dart';

class CartDetailsBloc extends Bloc<CartDetailsEvent, CartDetailsState> {
  final GetCartByIdUseCase getCartByIdUseCase;
  final UpdateProductQuantityUseCase updateProductQuantityUseCase;
  final RemoveProductFromCartUseCase removeProductFromCartUseCase;

  CartDetailsBloc({
    required this.getCartByIdUseCase,
    required this.updateProductQuantityUseCase,
    required this.removeProductFromCartUseCase,
  }) : super(const CartDetailsState()) {
    on<LoadCartDetailsEvent>(_onLoadCartDetails);
    on<IncrementProductQuantityEvent>(_onIncrementQuantity);
    on<DecrementProductQuantityEvent>(_onDecrementQuantity);
    on<RemoveProductEvent>(_onRemoveProduct);
  }

  Future<void> _onLoadCartDetails(
    LoadCartDetailsEvent event,
    Emitter<CartDetailsState> emit,
  ) async {
    emit(state.copyWith(status: CartDetailsStatus.loading));

    final result = await getCartByIdUseCase(event.cartId);

    result.fold(
      (failure) => emit(
        state.copyWith(
          status: CartDetailsStatus.failure,
          errorMessage: failure.message,
        ),
      ),
      (cart) =>
          emit(state.copyWith(status: CartDetailsStatus.success, cart: cart)),
    );
  }

  Future<void> _onIncrementQuantity(
    IncrementProductQuantityEvent event,
    Emitter<CartDetailsState> emit,
  ) async {
    await _changeQuantity(productId: event.productId, delta: 1, emit: emit);
  }

  Future<void> _onDecrementQuantity(
    DecrementProductQuantityEvent event,
    Emitter<CartDetailsState> emit,
  ) async {
    await _changeQuantity(productId: event.productId, delta: -1, emit: emit);
  }

  Future<void> _changeQuantity({
    required int productId,
    required int delta,
    required Emitter<CartDetailsState> emit,
  }) async {
    final cart = state.cart;
    if (cart == null) return;

    final CartProductEntity? product = cart.products
        .where((p) => p.productId == productId)
        .firstOrNull();
    if (product == null) return;

    final newQuantity = product.quantity + delta;

    emit(state.copyWith(updatingProductId: productId));

    final result = await updateProductQuantityUseCase(
      cartId: cart.id,
      productId: productId,
      newQuantity: newQuantity,
    );

    result.fold(
      (failure) => emit(
        state.copyWith(
          status: CartDetailsStatus.failure,
          errorMessage: failure.message,
          clearUpdatingProductId: true,
        ),
      ),
      (updatedCart) => emit(
        state.copyWith(
          status: CartDetailsStatus.success,
          cart: updatedCart,
          clearUpdatingProductId: true,
        ),
      ),
    );
  }

  Future<void> _onRemoveProduct(
    RemoveProductEvent event,
    Emitter<CartDetailsState> emit,
  ) async {
    final cart = state.cart;
    if (cart == null) return;

    emit(state.copyWith(updatingProductId: event.productId));

    final result = await removeProductFromCartUseCase(
      cartId: cart.id,
      productId: event.productId,
    );

    result.fold(
      (failure) => emit(
        state.copyWith(
          status: CartDetailsStatus.failure,
          errorMessage: failure.message,
          clearUpdatingProductId: true,
        ),
      ),
      (updatedCart) => emit(
        state.copyWith(
          status: CartDetailsStatus.success,
          cart: updatedCart,
          clearUpdatingProductId: true,
        ),
      ),
    );
  }
}

extension _FirstOrNullExtension<T> on Iterable<T> {
  T? firstOrNull() {
    final iterator = this.iterator;
    if (iterator.moveNext()) return iterator.current;
    return null;
  }
}
