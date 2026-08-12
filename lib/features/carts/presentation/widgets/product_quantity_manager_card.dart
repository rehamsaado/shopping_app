import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:shopping_app/core/localization/app_strings.dart';
import '../../domain/entities/cart_product_entity.dart';
import 'product_quantity_controls_widget.dart';

class ProductQuantityManagerCard extends StatelessWidget {
  final CartProductEntity product;
  final bool isUpdating;
  final VoidCallback onIncrement;
  final VoidCallback onDecrement;
  final VoidCallback onRemove;

  const ProductQuantityManagerCard({
    super.key,
    required this.product,
    required this.isUpdating,
    required this.onIncrement,
    required this.onDecrement,
    required this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
        side: BorderSide(
          color: theme.colorScheme.outlineVariant.withValues(alpha: 0.4),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: theme.colorScheme.surfaceContainerHighest,
                borderRadius: BorderRadius.circular(16),
              ),
              alignment: Alignment.center,
              child: Text(
                '#${product.productId}',
                style: theme.textTheme.labelMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: theme.colorScheme.onSurfaceVariant,
                ),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Text(
                '${context.tr('product_number_label')} ${product.productId}',
                style: theme.textTheme.titleSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
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
              ProductQuantityControlsWidget(
                quantity: product.quantity,
                onIncrement: onIncrement,
                onDecrement: onDecrement,
              ),
            const SizedBox(width: 8),
            IconButton(
              tooltip: context.tr('remove_product'),
              onPressed: isUpdating ? null : onRemove,
              icon: Icon(Icons.delete_outline_rounded, color: theme.colorScheme.error),
            ),
          ],
        ),
      ),
    ).animate().fadeIn(duration: 300.ms).slideY(begin: 0.05, end: 0);
  }
}