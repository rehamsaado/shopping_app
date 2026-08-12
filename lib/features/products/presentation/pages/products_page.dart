// lib/features/products/presentation/pages/products_page.dart

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/di/injection_container.dart';
import '../../../../core/localization/app_strings.dart';
import '../../../../core/router/app_router.dart';
import '../../../../core/widgets/app_drawer.dart'; // استدعاء الـ Drawer الجديد
import '../../../carts/presentation/bloc/carts_list/carts_list_bloc.dart';
import '../../../carts/presentation/bloc/carts_list/carts_list_event.dart';
import '../../../carts/presentation/widgets/add_custom_bottom_sheet.dart';
import '../blocs/products_bloc.dart';
import '../blocs/products_event.dart';
import '../blocs/products_state.dart';
import '../widgets/categories_chips_widget.dart';
import '../widgets/product_card_widget.dart';
import '../widgets/product_search_bar.dart';
import '../widgets/product_shimmer_loading.dart';
import '../widgets/products_carousel_widget.dart';

class ProductsPage extends StatefulWidget {
  const ProductsPage({super.key});

  @override
  State<ProductsPage> createState() => _ProductsPageState();
}

class _ProductsPageState extends State<ProductsPage> {
  String _selectedCategory = '';
  String _searchQuery = '';
  List<String> _categories = [];

  @override
  void initState() {
    super.initState();
    context.read<ProductsBloc>().add(GetProductsEvent());
    context.read<ProductsBloc>().add(GetCategoriesEvent());
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: Text(context.tr('discover_products')),
        actions: [
          IconButton(
            icon: const Icon(Icons.shopping_cart_outlined),
            onPressed: () {
              context.push(AppRoutes.cart);
            },
          ),
        ],
      ),
      drawer: const AppDrawer(), // ربط الـ Drawer هنا بنجاح
      body: BlocListener<ProductsBloc, ProductsState>(
        listener: (context, state) {
          if (state is CategoriesLoaded) {
            setState(() {
              _categories = state.categories;
            });
          }
        },
        child: RefreshIndicator(
          color: colorScheme.primary,
          onRefresh: () async {
            context.read<ProductsBloc>().add(GetProductsEvent());
            context.read<ProductsBloc>().add(GetCategoriesEvent());
          },
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 8),
                ProductSearchBar(
                  onChanged: (query) {
                    setState(() {
                      _searchQuery = query.toLowerCase();
                    });
                  },
                ),
                const SizedBox(height: 16),
                BlocBuilder<ProductsBloc, ProductsState>(
                  builder: (context, state) {
                    if (state is ProductsLoaded &&
                        _searchQuery.isEmpty &&
                        _selectedCategory.isEmpty) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16.0,
                            ),
                            child: Text(
                              context.tr('featured_offers'),
                              style: Theme.of(context).textTheme.titleMedium,
                            ),
                          ),
                          const SizedBox(height: 12),
                          ProductsCarouselWidget(
                            products: state.products,
                            onTap: (product) {
                              context.go(
                                '${AppRoutes.products}/details',
                                extra: product.id,
                              );
                            },
                          ),
                          const SizedBox(height: 24),
                        ],
                      );
                    }
                    return const SizedBox.shrink();
                  },
                ),
                CategoriesChipsWidget(
                  categories: _categories.isNotEmpty
                      ? _categories
                      : [
                    'electronics',
                    'jewelery',
                    "men's clothing",
                    "women's clothing",
                  ],
                  selectedCategory: _selectedCategory,
                  onCategorySelected: (category) {
                    setState(() {
                      _selectedCategory = category;
                    });
                    if (category.isEmpty) {
                      context.read<ProductsBloc>().add(GetProductsEvent());
                    } else {
                      context.read<ProductsBloc>().add(
                        GetProductsByCategoryEvent(category),
                      );
                    }
                  },
                ),
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        _selectedCategory.isEmpty
                            ? context.tr('all_products')
                            : _selectedCategory.toUpperCase(),
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 12),
                BlocBuilder<ProductsBloc, ProductsState>(
                  builder: (context, state) {
                    if (state is ProductsLoading) {
                      return const ProductShimmerLoading();
                    } else if (state is ProductsLoaded) {
                      final filteredProducts = state.products.where((product) {
                        return product.title.toLowerCase().contains(
                          _searchQuery,
                        );
                      }).toList();

                      if (filteredProducts.isEmpty) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 60.0),
                          child: Center(
                            child: Column(
                              children: [
                                Icon(
                                  Icons.search_off_rounded,
                                  size: 64,
                                  color: colorScheme.onSurfaceVariant,
                                ),
                                const SizedBox(height: 16),
                                Text(
                                  context.tr('no_products_found'),
                                  style: Theme.of(
                                    context,
                                  ).textTheme.titleMedium,
                                ),
                              ],
                            ),
                          ),
                        );
                      }

                      return GridView.builder(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          childAspectRatio: 0.68,
                          crossAxisSpacing: 16,
                          mainAxisSpacing: 16,
                        ),
                        itemCount: filteredProducts.length,
                        itemBuilder: (context, index) {
                          final product = filteredProducts[index];
                          return ProductCardWidget(
                            product: product,
                            onTap: () {
                              context.go(
                                '${AppRoutes.products}/details',
                                extra: product.id,
                              );
                            },
                            onAddToCart: () {
                              showModalBottomSheet(
                                context: context,
                                isScrollControlled: true,
                                builder: (modalContext) => BlocProvider(
                                  create: (context) => sl<CartsListBloc>()..add(const LoadCartsListEvent()),
                                  child: AddCustomCartBottomSheet(productId: product.id,          // رقم المنتج الحقيقي من الـ API
                                    productPrice: product.price,    // السعر الحقيقي
                                    productName: product.title,),
                                ),
                              );
                            },
                          );
                        },
                      );
                    } else if (state is ProductsError) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: 60.0,
                          horizontal: 24,
                        ),
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(
                                Icons.error_outline_rounded,
                                size: 48,
                                color: Colors.red,
                              ),
                              const SizedBox(height: 16),
                              Text(state.message, textAlign: TextAlign.center),
                              const SizedBox(height: 16),
                              ElevatedButton(
                                onPressed: () {
                                  context.read<ProductsBloc>().add(
                                    GetProductsEvent(),
                                  );
                                },
                                child: Text(context.tr('retry')),
                              ),
                            ],
                          ),
                        ),
                      );
                    }
                    return const ProductShimmerLoading();
                  },
                ),
                const SizedBox(height: 30),
              ],
            ),
          ),
        ),
      ),
    );
  }
}