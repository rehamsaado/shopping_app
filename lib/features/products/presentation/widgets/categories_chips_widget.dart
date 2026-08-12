import 'package:flutter/material.dart';
import '../../../../core/localization/app_strings.dart';

class CategoriesChipsWidget extends StatelessWidget {
  final List<String> categories;
  final String selectedCategory;
  final Function(String) onCategorySelected;

  const CategoriesChipsWidget({
    super.key,
    required this.categories,
    required this.selectedCategory,
    required this.onCategorySelected,
  });

  String _getCategoryTranslation(BuildContext context, String category) {
    switch (category.toLowerCase()) {
      case 'all':
        return context.tr('all');
      case 'electronics':
        return context.tr('electronics');
      case 'jewelery':
        return context.tr('jewelery');
      case "men's clothing":
        return context.tr('mens_clothing');
      case "women's clothing":
        return context.tr('womens_clothing');
      default:
        return category;
    }
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    final allCategories = ['all', ...categories];

    return SizedBox(
      height: 48,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: allCategories.length,
        separatorBuilder: (context, index) => const SizedBox(width: 8),
        itemBuilder: (context, index) {
          final category = allCategories[index];
          final isSelected = selectedCategory == category || (index == 0 && selectedCategory.isEmpty);
          final translatedLabel = _getCategoryTranslation(context, category);

          return ChoiceChip(
            label: Text(translatedLabel.toUpperCase()),
            selected: isSelected,
            onSelected: (selected) {
              onCategorySelected(index == 0 ? '' : category);
            },
            selectedColor: colorScheme.primary,
            backgroundColor: colorScheme.surfaceContainerHighest,
            labelStyle: TextStyle(
              color: isSelected ? colorScheme.onPrimary : colorScheme.onSurface,
              fontWeight: FontWeight.w600,
              fontSize: 12,
            ),
          );
        },
      ),
    );
  }
}