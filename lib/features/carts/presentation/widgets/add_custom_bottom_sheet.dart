import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping_app/core/localization/app_strings.dart';
import '../../domain/entities/cart_entity.dart';
import '../../domain/entities/cart_product_entity.dart';
import '../bloc/carts_list/carts_list_bloc.dart';
import '../bloc/carts_list/carts_list_event.dart';
import '../bloc/carts_list/carts_list_state.dart';

class AddCustomCartBottomSheet extends StatefulWidget {
  final int productId;
  final double productPrice;
  final String productName;

  const AddCustomCartBottomSheet({
    super.key,
    required this.productId,
    required this.productPrice,
    required this.productName,
  });

  @override
  State<AddCustomCartBottomSheet> createState() =>
      _AddCustomCartBottomSheetState();
}

class _AddCustomCartBottomSheetState extends State<AddCustomCartBottomSheet> {
  final _cartNameController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  int _selectedModeIndex = 0;

  bool get _isNewCart => _selectedModeIndex == 0;

  int? _selectedCartId;
  int _quantity = 1;

  @override
  void dispose() {
    _cartNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final bottomInset = MediaQuery.of(context).viewInsets.bottom;

    return BlocBuilder<CartsListBloc, CartsListState>(
      builder: (context, cartsState) {
        // تصفية السلات لمنع أي تكرار محتمل في الـ IDs يسبب انهيار الـ Dropdown
        final Map<int, CartEntity> uniqueCartsMap = {};
        for (var cart in cartsState.carts) {
          uniqueCartsMap[cart.id] = cart;
        }
        final existingCarts = uniqueCartsMap.values.toList();

        if (_selectedCartId != null &&
            !existingCarts.any((c) => c.id == _selectedCartId)) {
          _selectedCartId = null;
        }

        return Container(
          decoration: BoxDecoration(
            color: theme.colorScheme.surface,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(28)),
          ),
          child: Padding(
            padding: EdgeInsets.fromLTRB(20, 16, 20, bottomInset + 20),
            child: Form(
              key: _formKey,
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Container(
                        width: 40,
                        height: 4,
                        margin: const EdgeInsets.only(bottom: 16),
                        decoration: BoxDecoration(
                          color: theme.colorScheme.outlineVariant,
                          borderRadius: BorderRadius.circular(2),
                        ),
                      ),
                    ),
                    Text(
                      '${context.tr('add_prefix')} ${widget.productName}',
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: theme.colorScheme.primary,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '${context.tr('price_prefix')} \$${widget.productPrice}',
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: theme.colorScheme.onSurfaceVariant,
                      ),
                    ),
                    const SizedBox(height: 20),
                    SizedBox(
                      width: double.infinity,
                      child: SegmentedButton<int>(
                        segments: [
                          ButtonSegment<int>(
                            value: 0,
                            label: Text(context.tr('new_cart_mode')),
                            icon: const Icon(Icons.add_shopping_cart_rounded),
                          ),
                          ButtonSegment<int>(
                            value: 1,
                            label: Text(context.tr('existing_cart_mode')),
                            icon: const Icon(Icons.shopping_bag_outlined),
                          ),
                        ],
                        selected: {_selectedModeIndex},
                        onSelectionChanged: (Set<int> newSelection) {
                          setState(() {
                            _selectedModeIndex = newSelection.first;
                          });
                        },
                      ),
                    ),
                    const SizedBox(height: 20),
                    if (_isNewCart) ...[
                      TextFormField(
                        controller: _cartNameController,
                        autofocus: true,
                        decoration: InputDecoration(
                          labelText: context.tr('new_cart_name_label'),
                          hintText: context.tr('new_cart_name_hint'),
                          prefixIcon: const Icon(Icons.edit_outlined),
                        ),
                        validator: (value) {
                          if (_isNewCart &&
                              (value == null || value.trim().isEmpty)) {
                            return context.tr('enter_cart_name_error');
                          }
                          return null;
                        },
                      ),
                    ] else ...[
                      DropdownButtonFormField<int>(
                        // ضمان أن القيمة المختارة موجودة فعلياً في القائمة الفريدة لتجنب الـ AssertionError
                        value: existingCarts.any((c) => c.id == _selectedCartId)
                            ? _selectedCartId
                            : null,
                        decoration: InputDecoration(
                          labelText: context.tr('select_cart_label'),
                          prefixIcon: const Icon(
                            Icons.shopping_cart_checkout_rounded,
                          ),
                        ),
                        hint: Text(context.tr('select_saved_cart_hint')),
                        items: existingCarts.map((cart) {
                          final displayName =
                              (cart.name != null &&
                                  cart.name!.trim().isNotEmpty)
                              ? cart.name!
                              : '${context.tr('shopping_cart_number')} #${cart.id}';
                          return DropdownMenuItem<int>(
                            value: cart.id,
                            child: Text(displayName),
                          );
                        }).toList(),
                        validator: (value) {
                          if (!_isNewCart && value == null) {
                            return context.tr('select_available_cart_error');
                          }
                          return null;
                        },
                        onChanged: (value) {
                          setState(() {
                            _selectedCartId = value;
                          });
                        },
                      ),
                    ],
                    const SizedBox(height: 20),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 12,
                      ),
                      decoration: BoxDecoration(
                        color: theme.colorScheme.surfaceContainerHigh,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(
                          color: theme.colorScheme.outlineVariant.withValues(
                            alpha: 0.4,
                          ),
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            context.tr('quantity_to_add_label'),
                            style: theme.textTheme.bodyMedium?.copyWith(
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(24),
                              border: Border.all(
                                color: theme.colorScheme.outlineVariant
                                    .withValues(alpha: 0.6),
                              ),
                              color: theme.colorScheme.surfaceContainerHighest
                                  .withValues(alpha: 0.3),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                IconButton(
                                  visualDensity: VisualDensity.compact,
                                  icon: const Icon(
                                    Icons.remove_rounded,
                                    size: 18,
                                  ),
                                  onPressed: _quantity > 1
                                      ? () => setState(() => _quantity--)
                                      : null,
                                ),
                                SizedBox(
                                  width: 28,
                                  child: Text(
                                    '$_quantity',
                                    textAlign: TextAlign.center,
                                    style: theme.textTheme.titleSmall?.copyWith(
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ),
                                IconButton(
                                  visualDensity: VisualDensity.compact,
                                  icon: const Icon(Icons.add_rounded, size: 18),
                                  onPressed: () => setState(() => _quantity++),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 28),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton.icon(
                        icon: Icon(
                          _isNewCart
                              ? Icons.add_rounded
                              : Icons.add_shopping_cart_rounded,
                        ),
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            if (_isNewCart) {
                              final newCartId =
                                  DateTime.now().millisecondsSinceEpoch ~/ 1000;
                              final customName = _cartNameController.text
                                  .trim();

                              final newCart = CartEntity(
                                id: newCartId,
                                userId: 1,
                                date: DateTime.now(),
                                products: [
                                  CartProductEntity(
                                    productId: widget.productId,
                                    quantity: _quantity,
                                    price: widget.productPrice,
                                  ),
                                ],
                                name: customName,
                              );

                              context.read<CartsListBloc>().add(
                                CreateCartEvent(newCart),
                              );
                            } else {
                              final targetCart = existingCarts.firstWhere(
                                (c) => c.id == _selectedCartId,
                              );

                              final List<CartProductEntity> updatedProducts =
                                  targetCart.products
                                      .map(
                                        (p) => CartProductEntity(
                                          productId: p.productId,
                                          quantity: p.quantity,
                                          price: p.price,
                                        ),
                                      )
                                      .toList();

                              final existingIndex = updatedProducts.indexWhere(
                                (p) => p.productId == widget.productId,
                              );

                              if (existingIndex >= 0) {
                                final existing = updatedProducts[existingIndex];
                                updatedProducts[existingIndex] =
                                    CartProductEntity(
                                      productId: existing.productId,
                                      quantity: existing.quantity + _quantity,
                                      price: existing.price,
                                    );
                              } else {
                                updatedProducts.add(
                                  CartProductEntity(
                                    productId: widget.productId,
                                    quantity: _quantity,
                                    price: widget.productPrice,
                                  ),
                                );
                              }

                              final updatedCart = targetCart.copyWith(
                                date: DateTime.now(),
                                products: updatedProducts,
                              );

                              context.read<CartsListBloc>().add(
                                CreateCartEvent(updatedCart),
                              );
                            }

                            Navigator.of(context).pop();
                          }
                        },
                        label: Text(
                          _isNewCart
                              ? context.tr('confirm_and_create_cart')
                              : context.tr('add_to_selected_cart'),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
