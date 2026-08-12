import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shopping_app/core/localization/app_strings.dart';
import 'package:shopping_app/core/widgets/settings_actions.dart';
import '../../../../core/router/app_router.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Drawer(
      backgroundColor: colorScheme.surface,
      child: SafeArea(
        child: Column(
          children: [
            // رأس الـ Drawer بتصميم تدرج لوني فخم وبارز جداً
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    colorScheme.primary,
                    colorScheme.primaryContainer,
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: colorScheme.onPrimary.withValues(alpha: 0.5),
                        width: 2.5,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.15),
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: CircleAvatar(
                      radius: 32,
                      backgroundColor: colorScheme.surface,
                      child: Icon(
                        Icons.person_rounded,
                        color: colorScheme.primary,
                        size: 36,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'John Doe',
                    style: theme.textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: colorScheme.onPrimary,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'john.doe@gmail.com',
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: colorScheme.onPrimary.withValues(alpha: 0.85),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 16),

            // القائمة بتصميم أنيق ومتباعد
            Expanded(
              child: ListView(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                children: [
                  _DrawerItem(
                    icon: Icons.person_outline_rounded,
                    title: context.tr('profile'),
                    onTap: () {
                      Navigator.pop(context);
                      context.push('${AppRoutes.profile}/1');
                    },
                  ),
                  const SizedBox(height: 8),
                  _DrawerItem(
                    icon: Icons.shopping_cart_outlined,
                    title: context.tr('cart'),
                    onTap: () {
                      Navigator.pop(context);
                      context.push(AppRoutes.cart);
                    },
                  ),
                ],
              ),
            ),


            Container(
              margin: const EdgeInsets.all(16),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: colorScheme.surfaceContainerHighest.withValues(alpha: 0.5),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: colorScheme.outline.withValues(alpha: 0.2),
                  width: 1,
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.settings_outlined,
                        color: colorScheme.primary,
                        size: 22,
                      ),
                      const SizedBox(width: 12),
                      Text(
                        context.tr('settings'),
                        style: theme.textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const SettingsActions(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _DrawerItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback onTap;

  const _DrawerItem({
    required this.icon,
    required this.title,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Material(
      color: colorScheme.surfaceContainerHighest.withValues(alpha: 0.3),
      borderRadius: BorderRadius.circular(16),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: colorScheme.primary.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(
                  icon,
                  color: colorScheme.primary,
                  size: 20,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Text(
                  title,
                  style: theme.textTheme.bodyLarge?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              Icon(
                Icons.arrow_forward_ios_rounded,
                size: 14,
                color: colorScheme.onSurfaceVariant,
              ),
            ],
          ),
        ),
      ),
    );
  }
}