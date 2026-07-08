// lib/widgets/glowing_heart.dart
// A big glowing, pulsating heart with a soft light-ray backdrop

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../core/constants/app_colors.dart';

class GlowingHeart extends StatefulWidget {
  final double size;
  final Color color;

  const GlowingHeart({
    super.key,
    this.size = 120,
    this.color = AppColors.hotPink,
  });

  @override
  State<GlowingHeart> createState() => _GlowingHeartState();
}

class _GlowingHeartState extends State<GlowingHeart>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scale;
  late Animation<double> _glow;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    )..repeat(reverse: true);

    _scale = Tween<double>(begin: 1.0, end: 1.12).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
    _glow = Tween<double>(begin: 0.4, end: 0.9).animate(
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
      animation: _controller,
      builder: (_, __) {
        return SizedBox(
          width: widget.size * 1.8,
          height: widget.size * 1.8,
          child: Stack(
            alignment: Alignment.center,
            children: [
              // Soft glowing light backdrop
              Container(
                width: widget.size * (1.5 + _glow.value * 0.3),
                height: widget.size * (1.5 + _glow.value * 0.3),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: RadialGradient(
                    colors: [
                      widget.color.withOpacity(_glow.value * 0.35),
                      widget.color.withOpacity(0.0),
                    ],
                  ),
                ),
              ),

              // The heart
              ScaleTransition(
                scale: _scale,
                child: Text(
                  '❤️',
                  style: TextStyle(
                    fontSize: widget.size,
                    shadows: [
                      Shadow(
                        color: widget.color.withOpacity(_glow.value),
                        blurRadius: 40,
                      ),
                      Shadow(
                        color: AppColors.roseGold.withOpacity(_glow.value * 0.6),
                        blurRadius: 60,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    ).animate().scale(
          delay: 150.ms,
          duration: 900.ms,
          curve: Curves.elasticOut,
          begin: const Offset(0.3, 0.3),
        );
  }
}
