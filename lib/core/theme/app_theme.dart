import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'app_colors.dart';

class AppTheme {
  AppTheme._();

  static TextStyle priceStyle({
    required Color color,
    double fontSize = 14,
    FontWeight fontWeight = FontWeight.w700,
  }) {
    return GoogleFonts.jetBrainsMono(
      color: color,
      fontSize: fontSize,
      fontWeight: fontWeight,
      letterSpacing: 0.3,
    );
  }

  static ThemeData get light => _buildTheme(Brightness.light);
  static ThemeData get dark => _buildTheme(Brightness.dark);

  static ThemeData _buildTheme(Brightness brightness) {
    final isDark = brightness == Brightness.dark;

    final colorScheme = isDark
        ? const ColorScheme.dark(
      primary: AppColors.primary,
      onPrimary: AppColors.white,
      primaryContainer: Color(0xFF312E81),
      onPrimaryContainer: Color(0xFFE0E7FF),
      secondary: AppColors.secondary,
      onSecondary: AppColors.white,
      surface: AppColors.darkBackground,
      onSurface: AppColors.darkPrimaryText,
      surfaceContainer: AppColors.darkSurface,
      surfaceContainerHigh: AppColors.darkCardBackground,
      surfaceContainerHighest: AppColors.darkElevatedSurface,
      onSurfaceVariant: AppColors.darkSecondaryText,
      outline: AppColors.darkDivider,
      outlineVariant: Color(0xFF27272A),
      error: AppColors.error,
    )
        : const ColorScheme.light(
      primary: AppColors.primary,
      onPrimary: AppColors.white,
      primaryContainer: Color(0xFFEEF2FF),
      onPrimaryContainer: Color(0xFF312E81),
      secondary: AppColors.secondary,
      onSecondary: AppColors.white,
      surface: AppColors.lightBackground,
      onSurface: AppColors.lightPrimaryText,
      surfaceContainer: AppColors.lightSurface,
      surfaceContainerHigh: Color(0xFFF1F5F9),
      surfaceContainerHighest: AppColors.gray200,
      onSurfaceVariant: AppColors.lightSecondaryText,
      outline: AppColors.gray300,
      outlineVariant: AppColors.lightDivider,
      error: AppColors.error,
    );

    final baseTextTheme = GoogleFonts.manropeTextTheme().apply(
      bodyColor: colorScheme.onSurface,
      displayColor: colorScheme.onSurface,
    );

    final textTheme = baseTextTheme.copyWith(
      titleLarge: GoogleFonts.spaceGrotesk(
        fontSize: 24,
        fontWeight: FontWeight.w700,
        letterSpacing: -0.4,
        color: colorScheme.onSurface,
      ),
      titleMedium: GoogleFonts.spaceGrotesk(
        fontSize: 18,
        fontWeight: FontWeight.w600,
        letterSpacing: -0.2,
        color: colorScheme.onSurface,
      ),
      titleSmall: GoogleFonts.spaceGrotesk(
        fontSize: 15,
        fontWeight: FontWeight.w600,
        color: colorScheme.onSurface,
      ),
      bodyMedium: baseTextTheme.bodyMedium?.copyWith(
        color: colorScheme.onSurface,
        fontSize: 14,
        height: 1.5,
      ),
      bodySmall: baseTextTheme.bodySmall?.copyWith(
        color: colorScheme.onSurfaceVariant,
        fontSize: 12,
      ),
    );

    return ThemeData(
      useMaterial3: true,
      brightness: brightness,
      colorScheme: colorScheme,
      scaffoldBackgroundColor: colorScheme.surface,
      textTheme: textTheme,

      appBarTheme: AppBarTheme(
        backgroundColor: colorScheme.surface,
        foregroundColor: colorScheme.onSurface,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        scrolledUnderElevation: 0,
        centerTitle: true,
        titleTextStyle: GoogleFonts.spaceGrotesk(
          color: colorScheme.onSurface,
          fontSize: 20,
          fontWeight: FontWeight.w700,
          letterSpacing: -0.3,
        ),
      ),

      cardTheme: CardThemeData(
        color: colorScheme.surfaceContainerHigh,
        elevation: isDark ? 2 : 0,
        shadowColor: Colors.black.withValues(alpha: 0.3),
        margin: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
          side: BorderSide(
            color: colorScheme.outlineVariant.withValues(alpha: isDark ? 0.6 : 0.8),
            width: 1,
          ),
        ),
      ),

      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: colorScheme.primary,
          foregroundColor: colorScheme.onPrimary,
          disabledBackgroundColor: colorScheme.onSurface.withValues(alpha: 0.12),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          elevation: isDark ? 4 : 1,
          shadowColor: AppColors.primary.withValues(alpha: 0.35),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          textStyle: GoogleFonts.spaceGrotesk(fontWeight: FontWeight.w700, fontSize: 15),
        ),
      ),

      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: colorScheme.primary,
          side: BorderSide(color: colorScheme.primary.withValues(alpha: 0.6), width: 1.5),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          textStyle: GoogleFonts.spaceGrotesk(fontWeight: FontWeight.w600, fontSize: 14),
        ),
      ),

      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          backgroundColor: colorScheme.primaryContainer,
          foregroundColor: colorScheme.onPrimaryContainer,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          textStyle: GoogleFonts.spaceGrotesk(fontWeight: FontWeight.w700),
        ),
      ),

      chipTheme: ChipThemeData(
        backgroundColor: colorScheme.surfaceContainerHighest,
        selectedColor: colorScheme.primary,
        labelStyle: GoogleFonts.manrope(
          color: colorScheme.onSurface,
          fontSize: 13,
          fontWeight: FontWeight.w600,
        ),
        secondaryLabelStyle: GoogleFonts.manrope(
          color: colorScheme.onPrimary,
          fontSize: 13,
          fontWeight: FontWeight.w600,
        ),
        side: BorderSide(color: colorScheme.outlineVariant.withValues(alpha: 0.4)),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      ),

      switchTheme: SwitchThemeData(
        thumbColor: WidgetStateProperty.resolveWith((states) =>
        states.contains(WidgetState.selected) ? colorScheme.primary : colorScheme.onSurfaceVariant),
        trackColor: WidgetStateProperty.resolveWith((states) =>
        states.contains(WidgetState.selected)
            ? colorScheme.primaryContainer
            : colorScheme.surfaceContainerHighest),
        trackOutlineColor: WidgetStateProperty.all(Colors.transparent),
      ),

      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: colorScheme.surfaceContainerHigh,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(color: colorScheme.outlineVariant.withValues(alpha: 0.3)),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(color: colorScheme.outlineVariant.withValues(alpha: 0.3)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(color: colorScheme.primary, width: 1.5),
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        hintStyle: GoogleFonts.manrope(color: colorScheme.onSurfaceVariant.withValues(alpha: 0.7)),
      ),

      navigationBarTheme: NavigationBarThemeData(
        backgroundColor: colorScheme.surfaceContainer,
        indicatorColor: colorScheme.primary.withValues(alpha: 0.15),
        surfaceTintColor: Colors.transparent,
        elevation: 8,
        labelTextStyle: WidgetStateProperty.resolveWith((states) => GoogleFonts.manrope(
          fontSize: 12,
          fontWeight: states.contains(WidgetState.selected)
              ? FontWeight.w700
              : FontWeight.w500,
          color: states.contains(WidgetState.selected)
              ? colorScheme.primary
              : colorScheme.onSurfaceVariant,
        )),
        iconTheme: WidgetStateProperty.resolveWith((states) => IconThemeData(
          color: states.contains(WidgetState.selected)
              ? colorScheme.primary
              : colorScheme.onSurfaceVariant,
        )),
      ),

      snackBarTheme: SnackBarThemeData(
        backgroundColor: isDark ? colorScheme.surfaceContainerHighest : AppColors.gray800,
        contentTextStyle: GoogleFonts.manrope(color: Colors.white, fontWeight: FontWeight.w600),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
        behavior: SnackBarBehavior.floating,
        elevation: 6,
      ),

      dividerTheme: DividerThemeData(
        color: colorScheme.outlineVariant.withValues(alpha: 0.3),
        thickness: 1,
      ),
    );
  }
}