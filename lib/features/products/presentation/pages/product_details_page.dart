import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../../../core/di/injection_container.dart';
import '../../../../core/localization/app_strings.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../carts/presentation/bloc/carts_list/carts_list_bloc.dart';
import '../../../carts/presentation/bloc/carts_list/carts_list_event.dart';
import '../../../carts/presentation/widgets/add_custom_bottom_sheet.dart';
import '../blocs/products_bloc.dart';
import '../blocs/products_event.dart';
import '../blocs/products_state.dart';

class ProductDetailsPage extends StatelessWidget {
  final int productId;

  const ProductDetailsPage({super.key, required this.productId});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          sl<ProductsBloc>()..add(GetProductDetailsEvent(productId)),
      child: const ProductDetailsView(),
    );
  }
}

class ProductDetailsView extends StatelessWidget {
  const ProductDetailsView({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(title: Text(context.tr('product_details'))),
      body: BlocBuilder<ProductsBloc, ProductsState>(
        builder: (context, state) {
          if (state is ProductDetailsLoading) {
            return Center(
              child: CircularProgressIndicator(color: colorScheme.primary),
            );
          } else if (state is ProductDetailsLoaded) {
            final product = state.product;
            return Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: double.infinity,
                          height: 280,
                          padding: const EdgeInsets.all(20),
                          decoration: BoxDecoration(
                            color: colorScheme.surfaceContainerHigh,
                            borderRadius: BorderRadius.circular(24),
                          ),
                          child: CachedNetworkImage(
                            imageUrl: product.image,
                            fit: BoxFit.contain,
                          ),
                        ),
                        const SizedBox(height: 24),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 6,
                          ),
                          decoration: BoxDecoration(
                            color: colorScheme.primary.withValues(alpha: 0.1),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            product.category.toUpperCase(),
                            style: TextStyle(
                              color: colorScheme.primary,
                              fontWeight: FontWeight.bold,
                              fontSize: 12,
                            ),
                          ),
                        ),
                        const SizedBox(height: 12),
                        Text(
                          product.title,
                          style: Theme.of(
                            context,
                          ).textTheme.titleLarge?.copyWith(fontSize: 20),
                        ),
                        const SizedBox(height: 12),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              '\$${product.price.toStringAsFixed(2)}',
                              style: AppTheme.priceStyle(
                                color: colorScheme.primary,
                                fontSize: 24,
                              ),
                            ),
                            Row(
                              children: [
                                const Icon(
                                  Icons.star_rounded,
                                  color: AppColors.warning,
                                  size: 22,
                                ),
                                const SizedBox(width: 4),
                                Text(
                                  '${product.rating.rate} (${product.rating.count} ${context.tr('reviews')})',
                                  style: Theme.of(context).textTheme.bodyMedium
                                      ?.copyWith(fontWeight: FontWeight.w600),
                                ),
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
                        const Divider(),
                        const SizedBox(height: 16),
                        Text(
                          context.tr('description'),
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        const SizedBox(height: 8),
                        Text(
                          product.description,
                          style: Theme.of(context).textTheme.bodyMedium
                              ?.copyWith(
                                color: colorScheme.onSurfaceVariant,
                                height: 1.6,
                              ),
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: colorScheme.surfaceContainer,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.05),
                        blurRadius: 10,
                        offset: const Offset(0, -4),
                      ),
                    ],
                  ),
                  child: SafeArea(
                    child: SizedBox(
                      width: double.infinity,
                      child: ElevatedButton.icon(
                        onPressed: () {
                          showModalBottomSheet(
                            context: context,
                            isScrollControlled: true,
                            builder: (modalContext) => BlocProvider(
                              create: (context) =>
                                  sl<CartsListBloc>()
                                    ..add(const LoadCartsListEvent()),
                              child: AddCustomCartBottomSheet(
                                productId: product.id,
                                productPrice: product.price,
                                productName: product.title,
                              ),
                            ),
                          );
                        },
                        icon: const Icon(Icons.shopping_cart_outlined),
                        label: Text(context.tr('add_to_cart')),
                      ),
                    ),
                  ),
                ),
              ],
            );
          } else if (state is ProductsError) {
            return Center(child: Text(state.message));
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}
