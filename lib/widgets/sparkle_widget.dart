// lib/widgets/sparkle_widget.dart
// Sparkle/star decorative animations

import 'dart:math' as math;
import 'package:flutter/material.dart';
import '../core/constants/app_colors.dart';

/// Decorative sparkle stars that appear randomly
class SparkleWidget extends StatefulWidget {
  final int sparkleCount;
  const SparkleWidget({super.key, this.sparkleCount = 8});

  @override
  State<SparkleWidget> createState() => _SparkleWidgetState();
}

class _SparkleWidgetState extends State<SparkleWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  final _random = math.Random();
  late List<_SparkleData> _sparkles;

  @override
  void initState() {
    super.initState();
    _sparkles = List.generate(
      widget.sparkleCount,
      (i) => _SparkleData(
        x: _random.nextDouble(),
        y: _random.nextDouble(),
        size: _random.nextDouble() * 12 + 6,
        phase: _random.nextDouble() * math.pi * 2,
        speed: _random.nextDouble() * 0.5 + 0.5,
      ),
    );

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 4),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);

    return IgnorePointer(
      child: AnimatedBuilder(
        animation: _controller,
        builder: (_, __) {
          return Stack(
            children: _sparkles.map((s) {
              final t = (_controller.value * s.speed + s.phase) % 1.0;
              final opacity = (math.sin(t * math.pi * 2) + 1) / 2;
              final scale = 0.5 + opacity * 0.5;

              return Positioned(
                left: s.x * size.width - s.size / 2,
                top: s.y * size.height - s.size / 2,
                child: Opacity(
                  opacity: opacity,
                  child: Transform.scale(
                    scale: scale,
                    child: Text(
                      '✦',
                      style: TextStyle(
                        fontSize: s.size,
                        color: AppColors.roseGold,
                        shadows: [
                          Shadow(
                            color: AppColors.softPink.withOpacity(opacity),
                            blurRadius: 8,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            }).toList(),
          );
        },
      ),
    );
  }
}

class _SparkleData {
  final double x, y, size, phase, speed;
  const _SparkleData({
    required this.x,
    required this.y,
    required this.size,
    required this.phase,
    required this.speed,
  });
}

/// A single animated sparkle star for inline use
class InlineSparkle extends StatefulWidget {
  final double size;
  final Color color;

  const InlineSparkle({
    super.key,
    this.size = 16,
    this.color = AppColors.roseGold,
  });

  @override
  State<InlineSparkle> createState() => _InlineSparkleState();
}

class _InlineSparkleState extends State<InlineSparkle>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    )..repeat(reverse: true);
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
        return Transform.rotate(
          angle: _controller.value * math.pi * 2,
          child: Text(
            '✦',
            style: TextStyle(
              fontSize: widget.size,
              color: widget.color.withOpacity(0.6 + _controller.value * 0.4),
            ),
          ),
        );
      },
    );
  }
}

/// Shimmer text decoration
class ShimmerText extends StatefulWidget {
  final String text;
  final TextStyle? style;

  const ShimmerText({super.key, required this.text, this.style});

  @override
  State<ShimmerText> createState() => _ShimmerTextState();
}

class _ShimmerTextState extends State<ShimmerText>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    )..repeat();
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
        return ShaderMask(
          shaderCallback: (bounds) {
            return LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              colors: const [
                AppColors.softPink,
                Colors.white,
                AppColors.roseGold,
                AppColors.softPink,
              ],
              stops: [
                _controller.value - 0.3,
                _controller.value,
                _controller.value + 0.1,
                _controller.value + 0.3,
              ].map((s) => s.clamp(0.0, 1.0)).toList(),
            ).createShader(bounds);
          },
          child: Text(
            widget.text,
            style: widget.style?.copyWith(color: Colors.white) ??
                const TextStyle(color: Colors.white),
          ),
        );
      },
    );
  }
}
