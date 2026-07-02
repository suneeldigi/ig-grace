// lib/core/constants/app_colors.dart
// All color constants for My Wifeu My Grace

import 'package:flutter/material.dart';

class AppColors {
  AppColors._();

  // === PRIMARY PALETTE ===
  static const Color deepRose = Color(0xFF8B0050);
  static const Color roseGold = Color(0xFFB76E79);
  static const Color hotPink = Color(0xFFFF4D8D);
  static const Color softPink = Color(0xFFFFB3C6);
  static const Color blushPink = Color(0xFFFFD6E0);
  static const Color paleRose = Color(0xFFFFF0F3);
  static const Color crimson = Color(0xFFDC143C);
  static const Color rosePink = Color(0xFFFF69B4);

  // === PURPLE TONES ===
  static const Color deepPurple = Color(0xFF2D0030);
  static const Color mediumPurple = Color(0xFF6B2D82);
  static const Color softPurple = Color(0xFFB47CC7);
  static const Color lavender = Color(0xFFE8D5F5);
  static const Color lilac = Color(0xFFD5B3F0);

  // === BACKGROUND ===
  static const Color darkBg = Color(0xFF0D0015);
  static const Color darkBg2 = Color(0xFF1A0020);
  static const Color darkBg3 = Color(0xFF250030);

  // === GLASS MORPHISM ===
  static const Color glassWhite = Color(0x15FFFFFF);
  static const Color glassPink = Color(0x20FF69B4);
  static const Color glassBorder = Color(0x30FFFFFF);
  static const Color glassStroke = Color(0x40FFB3C6);

  // === TEXT ===
  static const Color textPrimary = Color(0xFFFFFFFF);
  static const Color textSecondary = Color(0xFFFFB3C6);
  static const Color textMuted = Color(0x80FFFFFF);
  static const Color textGold = Color(0xFFFFD700);
  static const Color textRoseGold = Color(0xFFB76E79);

  // === GRADIENTS ===
  static const LinearGradient backgroundGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      Color(0xFF0D0015),
      Color(0xFF1A0025),
      Color(0xFF2D0040),
      Color(0xFF1A0030),
      Color(0xFF0D0020),
    ],
    stops: [0.0, 0.25, 0.5, 0.75, 1.0],
  );

  static const LinearGradient pinkGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      Color(0xFFFF4D8D),
      Color(0xFFB76E79),
      Color(0xFF8B0050),
    ],
  );

  static const LinearGradient roseGoldGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      Color(0xFFFFD700),
      Color(0xFFB76E79),
      Color(0xFFFF69B4),
    ],
  );

  static const LinearGradient purpleGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      Color(0xFF6B2D82),
      Color(0xFF2D0030),
      Color(0xFF8B0050),
    ],
  );

  static const LinearGradient cardGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      Color(0x25FFFFFF),
      Color(0x10FFFFFF),
    ],
  );

  static const LinearGradient heartGradient = LinearGradient(
    colors: [
      Color(0xFFFF4D8D),
      Color(0xFFFF1493),
      Color(0xFFDC143C),
    ],
  );

  // === SHADOWS & GLOW ===
  static List<BoxShadow> pinkGlow = [
    BoxShadow(
      color: hotPink.withOpacity(0.4),
      blurRadius: 30,
      spreadRadius: 5,
    ),
  ];

  static List<BoxShadow> roseGlow = [
    BoxShadow(
      color: roseGold.withOpacity(0.3),
      blurRadius: 25,
      spreadRadius: 3,
    ),
  ];

  static List<BoxShadow> cardShadow = [
    BoxShadow(
      color: Colors.black.withOpacity(0.4),
      blurRadius: 20,
      offset: const Offset(0, 8),
    ),
    BoxShadow(
      color: hotPink.withOpacity(0.15),
      blurRadius: 30,
      spreadRadius: 2,
    ),
  ];
}
