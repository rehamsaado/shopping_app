// import 'package:flutter_bloc/flutter_bloc.dart';
//
// import '../../../domain/usecases/create_cart_usecase.dart';
// import '../../../domain/usecases/delete_cart_usecase.dart';
// import '../../../domain/usecases/get_all_carts_usecase.dart';
// import 'carts_list_event.dart';
// import 'carts_list_state.dart';
//
// class CartsListBloc extends Bloc<CartsListEvent, CartsListState> {
//   final GetAllCartsUseCase getAllCartsUseCase;
//   final CreateCartUseCase createCartUseCase;
//   final DeleteCartUseCase deleteCart;
//
//   CartsListBloc({
//     required this.getAllCartsUseCase,
//     required this.createCartUseCase,
//     required this.deleteCart,
//   }) : super(const CartsListState()) {
//     on<LoadCartsListEvent>(_onLoadCartsList);
//     on<CreateCartEvent>(_onCreateCart);
//     on<DeleteCartEvent>(_onDeleteCart);
//   }
//
//   Future<void> _onLoadCartsList(
//     LoadCartsListEvent event,
//     Emitter<CartsListState> emit,
//   ) async {
//     emit(state.copyWith(status: CartsListStatus.loading));
//
//     final result = await getAllCartsUseCase();
//
//     result.fold(
//       (failure) => emit(
//         state.copyWith(
//           status: CartsListStatus.failure,
//           errorMessage: failure.message,
//         ),
//       ),
//       (carts) =>
//           emit(state.copyWith(status: CartsListStatus.success, carts: carts)),
//     );
//   }
//
//   Future<void> _onDeleteCart(
//     DeleteCartEvent event,
//     Emitter<CartsListState> emit,
//   ) async {
//     final result = await deleteCart(event.cartId);
//
//     result.fold(
//       (failure) => emit(
//         state.copyWith(
//           status: CartsListStatus.failure,
//           errorMessage: failure.message,
//         ),
//       ),
//       (_) {
//         final updatedCarts = state.carts
//             .where((cart) => cart.id != event.cartId)
//             .toList();
//
//         emit(
//           state.copyWith(status: CartsListStatus.success, carts: updatedCarts),
//         );
//       },
//     );
//   }
//
//   Future<void> _onCreateCart(
//     CreateCartEvent event,
//     Emitter<CartsListState> emit,
//   ) async {
//     final result = await createCartUseCase(event.cart);
//
//     result.fold(
//       (failure) => emit(state.copyWith(errorMessage: failure.message)),
//       (newCart) => emit(
//         state.copyWith(
//           status: CartsListStatus.success,
//           carts: [newCart, ...state.carts],
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/usecases/create_cart_usecase.dart';
import '../../../domain/usecases/delete_cart_usecase.dart';
import '../../../domain/usecases/get_all_carts_usecase.dart';
import 'carts_list_event.dart';
import 'carts_list_state.dart';

class CartsListBloc extends Bloc<CartsListEvent, CartsListState> {
  final GetAllCartsUseCase getAllCartsUseCase;
  final CreateCartUseCase createCartUseCase;
  final DeleteCartUseCase deleteCart;

  CartsListBloc({
    required this.getAllCartsUseCase,
    required this.createCartUseCase,
    required this.deleteCart,
  }) : super(const CartsListState()) {
    on<LoadCartsListEvent>(_onLoadCartsList);
    on<CreateCartEvent>(_onCreateCart);
    on<DeleteCartEvent>(_onDeleteCart);
  }

  Future<void> _onLoadCartsList(
    LoadCartsListEvent event,
    Emitter<CartsListState> emit,
  ) async {
    emit(state.copyWith(status: CartsListStatus.loading));

    final result = await getAllCartsUseCase();

    result.fold(
      (failure) => emit(
        state.copyWith(
          status: CartsListStatus.failure,
          errorMessage: failure.message,
        ),
      ),
      (carts) {
       final userId = event.userId ?? 1;
        final filteredCarts = carts
            .where((cart) => cart.userId == userId)
            .toList();

        emit(
          state.copyWith(status: CartsListStatus.success, carts: filteredCarts),
        );
      },
    );
  }

  Future<void> _onDeleteCart(
    DeleteCartEvent event,
    Emitter<CartsListState> emit,
  ) async {
    final result = await deleteCart(event.cartId);

    result.fold(
      (failure) => emit(
        state.copyWith(
          status: CartsListStatus.failure,
          errorMessage: failure.message,
        ),
      ),
      (_) {
        final updatedCarts = state.carts
            .where((cart) => cart.id != event.cartId)
            .toList();

        emit(
          state.copyWith(status: CartsListStatus.success, carts: updatedCarts),
        );
      },
    );
  }

  Future<void> _onCreateCart(
    CreateCartEvent event,
    Emitter<CartsListState> emit,
  ) async {
    final result = await createCartUseCase(event.cart);

    result.fold(
      (failure) => emit(state.copyWith(errorMessage: failure.message)),
      (newCart) => emit(
        state.copyWith(
          status: CartsListStatus.success,
          carts: [newCart, ...state.carts],
        ),
      ),
    );
  }
}
