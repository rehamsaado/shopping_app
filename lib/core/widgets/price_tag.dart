import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../theme/app_theme.dart';

class PriceTag extends StatelessWidget {
  final double amount;
  final bool prominent;
  final bool animateEntrance;

  const PriceTag({
    super.key,
    required this.amount,
    this.prominent = false,
    this.animateEntrance = false,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    Widget tag = Container(
      padding: EdgeInsets.symmetric(
        horizontal: prominent ? 12 : 10,
        vertical: prominent ? 6 : 5,
      ),
      decoration: BoxDecoration(
        color: prominent
            ? colorScheme.primary
            : colorScheme.primaryContainer.withValues(alpha: 0.6),
        borderRadius: BorderRadius.circular(999),
        border: Border.all(
          color: prominent
              ? colorScheme.primary.withValues(alpha: 0.8)
              : colorScheme.primary.withValues(alpha: 0.25),
          width: 1,
        ),
        boxShadow: prominent
            ? [
          BoxShadow(
            color: colorScheme.primary.withValues(alpha: 0.35),
            blurRadius: 12,
            spreadRadius: 1,
            offset: const Offset(0, 4),
          ),
        ]
            : null,
      ),
      child: Text(
        '${amount.toStringAsFixed(2)} ₪',
        style: AppTheme.priceStyle(
          color: prominent
              ? colorScheme.onPrimary
              : colorScheme.onPrimaryContainer,
          fontSize: prominent ? 14 : 12.5,
          fontWeight: prominent ? FontWeight.w800 : FontWeight.w700,
        ),
      ),
    );

    if (animateEntrance) {
      tag = tag
          .animate()
          .scale(
        duration: 400.ms,
        curve: Curves.easeOutBack,
        begin: const Offset(0.4, 0.4),
        end: const Offset(1, 1),
      )
          .fadeIn(
        duration: 250.ms,
        curve: Curves.easeOut,
      );
    }

    return tag;
  }
}