import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../constants/app_constants.dart';

class AppColors {
  AppColors._();

  static const Color bg = Color(0xFF080810);
  static const Color surface = Color(0xFF10101C);
  static const Color surfaceHigh = Color(0xFF18182A);
  static const Color violet = Color(0xFF7C6FFF);
  static const Color teal = Color(0xFF00E5C8);
  static const Color coral = Color(0xFFFF6B7A);
  static const Color glassFill = Color(0x0DFFFFFF);
  static const Color glassBorder = Color(0x1AFFFFFF);
  static const Color glassHover = Color(0x26FFFFFF);
  static const Color textPrimary = Color(0xFFF0F0FA);
  static const Color textSub = Color(0xFF8A8AB0);
  static const Color textMuted = Color(0xFF4A4A70);
}

class AppTheme {
  AppTheme._();

  static ThemeData get dark {
    final cs = ColorScheme.fromSeed(
      seedColor: AppColors.violet,
      brightness: Brightness.dark,
      primary: AppColors.violet,
      onPrimary: Colors.white,
      secondary: AppColors.teal,
      surface: AppColors.surface,
      onSurface: AppColors.textPrimary,
      surfaceContainer: AppColors.surfaceHigh,
    );
    return ThemeData(
      useMaterial3: true,
      colorScheme: cs,
      scaffoldBackgroundColor: AppColors.bg,
      textTheme: _textTheme(Brightness.dark),
      appBarTheme: AppBarTheme(
        backgroundColor: Colors.transparent,
        elevation: 0,
        scrolledUnderElevation: 0,
        titleTextStyle: GoogleFonts.spaceGrotesk(
          color: AppColors.textPrimary,
          fontSize: 18,
          fontWeight: FontWeight.w600,
        ),
      ),
      cardTheme: CardThemeData(
        color: AppColors.surfaceHigh,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: const BorderSide(color: AppColors.glassBorder, width: 1),
        ),
      ),
    );
  }

  static ThemeData get light => ThemeData(
    useMaterial3: true,
    colorScheme: ColorScheme.fromSeed(
      seedColor: const Color(0xFF5A4FFF),
      brightness: Brightness.light,
    ),
    textTheme: _textTheme(Brightness.light),
  );

  static TextTheme _textTheme(Brightness b) {
    final isLight = b == Brightness.light;
    final base = isLight
        ? Typography.material2021().black
        : Typography.material2021().white;
    final bodyColor = isLight ? const Color(0xFF2A2A3A) : AppColors.textSub;
    final titleColor = isLight
        ? const Color(0xFF0A0A1A)
        : AppColors.textPrimary;
    return base.copyWith(
      displayLarge: GoogleFonts.spaceGrotesk(
        fontSize: 72,
        fontWeight: FontWeight.w800,
        letterSpacing: -2,
        color: titleColor,
        height: 1.0,
      ),
      headlineLarge: GoogleFonts.spaceGrotesk(
        fontSize: 48,
        fontWeight: FontWeight.w700,
        letterSpacing: -1,
        color: titleColor,
      ),
      headlineMedium: GoogleFonts.spaceGrotesk(
        fontSize: 36,
        fontWeight: FontWeight.w700,
        letterSpacing: -0.5,
        color: titleColor,
      ),
      headlineSmall: GoogleFonts.spaceGrotesk(
        fontSize: 28,
        fontWeight: FontWeight.w600,
        color: titleColor,
      ),
      titleLarge: GoogleFonts.inter(
        fontSize: 20,
        fontWeight: FontWeight.w600,
        color: titleColor,
      ),
      titleMedium: GoogleFonts.inter(
        fontSize: 16,
        fontWeight: FontWeight.w500,
        color: titleColor,
      ),
      bodyLarge: GoogleFonts.inter(fontSize: 16, height: 1.6, color: bodyColor),
      bodyMedium: GoogleFonts.inter(
        fontSize: 14,
        height: 1.5,
        color: bodyColor,
      ),
      bodySmall: GoogleFonts.inter(
        fontSize: 12,
        height: 1.4,
        color: isLight ? const Color(0xFF4A4A6A) : AppColors.textMuted,
      ),
      labelLarge: GoogleFonts.inter(
        fontSize: 14,
        fontWeight: FontWeight.w600,
        letterSpacing: 0.5,
      ),
      labelSmall: GoogleFonts.spaceGrotesk(
        fontSize: 11,
        fontWeight: FontWeight.w600,
        letterSpacing: 1.2,
      ),
    );
  }

  static double get spaceXs => AppConstants.spaceXs;
  static double get spaceSm => AppConstants.spaceSm;
  static double get spaceMd => AppConstants.spaceMd;
  static double get spaceLg => AppConstants.spaceLg;
  static double get spaceXl => AppConstants.spaceXl;
  static double get spaceXxl => AppConstants.spaceXxl;
  static double get spaceSection => AppConstants.spaceSection;
}
