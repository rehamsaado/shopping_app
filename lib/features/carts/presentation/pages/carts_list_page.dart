import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:shopping_app/core/constants/user_session.dart';
import 'package:shopping_app/core/localization/app_strings.dart';

import '../bloc/carts_list/carts_list_bloc.dart';
import '../bloc/carts_list/carts_list_event.dart';
import '../bloc/carts_list/carts_list_state.dart';
import '../widgets/cart_widget.dart';
import '../widgets/empty_state_widget.dart';
import 'cart_details_page.dart';

class CartsListPage extends StatelessWidget {
  final String? userId;
  final UserSession userSession;

  const CartsListPage({
    super.key,
    this.userId,
    required this.userSession,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final effectiveUserId = (userId != null && userId!.isNotEmpty)
        ? userId!
        : (userSession.getUserId() ?? '');

    return Scaffold(
      appBar: AppBar(
        title: Text(context.tr('saved_carts_title')),
        centerTitle: true,
      ),
      body: BlocBuilder<CartsListBloc, CartsListState>(
        builder: (context, state) {
          switch (state.status) {
            case CartsListStatus.initial:
            case CartsListStatus.loading:
              return Center(
                child: CircularProgressIndicator(
                  color: theme.colorScheme.primary,
                ),
              );

            case CartsListStatus.failure:
              return EmptyStateWidget(
                icon: Icons.error_outline_rounded,
                title: context.tr('error_loading_carts'),
                subtitle: state.errorMessage,
              );

            case CartsListStatus.success:
              if (state.isEmpty) {
                return EmptyStateWidget(
                  icon: Icons.shopping_bag_outlined,
                  title: context.tr('no_saved_carts_yet'),
                  subtitle: context.tr('create_cart_hint'),
                );
              }
              return RefreshIndicator(
                color: theme.colorScheme.primary,
                onRefresh: () async {
                  context.read<CartsListBloc>().add(
                    LoadCartsListEvent(userId: int.tryParse(effectiveUserId)),
                  );
                },
                child: ListView.builder(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  itemCount: state.carts.length,
                  itemBuilder: (context, index) {
                    final cart = state.carts[index];
                    return CartWidget(
                      onDelete: () {
                        context.read<CartsListBloc>().add(
                          DeleteCartEvent(cart.id),
                        );
                      },
                      cart: cart,
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (_) => CartDetailsPage(cartId: cart.id),
                          ),
                        );
                      },
                    ).animate().fadeIn(
                      duration: 300.ms,
                      delay: (index * 50).ms,
                    ).slideY(
                      begin: 0.1,
                      end: 0,
                      delay: (index * 50).ms,
                    );
                  },
                ),
              );
          }
        },
      ),
    );
  }
}