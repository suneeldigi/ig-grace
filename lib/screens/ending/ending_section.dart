// lib/screens/ending/ending_section.dart
// Beautiful footer / ending section with heart animation

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gap/gap.dart';
import 'package:confetti/confetti.dart';

import '../../core/constants/app_colors.dart';
import '../../core/constants/app_strings.dart';
import '../../widgets/glass_card.dart';
import '../../widgets/sparkle_widget.dart';

class EndingSection extends StatefulWidget {
  const EndingSection({super.key});

  @override
  State<EndingSection> createState() => _EndingSectionState();
}

class _EndingSectionState extends State<EndingSection>
    with SingleTickerProviderStateMixin {
  late AnimationController _heartController;
  late Animation<double> _heartScale;
  late ConfettiController _confettiController;

  @override
  void initState() {
    super.initState();
    _heartController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    )..repeat(reverse: true);

    _heartScale = Tween<double>(begin: 1.0, end: 1.25).animate(
      CurvedAnimation(parent: _heartController, curve: Curves.easeInOut),
    );

    _confettiController = ConfettiController(
      duration: const Duration(seconds: 4),
    );
  }

  @override
  void dispose() {
    _heartController.dispose();
    _confettiController.dispose();
    super.dispose();
  }

  void _onHeartTap() {
    _confettiController.play();
  }

  @override
  Widget build(BuildContext context) {
    final isWide = MediaQuery.sizeOf(context).width > 700;

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: isWide ? 60 : 24,
        vertical: 80,
      ),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Colors.transparent,
            AppColors.darkBg.withOpacity(0.8),
          ],
        ),
      ),
      child: Stack(
        alignment: Alignment.topCenter,
        children: [
          // Confetti
          ConfettiWidget(
            confettiController: _confettiController,
            blastDirectionality: BlastDirectionality.explosive,
            colors: const [
              AppColors.hotPink,
              AppColors.softPink,
              AppColors.roseGold,
              Colors.white,
              AppColors.lilac,
              AppColors.crimson,
            ],
            numberOfParticles: 50,
            maxBlastForce: 20,
          ),

          // Sparkle decoration (needs a bounded-size ancestor, so it lives
          // in this Stack rather than directly inside the Column below)
          const Positioned.fill(child: SparkleWidget(sparkleCount: 6)),

          Column(
            children: [
              // Big pulsing heart
              GestureDetector(
                onTap: _onHeartTap,
                child: ScaleTransition(
                  scale: _heartScale,
                  child: Text(
                    '❤️',
                    style: TextStyle(
                      fontSize: isWide ? 100 : 70,
                      shadows: [
                        Shadow(
                          color: AppColors.hotPink.withOpacity(0.8),
                          blurRadius: 40,
                        ),
                      ],
                    ),
                  ),
                ),
              ).animate().scale(duration: 1000.ms, curve: Curves.elasticOut),

              const Gap(8),

              Text(
                'Tap me 💕',
                style: GoogleFonts.lato(
                  fontSize: 12,
                  color: AppColors.softPink.withOpacity(0.4),
                ),
              ),

              const Gap(32),

              // Made with love text
              ShaderMask(
                shaderCallback: (b) => AppColors.roseGoldGradient.createShader(b),
                child: Text(
                  AppStrings.footerMadeBy,
                  style: GoogleFonts.satisfy(
                    fontSize: isWide ? 22 : 17,
                    color: Colors.white,
                    letterSpacing: 0.5,
                  ),
                ),
              ).animate().fadeIn(delay: 300.ms),

              const Gap(8),

              ShaderMask(
                shaderCallback: (b) => AppColors.pinkGradient.createShader(b),
                child: Text(
                  AppStrings.footerHubby,
                  style: GoogleFonts.greatVibes(
                    fontSize: isWide ? 56 : 40,
                    color: Colors.white,
                    fontWeight: FontWeight.w400,
                    shadows: [
                      Shadow(
                        color: AppColors.hotPink.withOpacity(0.4),
                        blurRadius: 15,
                      ),
                    ],
                  ),
                ),
              ).animate().fadeIn(delay: 400.ms).slideY(begin: 0.2),

              const Gap(12),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('✦', style: TextStyle(color: AppColors.roseGold, fontSize: 16)),
                  const Gap(12),
                  Text(
                    AppStrings.footerFor,
                    style: GoogleFonts.lato(
                      fontSize: 16,
                      color: AppColors.softPink.withOpacity(0.7),
                    ),
                  ),
                  const Gap(12),
                  const Text('✦', style: TextStyle(color: AppColors.roseGold, fontSize: 16)),
                ],
              ).animate().fadeIn(delay: 500.ms),

              const Gap(8),

              ShaderMask(
                shaderCallback: (b) => AppColors.pinkGradient.createShader(b),
                child: Text(
                  AppStrings.footerWifeu,
                  style: GoogleFonts.greatVibes(
                    fontSize: isWide ? 52 : 36,
                    color: Colors.white,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ).animate().fadeIn(delay: 600.ms),

              const Gap(40),

              // Quote card
              GlassCard(
                padding: const EdgeInsets.all(28),
                borderRadius: 20,
                borderColor: AppColors.roseGold.withOpacity(0.3),
                child: Text(
                  AppStrings.footerQuote,
                  style: GoogleFonts.satisfy(
                    fontSize: isWide ? 22 : 17,
                    color: AppColors.roseGold.withOpacity(0.9),
                    letterSpacing: 0.5,
                    height: 1.6,
                  ),
                  textAlign: TextAlign.center,
                ),
              ).animate().fadeIn(delay: 700.ms),

              const Gap(30),

              // Final row of hearts
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(7, (i) {
                  final size = i % 2 == 0 ? 20.0 : 14.0;
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4),
                    child: Text(
                      '❤️',
                      style: TextStyle(
                        fontSize: size,
                        shadows: [
                          Shadow(
                            color: AppColors.hotPink.withOpacity(0.5),
                            blurRadius: 8,
                          ),
                        ],
                      ),
                    )
                        .animate(
                          onPlay: (c) => c.repeat(reverse: true),
                          delay: Duration(milliseconds: i * 150),
                        )
                        .scale(
                          begin: const Offset(1, 1),
                          end: const Offset(1.3, 1.3),
                          duration: 600.ms,
                          curve: Curves.easeInOut,
                        ),
                  );
                }),
              ).animate().fadeIn(delay: 800.ms),

              const Gap(20),

              // Copyright
              Text(
                '© 2026 Made with ❤️ by Grey | Only for My Wifeu My Grace',
                style: GoogleFonts.lato(
                  fontSize: 12,
                  color: Colors.white.withOpacity(0.2),
                  letterSpacing: 0.5,
                ),
                textAlign: TextAlign.center,
              ).animate().fadeIn(delay: 1000.ms),
            ],
          ),
        ],
      ),
    );
  }
}
