import 'package:flutter/material.dart';
import 'package:shopping_app/core/localization/app_strings.dart';

class ProductSearchBar extends StatelessWidget {
  final Function(String) onChanged;
  final VoidCallback? onClear;

  const ProductSearchBar({
    super.key,
    required this.onChanged,
    this.onClear,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: TextField(
        onChanged: onChanged,
        decoration: InputDecoration(
          hintText: context.tr('Search products...'),
          prefixIcon: Icon(Icons.search_rounded, color: colorScheme.primary),
          suffixIcon: IconButton(
            icon: Icon(Icons.tune_rounded, color: colorScheme.onSurfaceVariant),
            onPressed: () {

            },
          ),
        ),
      ),
    );
  }
}