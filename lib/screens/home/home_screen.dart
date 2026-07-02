// lib/screens/home/home_screen.dart
// The complete home screen — assembles all sections into a single beautiful page

import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gap/gap.dart';

import '../../core/constants/app_colors.dart';
import '../../core/constants/app_strings.dart';
import '../../widgets/animated_background.dart';
import '../../widgets/floating_hearts.dart';
import '../../widgets/glass_card.dart';
import '../../widgets/section_title.dart';
import '../../widgets/sparkle_widget.dart';
import '../../widgets/typing_text.dart';
import '../love_timer/love_timer_section.dart';
import '../special_sections/beauty_section.dart';
import '../quiz/quiz_screen.dart';
import '../100_names/names_screen.dart';
import '../love_letters/love_letter_screen.dart';
import '../gallery/gallery_screen.dart';
import '../memories/memories_screen.dart';
import '../ending/ending_section.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  final ScrollController _scrollController = ScrollController();
  bool _showScrollTop = false;

  // Section keys for navigation
  final _heroKey = GlobalKey();
  final _timerKey = GlobalKey();
  final _galleryKey = GlobalKey();
  final _beautyKey = GlobalKey();
  final _quizKey = GlobalKey();
  final _namesKey = GlobalKey();
  final _letterKey = GlobalKey();
  final _memoriesKey = GlobalKey();
  final _endingKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      final show = _scrollController.offset > 400;
      if (show != _showScrollTop) {
        setState(() => _showScrollTop = show);
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollToSection(GlobalKey key) {
    final ctx = key.currentContext;
    if (ctx != null) {
      Scrollable.ensureVisible(
        ctx,
        duration: const Duration(milliseconds: 800),
        curve: Curves.easeInOut,
      );
    }
  }

  void _scrollToTop() {
    _scrollController.animateTo(
      0,
      duration: const Duration(milliseconds: 800),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedBackground(
        child: Stack(
          children: [
            // Floating hearts overlay (subtle)
            const FloatingHearts(heartCount: 12),
            const SparkleWidget(sparkleCount: 8),

            // Main scrollable content
            CustomScrollView(
              controller: _scrollController,
              slivers: [
                // === NAVIGATION BAR ===
                SliverAppBar(
                  floating: true,
                  snap: true,
                  backgroundColor: Colors.transparent,
                  flexibleSpace: _buildNavBar(),
                  toolbarHeight: 72,
                  elevation: 0,
                ),

                SliverToBoxAdapter(
                  child: Column(
                    children: [
                      // 1. HERO SECTION
                      _HeroSection(key: _heroKey),

                      // Divider
                      _buildSectionDivider(),

                      // 2. LOVE TIMER
                      LoveTimerSection(key: _timerKey),

                      _buildSectionDivider(),

                      // 3. WELCOME (typing)
                      _WelcomeSection(),

                      _buildSectionDivider(),

                      // 4. GALLERY
                      GallerySection(key: _galleryKey),

                      _buildSectionDivider(),

                      // 5. BEAUTY SECTIONS (Eyes/Nose/Lips/Forehead)
                      BeautySection(key: _beautyKey),

                      _buildSectionDivider(),

                      // 6. ANGER SECTION
                      AngerSection(),

                      _buildSectionDivider(),

                      // 7. SAD SECTION
                      SadSection(),

                      _buildSectionDivider(),

                      // 8. LOVE QUIZ
                      QuizSection(key: _quizKey),

                      _buildSectionDivider(),

                      // 9. 100 NAMES
                      NamesSection(key: _namesKey),

                      _buildSectionDivider(),

                      // 10. LOVE LETTER
                      LoveLetterSection(key: _letterKey),

                      _buildSectionDivider(),

                      // 11. MEMORIES
                      MemoriesSection(key: _memoriesKey),

                      _buildSectionDivider(),

                      // 12. ENDING / FOOTER
                      EndingSection(key: _endingKey),
                    ],
                  ),
                ),
              ],
            ),

            // === SCROLL TO TOP FAB ===
            if (_showScrollTop)
              Positioned(
                bottom: 30,
                right: 30,
                child: GestureDetector(
                  onTap: _scrollToTop,
                  child: Container(
                    width: 52,
                    height: 52,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: AppColors.pinkGradient,
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.hotPink.withOpacity(0.5),
                          blurRadius: 15,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: const Icon(
                      Icons.keyboard_arrow_up_rounded,
                      color: Colors.white,
                      size: 28,
                    ),
                  ),
                )
                    .animate()
                    .scale(duration: 300.ms, curve: Curves.elasticOut)
                    .fadeIn(),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildNavBar() {
    final isWide = MediaQuery.sizeOf(context).width > 800;

    return ClipRRect(
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.glassWhite,
          border: Border(
            bottom: BorderSide(
              color: AppColors.glassBorder,
              width: 1,
            ),
          ),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: isWide ? 40 : 16,
            vertical: 12,
          ),
          child: Row(
            children: [
              // Logo
              ShaderMask(
                shaderCallback: (b) => AppColors.pinkGradient.createShader(b),
                child: Text(
                  'My Wifeu ❤️',
                  style: GoogleFonts.greatVibes(
                    fontSize: 26,
                    color: Colors.white,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),

              const Spacer(),

              if (isWide) ...[
                _navItem('Timer', () => _scrollToSection(_timerKey)),
                _navItem('Gallery', () => _scrollToSection(_galleryKey)),
                _navItem('Quiz', () => _scrollToSection(_quizKey)),
                _navItem('100 Names', () => _scrollToSection(_namesKey)),
                _navItem('Love Letter', () => _scrollToSection(_letterKey)),
                _navItem('Memories', () => _scrollToSection(_memoriesKey)),
              ] else
                IconButton(
                  onPressed: () => _showMobileMenu(),
                  icon: const Icon(Icons.menu_rounded, color: AppColors.softPink),
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _navItem(String label, VoidCallback onTap) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: GestureDetector(
        onTap: onTap,
        child: Text(
          label,
          style: GoogleFonts.lato(
            fontSize: 14,
            color: AppColors.softPink.withOpacity(0.85),
            fontWeight: FontWeight.w600,
            letterSpacing: 0.5,
          ),
        ),
      ),
    );
  }

  void _showMobileMenu() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (_) => Container(
        decoration: const BoxDecoration(
          color: AppColors.darkBg2,
          borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
          border: Border(
            top: BorderSide(color: AppColors.glassBorder),
            left: BorderSide(color: AppColors.glassBorder),
            right: BorderSide(color: AppColors.glassBorder),
          ),
        ),
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(2),
                color: AppColors.softPink.withOpacity(0.3),
              ),
            ),
            const Gap(20),
            _mobileNavItem('⏳ Timer', () {
              Navigator.pop(context);
              _scrollToSection(_timerKey);
            }),
            _mobileNavItem('📸 Gallery', () {
              Navigator.pop(context);
              _scrollToSection(_galleryKey);
            }),
            _mobileNavItem('💝 Quiz', () {
              Navigator.pop(context);
              _scrollToSection(_quizKey);
            }),
            _mobileNavItem('💕 100 Names', () {
              Navigator.pop(context);
              _scrollToSection(_namesKey);
            }),
            _mobileNavItem('✉️ Love Letter', () {
              Navigator.pop(context);
              _scrollToSection(_letterKey);
            }),
            _mobileNavItem('🎞️ Memories', () {
              Navigator.pop(context);
              _scrollToSection(_memoriesKey);
            }),
            const Gap(8),
          ],
        ),
      ),
    );
  }

  Widget _mobileNavItem(String label, VoidCallback onTap) {
    return ListTile(
      onTap: onTap,
      title: Text(
        label,
        style: GoogleFonts.dancingScript(
          fontSize: 22,
          color: AppColors.softPink,
          fontWeight: FontWeight.w700,
        ),
      ),
      trailing: const Icon(
        Icons.arrow_forward_ios_rounded,
        color: AppColors.roseGold,
        size: 16,
      ),
    );
  }

  Widget _buildSectionDivider() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40),
      child: Row(
        children: [
          Expanded(
            child: Container(
              height: 1,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Colors.transparent,
                    AppColors.roseGold.withOpacity(0.3),
                    Colors.transparent,
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              '❤️',
              style: TextStyle(
                fontSize: 14,
                color: AppColors.hotPink.withOpacity(0.6),
              ),
            ),
          ),
          Expanded(
            child: Container(
              height: 1,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Colors.transparent,
                    AppColors.roseGold.withOpacity(0.3),
                    Colors.transparent,
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ============================================================
// HERO SECTION
// ============================================================
class _HeroSection extends StatelessWidget {
  const _HeroSection({super.key});

  @override
  Widget build(BuildContext context) {
    final isWide = MediaQuery.sizeOf(context).width > 700;
    final size = MediaQuery.sizeOf(context);

    return Container(
      constraints: BoxConstraints(minHeight: math.max(500, size.height * 0.85)),
      alignment: Alignment.center,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: isWide ? 80 : 24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Rose decorations
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: ['🌹', '✦', '❤️', '✦', '🌹']
                  .map((e) => Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 6),
                        child: Text(e, style: const TextStyle(fontSize: 20)),
                      ))
                  .toList(),
            )
                .animate()
                .fadeIn(delay: 200.ms, duration: 600.ms)
                .slideY(begin: -0.2),

            const Gap(20),

            // Big title
            ShaderMask(
              shaderCallback: (b) => AppColors.pinkGradient.createShader(b),
              child: Text(
                'My Wifeu ❤️ My Grace',
                style: GoogleFonts.greatVibes(
                  fontSize: isWide ? 80 : 48,
                  color: Colors.white,
                  fontWeight: FontWeight.w400,
                  letterSpacing: 2,
                  height: 1.1,
                  shadows: [
                    Shadow(
                      color: AppColors.hotPink.withOpacity(0.5),
                      blurRadius: 30,
                    ),
                  ],
                ),
                textAlign: TextAlign.center,
              ),
            )
                .animate()
                .fadeIn(delay: 400.ms, duration: 1000.ms)
                .scale(begin: const Offset(0.8, 0.8), curve: Curves.easeOut),

            const Gap(16),

            // Subtitle
            Text(
              'A website made only for my wife.',
              style: GoogleFonts.satisfy(
                fontSize: isWide ? 26 : 18,
                color: AppColors.softPink.withOpacity(0.8),
                letterSpacing: 1,
              ),
              textAlign: TextAlign.center,
            ).animate().fadeIn(delay: 700.ms, duration: 800.ms),

            const Gap(32),

            // Hero description
            ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 600),
              child: Text(
                'You are the poem I never knew how to write,\n'
                'the song I always wanted to sing,\n'
                'the home I was always searching for. ❤️',
                style: GoogleFonts.lato(
                  fontSize: isWide ? 20 : 16,
                  color: Colors.white.withOpacity(0.7),
                  height: 1.9,
                  letterSpacing: 0.5,
                  fontStyle: FontStyle.italic,
                ),
                textAlign: TextAlign.center,
              ),
            ).animate().fadeIn(delay: 900.ms, duration: 800.ms),

            const Gap(40),

            // Decorative hearts row
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(5, (i) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Text(
                    '❤️',
                    style: TextStyle(
                      fontSize: 16.0 + (i % 3) * 4,
                      shadows: [
                        Shadow(
                          color: AppColors.hotPink.withOpacity(0.6),
                          blurRadius: 10,
                        ),
                      ],
                    ),
                  )
                      .animate(
                        onPlay: (c) => c.repeat(reverse: true),
                        delay: Duration(milliseconds: i * 200),
                      )
                      .scale(
                        begin: const Offset(1, 1),
                        end: const Offset(1.3, 1.3),
                        duration: 600.ms,
                        curve: Curves.easeInOut,
                      ),
                );
              }),
            ).animate().fadeIn(delay: 1100.ms),

            const Gap(48),

            // Scroll down hint
            Column(
              children: [
                Text(
                  'Scroll to explore your story',
                  style: GoogleFonts.lato(
                    fontSize: 13,
                    color: Colors.white.withOpacity(0.35),
                    letterSpacing: 1,
                  ),
                ),
                const Gap(8),
                Icon(
                  Icons.keyboard_arrow_down_rounded,
                  color: AppColors.softPink.withOpacity(0.4),
                  size: 28,
                )
                    .animate(onPlay: (c) => c.repeat(reverse: true))
                    .moveY(begin: 0, end: 8, duration: 800.ms),
              ],
            ).animate().fadeIn(delay: 1300.ms),
          ],
        ),
      ),
    );
  }
}

// ============================================================
// WELCOME SECTION (with typing animation)
// ============================================================
class _WelcomeSection extends StatelessWidget {
  const _WelcomeSection();

  @override
  Widget build(BuildContext context) {
    final isWide = MediaQuery.sizeOf(context).width > 700;

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: isWide ? 80 : 24,
        vertical: 60,
      ),
      child: Column(
        children: [
          const SectionTitle(
            title: 'Welcome My Wifeu ❤️',
            subtitle: 'You are so loved.',
            emoji: '🌸',
          ),

          const Gap(40),

          GlowCard(
            glowColor: AppColors.roseGold,
            borderRadius: 28,
            padding: const EdgeInsets.all(40),
            child: Column(
              children: [
                const Text('💌', style: TextStyle(fontSize: 48)),
                const Gap(20),

                // Typing animation text
                TypingText(
                  texts: AppStrings.welcomeTypingLines,
                  style: GoogleFonts.lato(
                    fontSize: isWide ? 22 : 17,
                    color: Colors.white.withOpacity(0.9),
                    height: 1.7,
                    letterSpacing: 0.3,
                    fontStyle: FontStyle.italic,
                  ),
                ),

                const Gap(24),

                const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('✦', style: TextStyle(color: AppColors.roseGold)),
                    Gap(8),
                    Text('❤️', style: TextStyle(fontSize: 20)),
                    Gap(8),
                    Text('✦', style: TextStyle(color: AppColors.roseGold)),
                  ],
                ),
              ],
            ),
          ).animate().fadeIn(duration: 800.ms).slideY(begin: 0.2),
        ],
      ),
    );
  }
}
