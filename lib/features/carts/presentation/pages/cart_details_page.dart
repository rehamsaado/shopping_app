import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/di/injection_container.dart';
import '../bloc/cart_details/cart_details_bloc.dart';
import '../bloc/cart_details/cart_details_event.dart';
import '../widgets/cart_details_view_widget.dart';

class CartDetailsPage extends StatelessWidget {
  final int cartId;

  const CartDetailsPage({super.key, required this.cartId});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<CartDetailsBloc>(
      create: (_) => sl<CartDetailsBloc>()..add(LoadCartDetailsEvent(cartId)),
      child: CartDetailsViewWidget(cartId: cartId),
    );
  }
}
