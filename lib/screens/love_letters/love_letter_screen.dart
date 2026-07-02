// lib/screens/love_letters/love_letter_screen.dart
// Premium love letter section with scroll reveal and elegant typography

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gap/gap.dart';

import '../../core/constants/app_colors.dart';
import '../../core/constants/app_strings.dart';
import '../../widgets/glass_card.dart';
import '../../widgets/section_title.dart';

class LoveLetterSection extends StatelessWidget {
  const LoveLetterSection({super.key});

  @override
  Widget build(BuildContext context) {
    final isWide = MediaQuery.sizeOf(context).width > 700;

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: isWide ? 80 : 20,
        vertical: 60,
      ),
      child: Column(
        children: [
          const SectionTitle(
            title: 'A Letter to My Universe',
            subtitle: 'Written with every heartbeat',
            emoji: '✉️',
          ),

          const Gap(50),

          GlowCard(
            glowColor: AppColors.roseGold,
            borderRadius: 32,
            padding: const EdgeInsets.all(0),
            child: Container(
              padding: EdgeInsets.all(isWide ? 56 : 28),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(32),
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    AppColors.darkBg2.withOpacity(0.95),
                    AppColors.darkBg3.withOpacity(0.9),
                  ],
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Letter header
                  _buildLetterHeader(isWide),

                  const Gap(32),

                  // Divider
                  Container(
                    height: 1,
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Colors.transparent,
                          AppColors.roseGold,
                          Colors.transparent,
                        ],
                      ),
                    ),
                  ),

                  const Gap(32),

                  // Letter body
                  _buildLetterBody(isWide),

                  const Gap(32),

                  // Divider
                  Container(
                    height: 1,
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Colors.transparent,
                          AppColors.roseGold,
                          Colors.transparent,
                        ],
                      ),
                    ),
                  ),

                  const Gap(32),

                  // Signature
                  _buildSignature(isWide),
                ],
              ),
            ),
          )
              .animate()
              .fadeIn(duration: 1000.ms)
              .slideY(begin: 0.3, curve: Curves.easeOut),

          const Gap(40),

          // Quote below letter
          Text(
            '"Distance means so little when someone means so much."',
            style: GoogleFonts.greatVibes(
              fontSize: isWide ? 28 : 22,
              color: AppColors.roseGold.withOpacity(0.7),
              letterSpacing: 1,
            ),
            textAlign: TextAlign.center,
          ).animate().fadeIn(delay: 500.ms, duration: 800.ms),
        ],
      ),
    );
  }

  Widget _buildLetterHeader(bool isWide) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // "To" line with decoration
        Row(
          children: [
            const Text('💌', style: TextStyle(fontSize: 28)),
            const Gap(12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'To,',
                  style: GoogleFonts.satisfy(
                    fontSize: 18,
                    color: AppColors.softPink.withOpacity(0.7),
                  ),
                ),
                ShaderMask(
                  shaderCallback: (b) =>
                      AppColors.pinkGradient.createShader(b),
                  child: Text(
                    'My Dearest Grace ❤️',
                    style: GoogleFonts.greatVibes(
                      fontSize: isWide ? 38 : 28,
                      color: Colors.white,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ).animate().fadeIn(delay: 200.ms),

        const Gap(12),

        Text(
          AppStrings.loveLetterDate,
          style: GoogleFonts.lato(
            fontSize: 13,
            color: AppColors.roseGold.withOpacity(0.6),
            fontStyle: FontStyle.italic,
            letterSpacing: 1,
          ),
        ).animate().fadeIn(delay: 400.ms),
      ],
    );
  }

  Widget _buildLetterBody(bool isWide) {
    // Split letter into paragraphs for better readability
    final paragraphs = AppStrings.loveLetter.split('\n\n');

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: paragraphs.asMap().entries.map((entry) {
        final i = entry.key;
        final paragraph = entry.value.trim();

        if (paragraph.isEmpty) return const SizedBox.shrink();

        return Padding(
          padding: const EdgeInsets.only(bottom: 20),
          child: Text(
            paragraph,
            style: GoogleFonts.lato(
              fontSize: isWide ? 17 : 15,
              color: Colors.white.withOpacity(0.88),
              height: 2.0,
              letterSpacing: 0.3,
            ),
          )
              .animate()
              .fadeIn(
                delay: Duration(milliseconds: 300 + i * 80),
                duration: 600.ms,
              )
              .slideY(begin: 0.1),
        );
      }).toList(),
    );
  }

  Widget _buildSignature(bool isWide) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              'Yours, completely and forever,',
              style: GoogleFonts.satisfy(
                fontSize: 18,
                color: AppColors.softPink.withOpacity(0.8),
              ),
            ),
            const Gap(8),
            ShaderMask(
              shaderCallback: (b) => AppColors.roseGoldGradient.createShader(b),
              child: Text(
                'Grey 🤍',
                style: GoogleFonts.greatVibes(
                  fontSize: isWide ? 44 : 34,
                  color: Colors.white,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            const Gap(4),
            Text(
              'P.S. — I love you more than you. ❤️',
              style: GoogleFonts.lato(
                fontSize: 13,
                color: AppColors.roseGold.withOpacity(0.7),
                fontStyle: FontStyle.italic,
              ),
            ),
          ],
        ),
      ],
    ).animate().fadeIn(delay: 600.ms);
  }
}
