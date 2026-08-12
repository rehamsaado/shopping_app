import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../localization/locale_cubit.dart';
import '../theme/theme_cubit.dart';

class SettingsActions extends StatelessWidget {
  const SettingsActions({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final themeMode = context.watch<ThemeCubit>().state;
    final locale = context.watch<LocaleCubit>().state;

    final isDark = themeMode == ThemeMode.dark;
    final isArabic = locale.languageCode == 'ar';

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Tooltip(
          message: 'تبديل اللغة / Toggle language',
          child: InkWell(
            borderRadius: BorderRadius.circular(12),
            onTap: () => context.read<LocaleCubit>().toggle(),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
              decoration: BoxDecoration(
                color: colorScheme.surfaceContainerHigh,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: colorScheme.outlineVariant.withValues(alpha: 0.3),
                  width: 1,
                ),
              ),
              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 250),
                transitionBuilder: (child, animation) {
                  return ScaleTransition(scale: animation, child: child);
                },
                child: Text(
                  isArabic ? 'EN' : 'AR',
                  key: ValueKey(isArabic),
                  style: TextStyle(
                    color: colorScheme.primary,
                    fontWeight: FontWeight.w800,
                    fontSize: 13,
                    letterSpacing: 0.5,
                  ),
                ),
              ),
            ),
          ),
        ),
        const SizedBox(width: 8),
        Tooltip(
          message: 'تبديل الوضع الليلي / Toggle dark mode',
          child: InkWell(
            borderRadius: BorderRadius.circular(12),
            onTap: () => context.read<ThemeCubit>().toggle(),
            child: Container(
              padding: const EdgeInsets.all(7),
              decoration: BoxDecoration(
                color: colorScheme.surfaceContainerHigh,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: colorScheme.outlineVariant.withValues(alpha: 0.3),
                  width: 1,
                ),
              ),
              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 300),
                transitionBuilder: (child, animation) {
                  return RotationTransition(
                    turns: animation,
                    child: ScaleTransition(scale: animation, child: child),
                  );
                },
                child: Icon(
                  isDark ? Icons.light_mode_rounded : Icons.dark_mode_rounded,
                  key: ValueKey(isDark),
                  color: colorScheme.primary,
                  size: 20,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}