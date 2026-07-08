// lib/screens/apology/apology_screen.dart
// The surprise that opens right after a successful login — a heartfelt
// apology, a gallery of memories, a Valentine's card and a forgiveness ritual.

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gap/gap.dart';
import 'package:confetti/confetti.dart';

import '../../core/constants/app_colors.dart';
import '../../core/constants/app_constants.dart';
import '../../core/constants/app_strings.dart';
import '../../widgets/animated_background.dart';
import '../../widgets/floating_hearts.dart';
import '../../widgets/glass_card.dart';
import '../../widgets/glowing_heart.dart';
import '../../widgets/heart_burst.dart';
import '../../widgets/love_image_slider.dart';
import '../../widgets/reason_carousel.dart';
import '../../widgets/section_title.dart';
import '../../widgets/sparkle_widget.dart';
import '../../widgets/typing_text.dart';

class ApologyScreen extends StatefulWidget {
  const ApologyScreen({super.key});

  @override
  State<ApologyScreen> createState() => _ApologyScreenState();
}

class _ApologyScreenState extends State<ApologyScreen> {
  final _heartBurstKey = GlobalKey<HeartBurstState>();
  late final ConfettiController _confettiController;

  bool _showMessage = false;
  bool _showForgivePopup = false;

  @override
  void initState() {
    super.initState();
    _confettiController = ConfettiController(
      duration: const Duration(seconds: 4),
    );
  }

  @override
  void dispose() {
    _confettiController.dispose();
    super.dispose();
  }

  void _onTypingComplete() {
    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) setState(() => _showMessage = true);
    });
  }

  void _onForgivePressed() {
    _heartBurstKey.currentState?.play();
    _confettiController.play();
    setState(() => _showForgivePopup = true);
  }

  void _closePopupAndContinue() {
    setState(() => _showForgivePopup = false);
    Navigator.of(context).pushNamed(AppConstants.foreverRoute);
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    final isWide = size.width > 700;

    return Scaffold(
      body: AnimatedBackground(
        child: Stack(
          children: [
            const FloatingHearts(heartCount: 20),
            const SparkleWidget(sparkleCount: 12),

            SafeArea(
              child: Center(
                child: SingleChildScrollView(
                  padding: EdgeInsets.symmetric(
                    horizontal: isWide ? 60 : 20,
                    vertical: 60,
                  ),
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 880),
                    child: Column(
                      children: [
                        // === HERO: GLOWING HEART + TYPING TEXT ===
                        GlowingHeart(size: isWide ? 140 : 100),

                        const Gap(32),

                        TypingText(
                          texts: const [AppStrings.apologyTypingText],
                          loop: false,
                          showCursor: true,
                          onComplete: _onTypingComplete,
                          style: GoogleFonts.greatVibes(
                            fontSize: isWide ? 48 : 34,
                            color: AppColors.softPink,
                            fontWeight: FontWeight.w400,
                            letterSpacing: 1.5,
                            shadows: [
                              Shadow(
                                color: AppColors.hotPink.withOpacity(0.5),
                                blurRadius: 20,
                              ),
                            ],
                          ),
                        ),

                        const Gap(48),

                        if (_showMessage) ...[
                          // === APOLOGY MESSAGE ===
                          GlowCard(
                            glowColor: AppColors.hotPink,
                            borderRadius: 28,
                            padding: const EdgeInsets.all(36),
                            child: Text(
                              AppStrings.apologyMessage,
                              style: GoogleFonts.lato(
                                fontSize: isWide ? 19 : 16,
                                color: Colors.white.withOpacity(0.92),
                                height: 1.9,
                                letterSpacing: 0.3,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          )
                              .animate()
                              .fadeIn(duration: 900.ms)
                              .slideY(begin: 0.2, curve: Curves.easeOut),

                          const Gap(64),

                          // === IMAGE SLIDER ===
                          SectionTitle(
                            title: 'Our Little Moments',
                            subtitle: 'Every picture, a piece of my heart',
                            emoji: '📸',
                          ).animate().fadeIn(delay: 200.ms, duration: 800.ms),

                          const Gap(28),

                          LoveImageSlider(
                            imagePaths: const [
                              AppConstants.placeholderLove1,
                              AppConstants.placeholderLove2,
                              AppConstants.placeholderLove3,
                            ],
                            captions: const [
                              'My Favorite Person 💕',
                              'Your Beautiful Smile 🌸',
                              'Made For Each Other 👑',
                            ],
                          ).animate().fadeIn(delay: 400.ms, duration: 900.ms),

                          const Gap(64),

                          // === VALENTINE'S CARD ===
                          GlowCard(
                            glowColor: AppColors.roseGold,
                            borderRadius: 28,
                            padding: const EdgeInsets.all(36),
                            child: Column(
                              children: [
                                ShaderMask(
                                  shaderCallback: (b) =>
                                      AppColors.roseGoldGradient.createShader(b),
                                  child: Text(
                                    AppStrings.valentineCardTitle,
                                    style: GoogleFonts.greatVibes(
                                      fontSize: isWide ? 40 : 30,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w400,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                                const Gap(24),
                                Text(
                                  AppStrings.valentineCardParagraph,
                                  style: GoogleFonts.lato(
                                    fontSize: isWide ? 17 : 15,
                                    color: Colors.white.withOpacity(0.85),
                                    height: 1.9,
                                    letterSpacing: 0.2,
                                    fontStyle: FontStyle.italic,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                          ).animate().fadeIn(delay: 600.ms, duration: 900.ms).slideY(
                                begin: 0.2,
                                curve: Curves.easeOut,
                              ),

                          const Gap(64),

                          // === REASONS WHY I LOVE YOU ===
                          SectionTitle(
                            title: 'Reasons Why I Love You ❤️',
                            emoji: '💗',
                          ).animate().fadeIn(delay: 700.ms, duration: 800.ms),

                          const Gap(28),

                          ReasonCarousel(reasons: AppStrings.loveReasons)
                              .animate()
                              .fadeIn(delay: 800.ms, duration: 900.ms)
                              .scale(begin: const Offset(0.95, 0.95)),

                          const Gap(64),

                          // === FORGIVE BUTTON ===
                          _ForgiveButton(onPressed: _onForgivePressed)
                              .animate()
                              .fadeIn(delay: 900.ms, duration: 800.ms)
                              .scale(begin: const Offset(0.9, 0.9)),

                          const Gap(40),
                        ],
                      ],
                    ),
                  ),
                ),
              ),
            ),

            // === CELEBRATION LAYER ===
            HeartBurst(key: _heartBurstKey),
            Align(
              alignment: Alignment.topCenter,
              child: ConfettiWidget(
                confettiController: _confettiController,
                blastDirectionality: BlastDirectionality.explosive,
                colors: const [
                  AppColors.hotPink,
                  AppColors.softPink,
                  AppColors.roseGold,
                  Colors.white,
                  AppColors.lilac,
                ],
                numberOfParticles: 40,
                maxBlastForce: 18,
              ),
            ),

            // === FORGIVE POPUP ===
            if (_showForgivePopup) _buildForgivePopup(isWide),
          ],
        ),
      ),
    );
  }

  Widget _buildForgivePopup(bool isWide) {
    return Positioned.fill(
      child: Container(
        color: Colors.black.withOpacity(0.55),
        child: Center(
          child: GlassCard(
            width: isWide ? 480 : null,
            margin: const EdgeInsets.symmetric(horizontal: 24),
            padding: const EdgeInsets.all(36),
            borderRadius: 28,
            borderColor: AppColors.hotPink.withOpacity(0.6),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text('❤️', style: TextStyle(fontSize: 56))
                    .animate(onPlay: (c) => c.repeat(reverse: true))
                    .scale(
                      begin: const Offset(1, 1),
                      end: const Offset(1.2, 1.2),
                      duration: 700.ms,
                    ),
                const Gap(16),
                ShaderMask(
                  shaderCallback: (b) => AppColors.pinkGradient.createShader(b),
                  child: Text(
                    AppStrings.forgivePopupTitle,
                    style: GoogleFonts.dancingScript(
                      fontSize: 30,
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                const Gap(16),
                Text(
                  AppStrings.forgivePopupBody,
                  style: GoogleFonts.lato(
                    fontSize: 16,
                    color: Colors.white.withOpacity(0.9),
                    height: 1.8,
                  ),
                  textAlign: TextAlign.center,
                ),
                const Gap(28),
                SizedBox(
                  width: double.infinity,
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      gradient: AppColors.pinkGradient,
                      borderRadius: BorderRadius.circular(28),
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.hotPink.withOpacity(0.5),
                          blurRadius: 20,
                          offset: const Offset(0, 6),
                        ),
                      ],
                    ),
                    child: ElevatedButton(
                      onPressed: _closePopupAndContinue,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.transparent,
                        shadowColor: Colors.transparent,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(28),
                        ),
                      ),
                      child: Text(
                        'Forever Yours ❤️',
                        style: GoogleFonts.dancingScript(
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          )
              .animate()
              .scale(
                begin: const Offset(0.6, 0.6),
                duration: 450.ms,
                curve: Curves.elasticOut,
              )
              .fadeIn(duration: 300.ms),
        ),
      ),
    );
  }
}

class _ForgiveButton extends StatelessWidget {
  final VoidCallback onPressed;
  const _ForgiveButton({required this.onPressed});

  @override
  Widget build(BuildContext context) {
    final isWide = MediaQuery.sizeOf(context).width > 700;

    return SizedBox(
      width: isWide ? 420 : double.infinity,
      height: 64,
      child: DecoratedBox(
        decoration: BoxDecoration(
          gradient: AppColors.pinkGradient,
          borderRadius: BorderRadius.circular(32),
          boxShadow: [
            BoxShadow(
              color: AppColors.hotPink.withOpacity(0.55),
              blurRadius: 30,
              spreadRadius: 2,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.transparent,
            shadowColor: Colors.transparent,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(32),
            ),
          ),
          child: Text(
            AppStrings.forgiveButtonText,
            style: GoogleFonts.dancingScript(
              fontSize: 24,
              fontWeight: FontWeight.w700,
              color: Colors.white,
              letterSpacing: 1,
            ),
          ),
        ),
      ),
    );
  }
}
