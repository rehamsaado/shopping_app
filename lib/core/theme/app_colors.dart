import 'package:flutter/material.dart';

class AppColors {
  AppColors._();

  // ==================== PRIMARY COLORS ====================
  static const Color primary = Color(0xFF4F46E5);
  static const Color secondary = Color(0xFF7C3AED);
  static const Color accent = Color(0xFF059669);

  // ==================== GRADIENTS ====================
  static const Color primaryGradientStart = Color(0xFF4F46E5);
  static const Color primaryGradientEnd = Color(0xFF7C3AED);
  static const Color secondaryGradientStart = Color(0xFF059669);
  static const Color secondaryGradientEnd = Color(0xFF7C3AED);
  static const Color warmGradientStart = Color(0xFFF59E0B);
  static const Color warmGradientEnd = Color(0xFFEF4444);
  static const Color coolGradientStart = Color(0xFF7C3AED);
  static const Color coolGradientEnd = Color(0xFF6366F1);

  // ==================== SEMANTIC COLORS ====================
  static const Color success = Color(0xFF10B981);
  static const Color warning = Color(0xFFF59E0B);
  static const Color error = Color(0xFFEF4444);
  static const Color info = Color(0xFF7C3AED);

  // ==================== NEUTRALS ====================
  static const Color white = Color(0xFFFFFFFF);
  static const Color black = Color(0xFF000000);
  static const Color transparent = Color(0x00000000);

  // ==================== GRAY SCALE ====================
  static const Color gray50 = Color(0xFFF9FAFB);
  static const Color gray100 = Color(0xFFF3F4F6);
  static const Color gray200 = Color(0xFFE5E7EB);
  static const Color gray300 = Color(0xFFD1D5DB);
  static const Color gray400 = Color(0xFF9CA3AF);
  static const Color gray500 = Color(0xFF6B7280);
  static const Color gray600 = Color(0xFF4B5563);
  static const Color gray700 = Color(0xFF374151);
  static const Color gray800 = Color(0xFF1F2937);
  static const Color gray900 = Color(0xFF111827);

  // ==================== LIGHT THEME ====================
  static const Color lightBackground = Color(0xFFF7F7F7);
  static const Color lightSurface = Color(0xFFFFFFFF);
  static const Color lightPrimaryText = Color(0xFF0F172A);
  static const Color lightSecondaryText = Color(0xFF64748B);
  static const Color lightIcon = Color(0xFF334155);
  static const Color lightDivider = Color(0xFFE2E8F0);

  // ==================== DARK THEME ====================
  static const Color darkBackground = Color(0xFF0F0F23);
  static const Color darkSurface = Color(0xFF1A1B3A);
  static const Color darkCardBackground = Color(0xFF1E1E2E);
  static const Color darkElevatedSurface = Color(0xFF2A2A3A);
  static const Color darkPrimaryText = Color(0xFFFFFFFF);
  static const Color darkSecondaryText = Color(0xFFA1A1AA);
  static const Color darkIcon = Color(0xFFF4F4F5);
  static const Color darkDivider = Color(0xFF3F3F46);

  // ==================== GLASSMORPHISM ====================
  static const Color glassOverlayLight = Color(0x1AFFFFFF);
  static const Color glassOverlayDark = Color(0x1A000000);

  // ==================== UTILITY METHODS (Updated) ====================
  static Color withOpacity(Color color, double opacity) {
    return color.withValues(alpha: opacity);
  }

  static Color primaryWithOpacity(double opacity) {
    return primary.withValues(alpha: opacity);
  }

  static Color secondaryWithOpacity(double opacity) {
    return secondary.withValues(alpha: opacity);
  }

  static Color accentWithOpacity(double opacity) {
    return accent.withValues(alpha: opacity);
  }
}