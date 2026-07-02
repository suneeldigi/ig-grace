// lib/widgets/section_title.dart
// Reusable section title widget with decorative elements

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import '../core/constants/app_colors.dart';

class SectionTitle extends StatelessWidget {
  final String title;
  final String? subtitle;
  final String? emoji;
  final bool centered;
  final Color? titleColor;

  const SectionTitle({
    super.key,
    required this.title,
    this.subtitle,
    this.emoji,
    this.centered = true,
    this.titleColor,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment:
          centered ? CrossAxisAlignment.center : CrossAxisAlignment.start,
      children: [
        // Emoji (optional)
        if (emoji != null)
          Text(
            emoji!,
            style: const TextStyle(fontSize: 40),
            textAlign: centered ? TextAlign.center : TextAlign.start,
          )
              .animate()
              .scale(duration: 600.ms, curve: Curves.elasticOut)
              .then()
              .shimmer(duration: 2000.ms, color: AppColors.softPink),

        const SizedBox(height: 12),

        // Decorative line
        if (centered) _buildDecorativeLine(),

        const SizedBox(height: 12),

        // Title
        ShaderMask(
          shaderCallback: (bounds) =>
              AppColors.pinkGradient.createShader(bounds),
          child: Text(
            title,
            style: GoogleFonts.greatVibes(
              fontSize: _getTitleSize(context),
              color: Colors.white,
              fontWeight: FontWeight.w400,
              letterSpacing: 1.5,
              height: 1.2,
            ),
            textAlign: centered ? TextAlign.center : TextAlign.start,
          ),
        )
            .animate()
            .fadeIn(duration: 800.ms)
            .slideY(begin: 0.3, curve: Curves.easeOut),

        // Subtitle
        if (subtitle != null) ...[
          const SizedBox(height: 8),
          Text(
            subtitle!,
            style: GoogleFonts.lato(
              fontSize: 16,
              color: AppColors.softPink.withOpacity(0.8),
              letterSpacing: 0.5,
              height: 1.5,
            ),
            textAlign: centered ? TextAlign.center : TextAlign.start,
          ).animate().fadeIn(delay: 300.ms, duration: 600.ms),
        ],

        const SizedBox(height: 8),
        if (centered) _buildDecorativeLine(),
      ],
    );
  }

  Widget _buildDecorativeLine() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          height: 1,
          width: 60,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Colors.transparent,
                AppColors.roseGold,
              ],
            ),
          ),
        ),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 12),
          child: Text('✦', style: TextStyle(color: AppColors.roseGold)),
        ),
        Container(
          height: 1,
          width: 60,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                AppColors.roseGold,
                Colors.transparent,
              ],
            ),
          ),
        ),
      ],
    ).animate().fadeIn(delay: 200.ms, duration: 500.ms);
  }

  double _getTitleSize(BuildContext context) {
    final w = MediaQuery.sizeOf(context).width;
    if (w > 1200) return 56;
    if (w > 800) return 44;
    if (w > 600) return 36;
    return 30;
  }
}

/// A smaller inline title for cards
class CardTitle extends StatelessWidget {
  final String title;
  final double fontSize;
  final Color? color;

  const CardTitle({
    super.key,
    required this.title,
    this.fontSize = 26,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      shaderCallback: (bounds) => AppColors.pinkGradient.createShader(bounds),
      child: Text(
        title,
        style: GoogleFonts.dancingScript(
          fontSize: fontSize,
          color: color ?? Colors.white,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}
