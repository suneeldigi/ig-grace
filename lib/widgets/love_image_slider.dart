// lib/widgets/love_image_slider.dart
// Auto-playing image carousel with glass border, glow and floating animation

import 'dart:async';
import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gap/gap.dart';

import '../core/constants/app_colors.dart';

class LoveImageSlider extends StatefulWidget {
  final List<String> imagePaths;
  final List<String>? captions;
  final double height;
  final Duration autoPlayInterval;

  const LoveImageSlider({
    super.key,
    required this.imagePaths,
    this.captions,
    this.height = 340,
    this.autoPlayInterval = const Duration(seconds: 4),
  });

  @override
  State<LoveImageSlider> createState() => _LoveImageSliderState();
}

class _LoveImageSliderState extends State<LoveImageSlider>
    with SingleTickerProviderStateMixin {
  late final PageController _pageController;
  late final AnimationController _floatController;
  Timer? _autoPlayTimer;
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(viewportFraction: 0.82);
    _floatController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 4),
    )..repeat();
    _startAutoPlay();
  }

  void _startAutoPlay() {
    _autoPlayTimer = Timer.periodic(widget.autoPlayInterval, (_) {
      if (!mounted) return;
      final next = (_currentPage + 1) % widget.imagePaths.length;
      _pageController.animateToPage(
        next,
        duration: const Duration(milliseconds: 700),
        curve: Curves.easeInOutCubic,
      );
    });
  }

  @override
  void dispose() {
    _autoPlayTimer?.cancel();
    _pageController.dispose();
    _floatController.dispose();
    super.dispose();
  }

  Color _glowColorFor(int index) {
    const colors = [
      AppColors.hotPink,
      AppColors.roseGold,
      AppColors.softPurple,
      AppColors.lilac,
    ];
    return colors[index % colors.length];
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: widget.height,
          child: PageView.builder(
            controller: _pageController,
            itemCount: widget.imagePaths.length,
            onPageChanged: (i) => setState(() => _currentPage = i),
            itemBuilder: (context, index) {
              final caption = (widget.captions != null &&
                      index < widget.captions!.length)
                  ? widget.captions![index]
                  : null;
              return AnimatedBuilder(
                animation: _floatController,
                builder: (_, child) {
                  final phase = index * 1.4;
                  final float = math.sin(
                        (_floatController.value * 2 * math.pi) + phase,
                      ) *
                      8;
                  return Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 12, vertical: 16),
                    child: Transform.translate(
                      offset: Offset(0, float),
                      child: child,
                    ),
                  );
                },
                child: _SliderCard(
                  path: widget.imagePaths[index],
                  caption: caption,
                  glowColor: _glowColorFor(index),
                ),
              );
            },
          ),
        ),
        const Gap(20),
        _buildDots(),
      ],
    );
  }

  Widget _buildDots() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(widget.imagePaths.length, (i) {
        final isActive = i == _currentPage;
        return AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          margin: const EdgeInsets.symmetric(horizontal: 4),
          width: isActive ? 24 : 8,
          height: 8,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4),
            gradient: isActive ? AppColors.pinkGradient : null,
            color: isActive ? null : AppColors.glassBorder,
          ),
        );
      }),
    );
  }
}

class _SliderCard extends StatelessWidget {
  final String path;
  final String? caption;
  final Color glowColor;

  const _SliderCard({
    required this.path,
    required this.caption,
    required this.glowColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(28),
        boxShadow: [
          BoxShadow(
            color: glowColor.withOpacity(0.45),
            blurRadius: 35,
            spreadRadius: 2,
          ),
          BoxShadow(
            color: Colors.black.withOpacity(0.35),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(28),
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(color: glowColor.withOpacity(0.5), width: 1.5),
          ),
          child: Stack(
            fit: StackFit.expand,
            children: [
              // Gradient placeholder background
              Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      glowColor.withOpacity(0.25),
                      AppColors.darkBg2,
                    ],
                  ),
                ),
              ),

              // Placeholder content (shown until real photo is added)
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('💕', style: const TextStyle(fontSize: 52))
                        .animate(onPlay: (c) => c.repeat(reverse: true))
                        .scale(
                          begin: const Offset(1, 1),
                          end: const Offset(1.08, 1.08),
                          duration: 1800.ms,
                        ),
                    const Gap(10),
                    Text(
                      'Add photo',
                      style: GoogleFonts.lato(
                        fontSize: 12,
                        color: Colors.white.withOpacity(0.35),
                      ),
                    ),
                    Text(
                      path.split('/').last,
                      style: GoogleFonts.lato(
                        fontSize: 10,
                        color: Colors.white.withOpacity(0.2),
                      ),
                    ),
                  ],
                ),
              ),

              // Real image (falls back silently if not yet added)
              Image.asset(
                path,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) =>
                    const SizedBox.shrink(),
              ),

              // Bottom glass caption
              if (caption != null)
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.bottomCenter,
                        end: Alignment.topCenter,
                        colors: [
                          Colors.black.withOpacity(0.65),
                          Colors.transparent,
                        ],
                      ),
                    ),
                    child: Text(
                      caption!,
                      style: GoogleFonts.dancingScript(
                        fontSize: 20,
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
