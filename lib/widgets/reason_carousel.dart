// lib/widgets/reason_carousel.dart
// Auto-cycling "reason" display — shows one item at a time, looping forever

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../core/constants/app_colors.dart';
import 'glass_card.dart';

class ReasonCarousel extends StatefulWidget {
  final List<String> reasons;
  final Duration interval;

  const ReasonCarousel({
    super.key,
    required this.reasons,
    this.interval = const Duration(seconds: 3),
  });

  @override
  State<ReasonCarousel> createState() => _ReasonCarouselState();
}

class _ReasonCarouselState extends State<ReasonCarousel> {
  Timer? _timer;
  int _index = 0;

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(widget.interval, (_) {
      if (!mounted) return;
      setState(() => _index = (_index + 1) % widget.reasons.length);
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isWide = MediaQuery.sizeOf(context).width > 700;

    return GlowCard(
      glowColor: AppColors.roseGold,
      borderRadius: 28,
      padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 24),
      child: SizedBox(
        height: isWide ? 70 : 90,
        child: AnimatedSwitcher(
          duration: const Duration(milliseconds: 500),
          transitionBuilder: (child, animation) {
            final slide = Tween<Offset>(
              begin: const Offset(0, 0.4),
              end: Offset.zero,
            ).animate(CurvedAnimation(parent: animation, curve: Curves.easeOut));
            return FadeTransition(
              opacity: animation,
              child: SlideTransition(position: slide, child: child),
            );
          },
          child: Center(
            key: ValueKey<int>(_index),
            child: Text(
              widget.reasons[_index],
              style: GoogleFonts.dancingScript(
                fontSize: isWide ? 32 : 24,
                color: AppColors.softPink,
                fontWeight: FontWeight.w700,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ),
    );
  }
}
