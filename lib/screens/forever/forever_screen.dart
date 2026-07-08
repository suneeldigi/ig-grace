// lib/screens/forever/forever_screen.dart
// The final destination of the surprise — our biggest photo and one promise.

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gap/gap.dart';

import '../../core/constants/app_colors.dart';
import '../../core/constants/app_constants.dart';
import '../../core/constants/app_strings.dart';
import '../../widgets/animated_background.dart';
import '../../widgets/floating_hearts.dart';
import '../../widgets/sparkle_widget.dart';

class ForeverScreen extends StatelessWidget {
  const ForeverScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isWide = MediaQuery.sizeOf(context).width > 700;

    return Scaffold(
      body: AnimatedBackground(
        child: Stack(
          children: [
            const FloatingHearts(heartCount: 16),
            const SparkleWidget(sparkleCount: 10),

            SafeArea(
              child: Center(
                child: SingleChildScrollView(
                  padding: EdgeInsets.symmetric(
                    horizontal: isWide ? 60 : 24,
                    vertical: 60,
                  ),
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 700),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        _BiggestPhoto(isWide: isWide)
                            .animate()
                            .fadeIn(duration: 1000.ms)
                            .scale(begin: const Offset(0.85, 0.85)),

                        const Gap(56),

                        _GlowingForeverText(isWide: isWide),

                        const Gap(80),

                        // === FOOTER DEDICATION ===
                        Column(
                          children: [
                            Text(
                              AppStrings.footerMadeBy,
                              style: GoogleFonts.satisfy(
                                fontSize: isWide ? 22 : 18,
                                color: AppColors.roseGold.withOpacity(0.9),
                              ),
                            ),
                            const Gap(6),
                            ShaderMask(
                              shaderCallback: (b) =>
                                  AppColors.pinkGradient.createShader(b),
                              child: Text(
                                AppStrings.footerHubby,
                                style: GoogleFonts.greatVibes(
                                  fontSize: isWide ? 48 : 36,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ),
                            const Gap(10),
                            Text(
                              AppStrings.footerFor,
                              style: GoogleFonts.lato(
                                fontSize: 15,
                                color: Colors.white.withOpacity(0.6),
                                letterSpacing: 1,
                              ),
                            ),
                            const Gap(6),
                            ShaderMask(
                              shaderCallback: (b) =>
                                  AppColors.pinkGradient.createShader(b),
                              child: Text(
                                AppStrings.footerWifeu,
                                style: GoogleFonts.greatVibes(
                                  fontSize: isWide ? 44 : 32,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ),
                          ],
                        ).animate().fadeIn(delay: 600.ms, duration: 900.ms),

                        const Gap(40),

                        // === NEXT BUTTON ===
                        SizedBox(
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
                              onPressed: () {
                                Navigator.of(context).pushNamed(
                                  AppConstants.myGraceRoute,
                                );
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.transparent,
                                shadowColor: Colors.transparent,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(32),
                                ),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'Next',
                                    style: GoogleFonts.dancingScript(
                                      fontSize: 24,
                                      fontWeight: FontWeight.w700,
                                      color: Colors.white,
                                      letterSpacing: 1,
                                    ),
                                  ),
                                  const Gap(8),
                                  const Text('❤️',
                                      style: TextStyle(fontSize: 20)),
                                ],
                              ),
                            ),
                          ),
                        )
                            .animate()
                            .fadeIn(delay: 800.ms, duration: 800.ms)
                            .scale(
                              begin: const Offset(0.9, 0.9),
                              curve: Curves.easeOut,
                            ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _BiggestPhoto extends StatefulWidget {
  final bool isWide;
  const _BiggestPhoto({required this.isWide});

  @override
  State<_BiggestPhoto> createState() => _BiggestPhotoState();
}

class _BiggestPhotoState extends State<_BiggestPhoto>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _float;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 5),
    )..repeat(reverse: true);
    _float = Tween<double>(begin: -10, end: 10).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = widget.isWide ? 440.0 : 300.0;

    return AnimatedBuilder(
      animation: _float,
      builder: (_, child) {
        return Transform.translate(offset: Offset(0, _float.value), child: child);
      },
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(36),
          boxShadow: [
            BoxShadow(
              color: AppColors.hotPink.withOpacity(0.5),
              blurRadius: 50,
              spreadRadius: 4,
            ),
            BoxShadow(
              color: AppColors.roseGold.withOpacity(0.3),
              blurRadius: 70,
              spreadRadius: 8,
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(36),
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(
                color: AppColors.glassStroke,
                width: 2,
              ),
            ),
            child: Stack(
              fit: StackFit.expand,
              children: [
                Container(
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        Color(0x40FF4D8D),
                        AppColors.darkBg2,
                      ],
                    ),
                  ),
                ),
                Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text('💑', style: TextStyle(fontSize: 80)),
                      const Gap(14),
                      Text(
                        'Our Biggest Memory',
                        style: GoogleFonts.dancingScript(
                          fontSize: 20,
                          color: Colors.white.withOpacity(0.6),
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      Text(
                        AppConstants.placeholderForeverPhoto.split('/').last,
                        style: GoogleFonts.lato(
                          fontSize: 11,
                          color: Colors.white.withOpacity(0.25),
                        ),
                      ),
                    ],
                  ),
                ),
                Image.asset(
                  AppConstants.placeholderForeverPhoto,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) =>
                      const SizedBox.shrink(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _GlowingForeverText extends StatefulWidget {
  final bool isWide;
  const _GlowingForeverText({required this.isWide});

  @override
  State<_GlowingForeverText> createState() => _GlowingForeverTextState();
}

class _GlowingForeverTextState extends State<_GlowingForeverText>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _glow;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat(reverse: true);
    _glow = Tween<double>(begin: 0.4, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _glow,
      builder: (_, __) {
        return ShaderMask(
          shaderCallback: (b) => AppColors.pinkGradient.createShader(b),
          child: Text(
            AppStrings.foreverTitle,
            style: GoogleFonts.greatVibes(
              fontSize: widget.isWide ? 90 : 56,
              color: Colors.white,
              fontWeight: FontWeight.w400,
              letterSpacing: 2,
              shadows: [
                Shadow(
                  color: AppColors.hotPink.withOpacity(_glow.value),
                  blurRadius: 50,
                ),
                Shadow(
                  color: AppColors.roseGold.withOpacity(_glow.value * 0.7),
                  blurRadius: 70,
                ),
              ],
            ),
            textAlign: TextAlign.center,
          ),
        );
      },
    ).animate().fadeIn(delay: 300.ms, duration: 1000.ms).slideY(begin: 0.2);
  }
}
