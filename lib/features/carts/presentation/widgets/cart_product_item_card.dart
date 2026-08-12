import 'package:flutter/material.dart';
import 'package:shopping_app/core/localization/app_strings.dart';
import '../../domain/entities/cart_product_entity.dart';

class CartProductItemCard extends StatelessWidget {
  final CartProductEntity product;
  final bool isUpdating;
  final VoidCallback onIncrement;
  final VoidCallback onDecrement;
  final VoidCallback onRemove;
  final VoidCallback onTap;

  const CartProductItemCard({
    super.key,
    required this.product,
    required this.isUpdating,
    required this.onIncrement,
    required this.onDecrement,
    required this.onRemove,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final double itemTotalPrice = product.price * product.quantity;

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
        side: BorderSide(
          color: theme.colorScheme.outlineVariant.withValues(alpha: 0.4),
        ),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(20),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Container(
                width: 52,
                height: 52,
                decoration: BoxDecoration(
                  color: theme.colorScheme.primaryContainer.withValues(alpha: 0.5),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Icon(
                  Icons.inventory_2_outlined,
                  color: theme.colorScheme.primary,
                  size: 24,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${context.tr('product_number_label')} ${product.productId}',
                      style: theme.textTheme.titleSmall?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '${context.tr('price')}: \$${product.price.toStringAsFixed(2)}',
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: theme.colorScheme.onSurfaceVariant,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      '${context.tr('total')}: \$${itemTotalPrice.toStringAsFixed(2)}',
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: theme.colorScheme.primary,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              if (isUpdating)
                SizedBox(
                  width: 24,
                  height: 24,
                  child: CircularProgressIndicator(
                    strokeWidth: 2.4,
                    color: theme.colorScheme.primary,
                  ),
                )
              else
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(24),
                    border: Border.all(
                      color: theme.colorScheme.outlineVariant.withValues(alpha: 0.6),
                    ),
                    color: theme.colorScheme.surfaceContainerHighest.withValues(alpha: 0.3),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.remove_rounded, size: 18),
                        color: theme.colorScheme.error,
                        onPressed: product.quantity > 1 ? onDecrement : onRemove,
                        tooltip: context.tr('reduce_quantity'),
                        constraints: const BoxConstraints(),
                        padding: const EdgeInsets.all(8),
                      ),
                      SizedBox(
                        width: 28,
                        child: Text(
                          '${product.quantity}',
                          textAlign: TextAlign.center,
                          style: theme.textTheme.titleSmall?.copyWith(
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.add_rounded, size: 18),
                        color: theme.colorScheme.primary,
                        onPressed: onIncrement,
                        tooltip: context.tr('increase_quantity'),
                        constraints: const BoxConstraints(),
                        padding: const EdgeInsets.all(8),
                      ),
                    ],
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}