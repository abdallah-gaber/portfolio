import 'package:flutter/material.dart';
import '../constants/app_constants.dart';

/// Design system: light/dark themes, typography, spacing.
/// Uses Material 3 with a neutral base and one accent.
class AppTheme {
  AppTheme._();

  static const Color _accentLight = Color(0xFF2563EB); // blue-600
  static const Color _accentDark = Color(0xFF60A5FA);   // blue-400

  static ThemeData get light {
    return ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(
        seedColor: _accentLight,
        brightness: Brightness.light,
        primary: _accentLight,
      ),
      textTheme: _textTheme(Brightness.light),
      appBarTheme: const AppBarTheme(
        centerTitle: true,
        elevation: 0,
        scrolledUnderElevation: 1,
      ),
    );
  }

  static ThemeData get dark {
    return ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(
        seedColor: _accentDark,
        brightness: Brightness.dark,
        primary: _accentDark,
      ),
      textTheme: _textTheme(Brightness.dark),
      appBarTheme: const AppBarTheme(
        centerTitle: true,
        elevation: 0,
        scrolledUnderElevation: 1,
      ),
    );
  }

  static TextTheme _textTheme(Brightness brightness) {
    final base = brightness == Brightness.light
        ? Typography.material2021().black
        : Typography.material2021().white;
    return TextTheme(
      headlineLarge: base.headlineLarge?.copyWith(
        fontWeight: FontWeight.w700,
        letterSpacing: -0.5,
      ),
      headlineMedium: base.headlineMedium?.copyWith(
        fontWeight: FontWeight.w600,
        letterSpacing: -0.25,
      ),
      headlineSmall: base.headlineSmall?.copyWith(
        fontWeight: FontWeight.w600,
      ),
      titleLarge: base.titleLarge?.copyWith(
        fontWeight: FontWeight.w600,
      ),
      titleMedium: base.titleMedium?.copyWith(
        fontWeight: FontWeight.w500,
      ),
      titleSmall: base.titleSmall?.copyWith(
        fontWeight: FontWeight.w500,
      ),
      bodyLarge: base.bodyLarge,
      bodyMedium: base.bodyMedium,
      bodySmall: base.bodySmall,
      labelLarge: base.labelLarge?.copyWith(
        fontWeight: FontWeight.w500,
      ),
    );
  }

  /// Spacing scale (from AppConstants).
  static double get spaceXs => AppConstants.spaceXs;
  static double get spaceSm => AppConstants.spaceSm;
  static double get spaceMd => AppConstants.spaceMd;
  static double get spaceLg => AppConstants.spaceLg;
  static double get spaceXl => AppConstants.spaceXl;
  static double get spaceXxl => AppConstants.spaceXxl;
  static double get spaceSection => AppConstants.spaceSection;
}
