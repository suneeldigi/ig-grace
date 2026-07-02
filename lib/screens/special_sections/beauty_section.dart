// lib/screens/special_sections/beauty_section.dart
// Beautiful sections for Eyes, Nose, Lips, Forehead — with image placeholders

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gap/gap.dart';

import '../../core/constants/app_colors.dart';
import '../../core/constants/app_constants.dart';
import '../../core/constants/app_strings.dart';
import '../../widgets/glass_card.dart';
import '../../widgets/section_title.dart';

class BeautySection extends StatelessWidget {
  const BeautySection({super.key});

  @override
  Widget build(BuildContext context) {
    final isWide = MediaQuery.sizeOf(context).width > 800;

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: isWide ? 60 : 20,
        vertical: 60,
      ),
      child: Column(
        children: [
          const SectionTitle(
            title: 'The Beauty That Stole My Heart',
            subtitle: 'Every feature of yours is poetry written by God',
            emoji: '🌸',
          ),

          const Gap(60),

          // EYES
          _BeautyCard(
            title: AppStrings.eyesTitle,
            poem: AppStrings.eyesPoem,
            extended: AppStrings.eyesExtended,
            imagePath: AppConstants.placeholderEyes,
            emoji: '👁️',
            glowColor: AppColors.softPurple,
            imageLeft: true,
            isWide: isWide,
          ),

          const Gap(60),

          // NOSE
          _BeautyCard(
            title: AppStrings.noseTitle,
            poem: AppStrings.noseMain,
            extended: AppStrings.noseExtended,
            imagePath: AppConstants.placeholderNose,
            emoji: '✨',
            glowColor: AppColors.roseGold,
            imageLeft: false,
            isWide: isWide,
          ),

          const Gap(60),

          // LIPS
          _BeautyCard(
            title: AppStrings.lipsTitle,
            poem: AppStrings.lipsMain,
            extended: AppStrings.lipsExtended,
            imagePath: AppConstants.placeholderLips,
            emoji: '💋',
            glowColor: AppColors.hotPink,
            imageLeft: true,
            isWide: isWide,
          ),

          const Gap(60),

          // FOREHEAD
          _BeautyCard(
            title: AppStrings.foreheadTitle,
            poem: AppStrings.foreheadMain,
            extended: AppStrings.foreheadExtended,
            imagePath: AppConstants.placeholderForehead,
            emoji: '🌟',
            glowColor: AppColors.lilac,
            imageLeft: false,
            isWide: isWide,
          ),
        ],
      ),
    );
  }
}

class _BeautyCard extends StatefulWidget {
  final String title;
  final String poem;
  final String extended;
  final String imagePath;
  final String emoji;
  final Color glowColor;
  final bool imageLeft;
  final bool isWide;

  const _BeautyCard({
    required this.title,
    required this.poem,
    required this.extended,
    required this.imagePath,
    required this.emoji,
    required this.glowColor,
    required this.imageLeft,
    required this.isWide,
  });

  @override
  State<_BeautyCard> createState() => _BeautyCardState();
}

class _BeautyCardState extends State<_BeautyCard> {
  bool _expanded = false;

  @override
  Widget build(BuildContext context) {
    return GlowCard(
      glowColor: widget.glowColor,
      borderRadius: 28,
      padding: const EdgeInsets.all(0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(28),
        child: widget.isWide
            ? _buildWideLayout()
            : _buildNarrowLayout(),
      ),
    )
        .animate()
        .fadeIn(duration: 800.ms)
        .slideY(begin: 0.2, curve: Curves.easeOut);
  }

  Widget _buildWideLayout() {
    final imageWidget = _buildImagePlaceholder();
    final textWidget = _buildTextContent();

    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: widget.imageLeft
            ? [
                Expanded(flex: 2, child: imageWidget),
                Expanded(flex: 3, child: textWidget),
              ]
            : [
                Expanded(flex: 3, child: textWidget),
                Expanded(flex: 2, child: imageWidget),
              ],
      ),
    );
  }

  Widget _buildNarrowLayout() {
    return Column(
      children: [
        _buildImagePlaceholder(height: 250),
        _buildTextContent(),
      ],
    );
  }

  Widget _buildImagePlaceholder({double? height}) {
    return Container(
      height: height,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            widget.glowColor.withOpacity(0.3),
            widget.glowColor.withOpacity(0.1),
            AppColors.darkBg2,
          ],
        ),
      ),
      child: Stack(
        alignment: Alignment.center,
        fit: StackFit.expand,
        children: [
          // Fallback placeholder content
          Positioned.fill(
            child: Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  width: 120,
                  height: 120,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: widget.glowColor.withOpacity(0.15),
                    boxShadow: [
                      BoxShadow(
                        color: widget.glowColor.withOpacity(0.3),
                        blurRadius: 40,
                        spreadRadius: 10,
                      ),
                    ],
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(widget.emoji, style: const TextStyle(fontSize: 60))
                        .animate(onPlay: (c) => c.repeat(reverse: true))
                        .scale(
                          begin: const Offset(1, 1),
                          end: const Offset(1.1, 1.1),
                          duration: 2000.ms,
                          curve: Curves.easeInOut,
                        ),
                    const Gap(16),
                    Text(
                      'Photo Coming Soon 📸',
                      style: GoogleFonts.lato(
                        fontSize: 13,
                        color: widget.glowColor.withOpacity(0.7),
                        letterSpacing: 0.5,
                      ),
                    ),
                    const Gap(4),
                    Text(
                      '(Place image at ${widget.imagePath})',
                      style: GoogleFonts.lato(
                        fontSize: 10,
                        color: Colors.white.withOpacity(0.25),
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ],
            ),
          ),
          // Actual Image (only shown if present)
          Image.asset(
            widget.imagePath,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) {
              return const SizedBox.shrink();
            },
          ),
        ],
      ),
    );
  }

  Widget _buildTextContent() {
    return Container(
      padding: const EdgeInsets.all(32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Title
          Row(
            children: [
              Text(widget.emoji, style: const TextStyle(fontSize: 24)),
              const Gap(10),
              Expanded(
                child: ShaderMask(
                  shaderCallback: (b) =>
                      AppColors.pinkGradient.createShader(b),
                  child: Text(
                    widget.title,
                    style: GoogleFonts.dancingScript(
                      fontSize: 24,
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
            ],
          ),

          const Gap(20),

          // Poem (always visible)
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              border: Border(
                left: BorderSide(
                  color: widget.glowColor.withOpacity(0.6),
                  width: 3,
                ),
              ),
            ),
            child: Text(
              widget.poem,
              style: GoogleFonts.lato(
                fontSize: 16,
                color: Colors.white.withOpacity(0.9),
                height: 2.0,
                letterSpacing: 0.3,
                fontStyle: FontStyle.italic,
              ),
            ),
          ),

          // Expanded content
          AnimatedCrossFade(
            firstChild: const SizedBox.shrink(),
            secondChild: Padding(
              padding: const EdgeInsets.only(top: 20),
              child: Text(
                widget.extended,
                style: GoogleFonts.lato(
                  fontSize: 15,
                  color: Colors.white.withOpacity(0.75),
                  height: 1.9,
                  letterSpacing: 0.3,
                ),
              ),
            ),
            crossFadeState: _expanded
                ? CrossFadeState.showSecond
                : CrossFadeState.showFirst,
            duration: const Duration(milliseconds: 600),
          ),

          const Gap(20),

          // Read more button
          GestureDetector(
            onTap: () => setState(() => _expanded = !_expanded),
            child: Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: widget.glowColor.withOpacity(0.4),
                  width: 1,
                ),
                color: widget.glowColor.withOpacity(0.1),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    _expanded ? 'Show Less' : 'Read More...',
                    style: GoogleFonts.lato(
                      fontSize: 14,
                      color: widget.glowColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const Gap(6),
                  Icon(
                    _expanded
                        ? Icons.keyboard_arrow_up
                        : Icons.keyboard_arrow_down,
                    color: widget.glowColor,
                    size: 18,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ============================================================
// ANGER SECTION
// ============================================================
class AngerSection extends StatelessWidget {
  const AngerSection({super.key});

  @override
  Widget build(BuildContext context) {
    final isWide = MediaQuery.sizeOf(context).width > 700;

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: isWide ? 60 : 20,
        vertical: 60,
      ),
      child: Column(
        children: [
          const SectionTitle(
            title: 'My Cute Angry Wifeu',
            subtitle: 'Even her anger is adorable 😤❤️',
            emoji: '😤',
          ),

          const Gap(40),

          GlowCard(
            glowColor: AppColors.roseGold,
            borderRadius: 28,
            padding: const EdgeInsets.all(0),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(28),
              child: isWide
                  ? IntrinsicHeight(
                      child: Row(
                        children: [
                          Expanded(flex: 2, child: _buildAngerImage()),
                          Expanded(flex: 3, child: _buildAngerText()),
                        ],
                      ),
                    )
                  : Column(
                      children: [
                        _buildAngerImage(height: 250),
                        _buildAngerText(),
                      ],
                    ),
            ),
          ).animate().fadeIn(duration: 800.ms).slideY(begin: 0.2),
        ],
      ),
    );
  }

  Widget _buildAngerImage({double? height}) {
    return Container(
      height: height,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            AppColors.roseGold.withOpacity(0.3),
            AppColors.deepRose.withOpacity(0.2),
          ],
        ),
      ),
      child: Stack(
        fit: StackFit.expand,
        children: [
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('😤', style: const TextStyle(fontSize: 70))
                    .animate(onPlay: (c) => c.repeat(reverse: true))
                    .moveX(begin: -5, end: 5, duration: 300.ms),
                const Gap(12),
                Text(
                  'Cute Angry Baby',
                  style: GoogleFonts.dancingScript(
                    fontSize: 18,
                    color: AppColors.roseGold.withOpacity(0.8),
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const Gap(4),
                Text(
                  '(Add photo: ${AppConstants.placeholderAngry})',
                  style: GoogleFonts.lato(
                    fontSize: 10,
                    color: Colors.white.withOpacity(0.2),
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
          Image.asset(
            AppConstants.placeholderAngry,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) {
              return const SizedBox.shrink();
            },
          ),
        ],
      ),
    );
  }

  Widget _buildAngerText() {
    return Padding(
      padding: const EdgeInsets.all(32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ShaderMask(
            shaderCallback: (b) => AppColors.roseGoldGradient.createShader(b),
            child: Text(
              'When Baby Gets Angry... 😤',
              style: GoogleFonts.dancingScript(
                fontSize: 26,
                color: Colors.white,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          const Gap(20),
          Text(
            AppStrings.angerContent,
            style: GoogleFonts.lato(
              fontSize: 16,
              color: Colors.white.withOpacity(0.85),
              height: 1.9,
              letterSpacing: 0.3,
            ),
          ),
        ],
      ),
    );
  }
}

// ============================================================
// SAD SECTION
// ============================================================
class SadSection extends StatelessWidget {
  const SadSection({super.key});

  @override
  Widget build(BuildContext context) {
    final isWide = MediaQuery.sizeOf(context).width > 700;

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: isWide ? 60 : 20,
        vertical: 60,
      ),
      child: Column(
        children: [
          const SectionTitle(
            title: 'Please Never Stay Sad',
            subtitle: 'Your smile is my only prayer 🥺❤️',
            emoji: '🥺',
          ),

          const Gap(40),

          GlowCard(
            glowColor: AppColors.softPurple,
            borderRadius: 28,
            padding: const EdgeInsets.all(0),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(28),
              child: isWide
                  ? IntrinsicHeight(
                      child: Row(
                        children: [
                          Expanded(flex: 3, child: _buildSadText()),
                          Expanded(flex: 2, child: _buildSadImage()),
                        ],
                      ),
                    )
                  : Column(
                      children: [
                        _buildSadImage(height: 250),
                        _buildSadText(),
                      ],
                    ),
            ),
          ).animate().fadeIn(duration: 800.ms).slideY(begin: 0.2),
        ],
      ),
    );
  }

  Widget _buildSadImage({double? height}) {
    return Container(
      height: height,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            AppColors.softPurple.withOpacity(0.3),
            AppColors.deepPurple.withOpacity(0.2),
          ],
        ),
      ),
      child: Stack(
        fit: StackFit.expand,
        children: [
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('🥺', style: const TextStyle(fontSize: 70))
                    .animate(onPlay: (c) => c.repeat(reverse: true))
                    .scale(
                      begin: const Offset(1, 1),
                      end: const Offset(1.05, 1.05),
                      duration: 2000.ms,
                    ),
                const Gap(12),
                Text(
                  'Never Sad, Always Smiling',
                  style: GoogleFonts.dancingScript(
                    fontSize: 16,
                    color: AppColors.softPurple.withOpacity(0.8),
                    fontWeight: FontWeight.w700,
                  ),
                  textAlign: TextAlign.center,
                ),
                const Gap(4),
                Text(
                  '(Add photo: ${AppConstants.placeholderSad})',
                  style: GoogleFonts.lato(
                    fontSize: 10,
                    color: Colors.white.withOpacity(0.2),
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
          Image.asset(
            AppConstants.placeholderSad,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) {
              return const SizedBox.shrink();
            },
          ),
        ],
      ),
    );
  }

  Widget _buildSadText() {
    return Padding(
      padding: const EdgeInsets.all(32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ShaderMask(
            shaderCallback: (b) =>
                AppColors.purpleGradient.createShader(b),
            child: Text(
              'I Cannot See You Sad... 💜',
              style: GoogleFonts.dancingScript(
                fontSize: 26,
                color: Colors.white,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          const Gap(20),
          Text(
            AppStrings.sadContent,
            style: GoogleFonts.lato(
              fontSize: 16,
              color: Colors.white.withOpacity(0.85),
              height: 1.9,
              letterSpacing: 0.3,
            ),
          ),
        ],
      ),
    );
  }
}
