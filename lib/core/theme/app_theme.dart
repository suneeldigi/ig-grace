// lib/core/theme/app_theme.dart
// Premium theme configuration for My Wifeu My Grace

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../constants/app_colors.dart';

class AppTheme {
  AppTheme._();

  static ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      scaffoldBackgroundColor: AppColors.darkBg,
      colorScheme: const ColorScheme.dark(
        primary: AppColors.hotPink,
        secondary: AppColors.roseGold,
        surface: AppColors.darkBg2,
        onPrimary: Colors.white,
        onSecondary: Colors.white,
        onSurface: Colors.white,
      ),

      // === TEXT THEME ===
      textTheme: TextTheme(
        // Display — Great Vibes (handwriting)
        displayLarge: GoogleFonts.greatVibes(
          fontSize: 72,
          color: AppColors.softPink,
          fontWeight: FontWeight.w400,
          letterSpacing: 2,
          shadows: [
            Shadow(
              color: AppColors.hotPink.withOpacity(0.5),
              blurRadius: 20,
            ),
          ],
        ),
        displayMedium: GoogleFonts.greatVibes(
          fontSize: 52,
          color: AppColors.softPink,
          fontWeight: FontWeight.w400,
          letterSpacing: 1.5,
        ),
        displaySmall: GoogleFonts.dancingScript(
          fontSize: 40,
          color: AppColors.softPink,
          fontWeight: FontWeight.w700,
        ),

        // Headline — Dancing Script
        headlineLarge: GoogleFonts.dancingScript(
          fontSize: 36,
          color: Colors.white,
          fontWeight: FontWeight.w700,
          letterSpacing: 1,
        ),
        headlineMedium: GoogleFonts.dancingScript(
          fontSize: 28,
          color: Colors.white,
          fontWeight: FontWeight.w600,
        ),
        headlineSmall: GoogleFonts.dancingScript(
          fontSize: 22,
          color: AppColors.blushPink,
          fontWeight: FontWeight.w600,
        ),

        // Title — Satisfy
        titleLarge: GoogleFonts.satisfy(
          fontSize: 24,
          color: AppColors.softPink,
          fontWeight: FontWeight.w400,
        ),
        titleMedium: GoogleFonts.satisfy(
          fontSize: 20,
          color: AppColors.softPink,
        ),
        titleSmall: GoogleFonts.lato(
          fontSize: 16,
          color: AppColors.softPink,
          fontWeight: FontWeight.w600,
          letterSpacing: 0.5,
        ),

        // Body — Lato
        bodyLarge: GoogleFonts.lato(
          fontSize: 18,
          color: Colors.white.withOpacity(0.9),
          height: 1.8,
          letterSpacing: 0.3,
        ),
        bodyMedium: GoogleFonts.lato(
          fontSize: 16,
          color: Colors.white.withOpacity(0.85),
          height: 1.7,
        ),
        bodySmall: GoogleFonts.lato(
          fontSize: 14,
          color: Colors.white.withOpacity(0.7),
          height: 1.6,
        ),

        // Label
        labelLarge: GoogleFonts.lato(
          fontSize: 16,
          color: Colors.white,
          fontWeight: FontWeight.w600,
          letterSpacing: 1.2,
        ),
        labelMedium: GoogleFonts.lato(
          fontSize: 14,
          color: AppColors.softPink,
          fontWeight: FontWeight.w500,
          letterSpacing: 0.5,
        ),
      ),

      // === ELEVATED BUTTON ===
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.hotPink,
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(50),
          ),
          elevation: 8,
          shadowColor: AppColors.hotPink.withOpacity(0.5),
          textStyle: GoogleFonts.dancingScript(
            fontSize: 18,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),

      // === INPUT DECORATION ===
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppColors.glassWhite,
        contentPadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(color: AppColors.glassBorder, width: 1),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(
            color: AppColors.softPink.withOpacity(0.3),
            width: 1,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(color: AppColors.hotPink, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(color: Colors.redAccent, width: 1),
        ),
        labelStyle: GoogleFonts.lato(color: AppColors.softPink),
        hintStyle:
            GoogleFonts.lato(color: Colors.white.withOpacity(0.4), fontSize: 14),
        prefixIconColor: AppColors.softPink,
        suffixIconColor: AppColors.softPink,
      ),
    );
  }
}
