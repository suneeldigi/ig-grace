// lib/screens/my_grace/my_grace_screen.dart
// Heartfelt message screen — the final love letter to Grace

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gap/gap.dart';

import '../../core/constants/app_colors.dart';
import '../../core/constants/app_constants.dart';
import '../../widgets/animated_background.dart';
import '../../widgets/floating_hearts.dart';
import '../../widgets/glass_card.dart';
import '../../widgets/sparkle_widget.dart';

class MyGraceScreen extends StatelessWidget {
  const MyGraceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isWide = MediaQuery.sizeOf(context).width > 700;

    return Scaffold(
      body: AnimatedBackground(
        child: Stack(
          children: [
            const FloatingHearts(heartCount: 18),
            const SparkleWidget(sparkleCount: 10),

            SafeArea(
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(
                  horizontal: isWide ? 60 : 20,
                  vertical: 40,
                ),
                child: Center(
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 700),
                    child: Column(
                      children: [
                        // === LOVESLIDE1 IMAGE ===
                        _LoveImage(isWide: isWide),

                        const Gap(40),

                        // === TITLE ===
                        ShaderMask(
                          shaderCallback: (b) =>
                              AppColors.pinkGradient.createShader(b),
                          child: Text(
                            'My Grace My Wifeu ❤️',
                            style: GoogleFonts.greatVibes(
                              fontSize: isWide ? 60 : 42,
                              color: Colors.white,
                              fontWeight: FontWeight.w400,
                              letterSpacing: 2,
                              shadows: [
                                Shadow(
                                  color:
                                      AppColors.hotPink.withOpacity(0.6),
                                  blurRadius: 30,
                                ),
                              ],
                            ),
                            textAlign: TextAlign.center,
                          ),
                        )
                            .animate()
                            .fadeIn(delay: 300.ms, duration: 1000.ms)
                            .scale(
                                begin: const Offset(0.85, 0.85),
                                curve: Curves.easeOut),

                        const Gap(32),

                        // === MAIN MESSAGE CARD ===
                        GlowCard(
                          glowColor: AppColors.hotPink,
                          borderRadius: 28,
                          padding: const EdgeInsets.all(32),
                          child: Column(
                            children: [
                              // Heart emoji
                              const Text('❤️',
                                      style: TextStyle(fontSize: 48))
                                  .animate(
                                      onPlay: (c) =>
                                          c.repeat(reverse: true))
                                  .scale(
                                    begin: const Offset(1, 1),
                                    end: const Offset(1.2, 1.2),
                                    duration: 800.ms,
                                  ),

                              const Gap(24),

                              // Main message text
                              Text(
                                'Muje ni pata h me kesa tha pehle, '
                                'in present me — me bs tumhara hu, '
                                'and future me tumhara rahunga.\n\n'
                                'Muje to bs tumhe khush dekhna h and always smile dekhni h.\n\n'
                                'Aaj fr meri vajah se mera bacha udas hogya. '
                                'Mne jaan buj ke ya intentionally preshan krne ka irada ni tha '
                                'and kabhi sochunga bhi nahi.\n\n'
                                'Hum kaam krte h, hum dono duniya bante h — '
                                'puri duniya aapki, or aap bs mere.\n\n'
                                'Agr ye padh ke face pr smile aae to bs vahi smile '
                                'mere dil ki heartbeat badha deti h.\n\n'
                                'Jaan me bs tumhare sath chahta hu, '
                                'or har din har raat chahta hu, har aadhi raat...\n'
                                'Na na — jha tu khush ho bs esa ek jahan chahta hu.',
                                style: GoogleFonts.lato(
                                  fontSize: isWide ? 18 : 16,
                                  color: Colors.white.withOpacity(0.92),
                                  height: 1.9,
                                  letterSpacing: 0.3,
                                ),
                                textAlign: TextAlign.center,
                              ),

                              const Gap(28),

                              // Decorative divider
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.center,
                                children: [
                                  const Text('✦',
                                      style: TextStyle(
                                          color: AppColors.roseGold,
                                          fontSize: 16)),
                                  const Gap(8),
                                  const Text('💕',
                                      style: TextStyle(fontSize: 20)),
                                  const Gap(8),
                                  const Text('✦',
                                      style: TextStyle(
                                          color: AppColors.roseGold,
                                          fontSize: 16)),
                                ],
                              ),
                            ],
                          ),
                        )
                            .animate()
                            .fadeIn(delay: 500.ms, duration: 900.ms)
                            .slideY(
                                begin: 0.2, curve: Curves.easeOut),

                        const Gap(36),

                        // === QUESTION CARD ===
                        GlowCard(
                          glowColor: AppColors.roseGold,
                          borderRadius: 28,
                          padding: const EdgeInsets.all(32),
                          child: Column(
                            children: [
                              const Text('🤗',
                                  style: TextStyle(fontSize: 44)),
                              const Gap(16),

                              Text(
                                'So kya aap apne paglu hubby ko '
                                'ek thapad, ek moka marke, '
                                'fr ek tight hug deke maaf kroge?',
                                style: GoogleFonts.dancingScript(
                                  fontSize: isWide ? 24 : 20,
                                  color: AppColors.softPink,
                                  fontWeight: FontWeight.w700,
                                  height: 1.6,
                                ),
                                textAlign: TextAlign.center,
                              ),

                              const Gap(24),

                              Text(
                                'Agr ha, to iska jawab dena:',
                                style: GoogleFonts.lato(
                                  fontSize: isWide ? 17 : 15,
                                  color:
                                      Colors.white.withOpacity(0.8),
                                  fontStyle: FontStyle.italic,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        )
                            .animate()
                            .fadeIn(delay: 700.ms, duration: 900.ms)
                            .slideY(
                                begin: 0.2, curve: Curves.easeOut),

                        const Gap(36),

                        // === FOREVER PROMISE CARD ===
                        GlowCard(
                          glowColor: AppColors.softPurple,
                          borderRadius: 28,
                          padding: const EdgeInsets.all(32),
                          child: Column(
                            children: [
                              const Text('💍',
                                  style: TextStyle(fontSize: 44)),
                              const Gap(16),

                              ShaderMask(
                                shaderCallback: (b) => AppColors
                                    .roseGoldGradient
                                    .createShader(b),
                                child: Text(
                                  'Kya aapko hmara sath hmesha ke lie qabul h?',
                                  style: GoogleFonts.greatVibes(
                                    fontSize: isWide ? 34 : 26,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w400,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),

                              const Gap(20),

                              Text(
                                'Ye sath jbtk chahiye tbtk — '
                                'hm budhe na ho jae, chal na pae, '
                                'muh me daant na ho — '
                                'fr bhi me isi trh parvah kru, khyal rakhu.\n\n'
                                'Tumhare pas always 5 KitKat ho, '
                                'jise meri yad aae, and bs yad krke smile krdo.\n\n'
                                'To kya qabul h aapko apke maal ka sath?\n\n'
                                'To text me type rkh dena — '
                                'me samj jaunga ki abhi thora maan gye ho, '
                                'baki or bhi mna lunga. 🥰',
                                style: GoogleFonts.lato(
                                  fontSize: isWide ? 17 : 15,
                                  color:
                                      Colors.white.withOpacity(0.9),
                                  height: 1.9,
                                  letterSpacing: 0.3,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        )
                            .animate()
                            .fadeIn(delay: 900.ms, duration: 900.ms)
                            .slideY(
                                begin: 0.2, curve: Curves.easeOut),

                        const Gap(48),

                        // === FINAL DECLARATION ===
                        Column(
                          children: [
                            ShaderMask(
                              shaderCallback: (b) =>
                                  AppColors.pinkGradient.createShader(b),
                              child: Text(
                                'My Grace ❤️',
                                style: GoogleFonts.greatVibes(
                                  fontSize: isWide ? 50 : 36,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w400,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                            const Gap(6),
                            Text(
                              'My Jaan ❤️ My Wifeu ❤️',
                              style: GoogleFonts.dancingScript(
                                fontSize: isWide ? 28 : 22,
                                color: AppColors.softPink,
                                fontWeight: FontWeight.w700,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            const Gap(12),

                            // Animated line
                            ShaderMask(
                              shaderCallback: (b) => AppColors
                                  .roseGoldGradient
                                  .createShader(b),
                              child: Text(
                                'My World ni ❌\nMy Galaxy ni ❌',
                                style: GoogleFonts.lato(
                                  fontSize: isWide ? 20 : 17,
                                  color: Colors.white,
                                  height: 1.8,
                                  fontWeight: FontWeight.w600,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),

                            const Gap(16),

                            // The big reveal
                            ShaderMask(
                              shaderCallback: (b) =>
                                  AppColors.pinkGradient.createShader(b),
                              child: Text(
                                'U R My Universe 🌌',
                                style: GoogleFonts.greatVibes(
                                  fontSize: isWide ? 64 : 44,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w400,
                                  letterSpacing: 2,
                                  shadows: [
                                    Shadow(
                                      color: AppColors.hotPink
                                          .withOpacity(0.7),
                                      blurRadius: 40,
                                    ),
                                  ],
                                ),
                                textAlign: TextAlign.center,
                              ),
                            )
                                .animate(
                                    onPlay: (c) =>
                                        c.repeat(reverse: true))
                                .scale(
                                  begin: const Offset(1, 1),
                                  end: const Offset(1.05, 1.05),
                                  duration: 2000.ms,
                                  curve: Curves.easeInOut,
                                ),

                            const Gap(24),

                            // Final love declaration
                            GlassCard(
                              padding: const EdgeInsets.all(28),
                              borderRadius: 20,
                              borderColor:
                                  AppColors.hotPink.withOpacity(0.4),
                              child: Column(
                                children: [
                                  Text(
                                    '❤️',
                                    style: TextStyle(
                                      fontSize: 40,
                                      shadows: [
                                        Shadow(
                                          color: AppColors.hotPink
                                              .withOpacity(0.8),
                                          blurRadius: 20,
                                        ),
                                      ],
                                    ),
                                  )
                                      .animate(
                                          onPlay: (c) =>
                                              c.repeat(reverse: true))
                                      .scale(
                                        begin: const Offset(1, 1),
                                        end: const Offset(1.3, 1.3),
                                        duration: 700.ms,
                                      ),
                                  const Gap(12),
                                  ShaderMask(
                                    shaderCallback: (b) => AppColors
                                        .pinkGradient
                                        .createShader(b),
                                    child: Text(
                                      'I Love U My Universe\nMore Than U ❤️',
                                      style: GoogleFonts.greatVibes(
                                        fontSize: isWide ? 42 : 30,
                                        color: Colors.white,
                                        fontWeight: FontWeight.w400,
                                        height: 1.3,
                                        shadows: [
                                          Shadow(
                                            color: AppColors.hotPink
                                                .withOpacity(0.5),
                                            blurRadius: 20,
                                          ),
                                        ],
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        )
                            .animate()
                            .fadeIn(delay: 1100.ms, duration: 1000.ms)
                            .slideY(
                                begin: 0.2, curve: Curves.easeOut),

                        const Gap(48),

                        // === HEARTS ROW ===
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: List.generate(7, (i) {
                            final size = i % 2 == 0 ? 20.0 : 14.0;
                            return Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 4),
                              child: Text(
                                '❤️',
                                style: TextStyle(
                                  fontSize: size,
                                  shadows: [
                                    Shadow(
                                      color: AppColors.hotPink
                                          .withOpacity(0.5),
                                      blurRadius: 8,
                                    ),
                                  ],
                                ),
                              )
                                  .animate(
                                    onPlay: (c) =>
                                        c.repeat(reverse: true),
                                    delay: Duration(
                                        milliseconds: i * 150),
                                  )
                                  .scale(
                                    begin: const Offset(1, 1),
                                    end: const Offset(1.3, 1.3),
                                    duration: 600.ms,
                                    curve: Curves.easeInOut,
                                  ),
                            );
                          }),
                        ).animate().fadeIn(delay: 1300.ms),

                        const Gap(24),

                        // Footer
                        Text(
                          '© 2026 Made with ❤️ by Grey | Only for My Wifeu My Grace',
                          style: GoogleFonts.lato(
                            fontSize: 12,
                            color: Colors.white.withOpacity(0.2),
                            letterSpacing: 0.5,
                          ),
                          textAlign: TextAlign.center,
                        ).animate().fadeIn(delay: 1500.ms),

                        const Gap(40),
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

// === LOVE IMAGE WITH FLOATING ANIMATION ===
class _LoveImage extends StatefulWidget {
  final bool isWide;
  const _LoveImage({required this.isWide});

  @override
  State<_LoveImage> createState() => _LoveImageState();
}

class _LoveImageState extends State<_LoveImage>
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
    _float = Tween<double>(begin: -8, end: 8).animate(
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
    final size = widget.isWide ? 380.0 : 280.0;

    return AnimatedBuilder(
      animation: _float,
      builder: (_, child) {
        return Transform.translate(
            offset: Offset(0, _float.value), child: child);
      },
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(32),
          boxShadow: [
            BoxShadow(
              color: AppColors.hotPink.withOpacity(0.5),
              blurRadius: 45,
              spreadRadius: 4,
            ),
            BoxShadow(
              color: AppColors.roseGold.withOpacity(0.3),
              blurRadius: 60,
              spreadRadius: 6,
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(32),
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(
                color: AppColors.hotPink.withOpacity(0.5),
                width: 2,
              ),
            ),
            child: Stack(
              fit: StackFit.expand,
              children: [
                // Gradient placeholder
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
                // Placeholder content
                Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text('💕', style: TextStyle(fontSize: 60)),
                      const Gap(10),
                      Text(
                        'My Grace',
                        style: GoogleFonts.dancingScript(
                          fontSize: 18,
                          color: Colors.white.withOpacity(0.5),
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                ),
                // Actual image
                Image.asset(
                  AppConstants.placeholderLove1,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) =>
                      const SizedBox.shrink(),
                ),
              ],
            ),
          ),
        ),
      ),
    ).animate().fadeIn(duration: 1000.ms).scale(
          begin: const Offset(0.85, 0.85),
          curve: Curves.easeOut,
        );
  }
}
