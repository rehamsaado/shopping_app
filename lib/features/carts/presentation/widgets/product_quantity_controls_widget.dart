import 'package:flutter/material.dart';
import 'package:shopping_app/core/localization/app_strings.dart';

class ProductQuantityControlsWidget extends StatelessWidget {
  final int quantity;
  final VoidCallback onIncrement;
  final VoidCallback onDecrement;

  const ProductQuantityControlsWidget({
    super.key,
    required this.quantity,
    required this.onIncrement,
    required this.onDecrement,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
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
            visualDensity: VisualDensity.compact,
            icon: const Icon(Icons.remove_rounded, size: 18),
            onPressed: onDecrement,
            tooltip: quantity <= 1
                ? context.tr('remove_product')
                : context.tr('decrease_quantity'),
          ),
          SizedBox(
            width: 28,
            child: Text(
              '$quantity',
              textAlign: TextAlign.center,
              style: theme.textTheme.titleSmall?.copyWith(
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          IconButton(
            visualDensity: VisualDensity.compact,
            icon: const Icon(Icons.add_rounded, size: 18),
            onPressed: onIncrement,
            tooltip: context.tr('increase_quantity'),
          ),
        ],
      ),
    );
  }
}