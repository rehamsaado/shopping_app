import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:shopping_app/core/localization/app_strings.dart';
import '../../../products/presentation/pages/product_details_page.dart';
import '../bloc/cart_details/cart_details_bloc.dart';
import '../bloc/cart_details/cart_details_event.dart';
import '../bloc/cart_details/cart_details_state.dart';
import '../widgets/empty_state_widget.dart';
import 'cart_product_item_card.dart';
import 'cart_summary_bar_widget.dart';

class CartDetailsViewWidget extends StatelessWidget {
  final int cartId;

  const CartDetailsViewWidget({super.key, required this.cartId});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('${context.tr('cart_details_title')} #$cartId'),
        centerTitle: true,
      ),
      body: BlocBuilder<CartDetailsBloc, CartDetailsState>(
        builder: (context, state) {
          switch (state.status) {
            case CartDetailsStatus.initial:
            case CartDetailsStatus.loading:
              if (state.cart == null) {
                return Center(
                  child: CircularProgressIndicator(
                    color: theme.colorScheme.primary,
                  ),
                );
              }
              break;
            case CartDetailsStatus.failure:
              if (state.cart == null) {
                return EmptyStateWidget(
                  icon: Icons.error_outline_rounded,
                  title: context.tr('failed_to_load_cart_details'),
                  subtitle: state.errorMessage,
                );
              }
              break;
            case CartDetailsStatus.success:
              break;
          }

          final cart = state.cart;
          if (cart == null) {
            return EmptyStateWidget(
              icon: Icons.shopping_bag_outlined,
              title: context.tr('no_cart_data'),
            );
          }

          if (cart.products.isEmpty) {
            return EmptyStateWidget(
              icon: Icons.remove_shopping_cart_outlined,
              title: context.tr('cart_empty_title'),
              subtitle: context.tr('cart_empty_subtitle'),
            );
          }

          final double totalPrice = cart.products.fold(
            0.0,
                (sum, item) => sum + (item.price * item.quantity),
          );

          return Column(
            children: [
              if (state.errorMessage != null)
                Container(
                  width: double.infinity,
                  color: theme.colorScheme.errorContainer,
                  padding: const EdgeInsets.all(10),
                  child: Text(
                    state.errorMessage!,
                    style: TextStyle(
                      color: theme.colorScheme.onErrorContainer,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  itemCount: cart.products.length,
                  itemBuilder: (context, index) {
                    final product = cart.products[index];
                    final isUpdating =
                        state.updatingProductId == product.productId;

                    return CartProductItemCard(
                      product: product,
                      isUpdating: isUpdating,
                      onIncrement: () => context.read<CartDetailsBloc>().add(
                        IncrementProductQuantityEvent(product.productId),
                      ),
                      onDecrement: () => context.read<CartDetailsBloc>().add(
                        DecrementProductQuantityEvent(product.productId),
                      ),
                      onRemove: () => context.read<CartDetailsBloc>().add(
                        RemoveProductEvent(product.productId),
                      ),
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (_) => ProductDetailsPage(
                              productId: product.productId,
                            ),
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
              ),
              CartSummaryBarWidget(
                totalProducts: cart.totalProductsCount,
                totalQuantity: cart.totalQuantity,
                totalPrice: totalPrice,
                onConfirmOrder: () {
                  ScaffoldMessenger.of(context).hideCurrentSnackBar();
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Row(
                        children: [
                          Icon(
                            Icons.check_circle_rounded,
                            color: theme.colorScheme.onInverseSurface,
                          ),
                          const SizedBox(width: 12),
                          Text(
                            context.tr('order_confirmed_success'),
                            style: TextStyle(
                              color: theme.colorScheme.onInverseSurface,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      backgroundColor: theme.colorScheme.inverseSurface,
                      behavior: SnackBarBehavior.floating,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      margin: const EdgeInsets.all(16),
                      duration: const Duration(seconds: 3),
                    ),
                  );
                },
              ),
            ],
          );
        },
      ),
    );
  }
}