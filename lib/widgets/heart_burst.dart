// lib/widgets/heart_burst.dart
// One-shot radial heart explosion, triggered on demand via HeartBurstState.play()

import 'dart:math' as math;
import 'package:flutter/material.dart';
import '../core/constants/app_colors.dart';

class HeartBurst extends StatefulWidget {
  const HeartBurst({super.key});

  @override
  State<HeartBurst> createState() => HeartBurstState();
}

class HeartBurstState extends State<HeartBurst>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  List<_BurstHeart> _hearts = [];
  final _random = math.Random();

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1400),
    );
  }

  /// Triggers a fresh burst of hearts from the center of the screen.
  void play() {
    setState(() {
      _hearts = List.generate(28, (_) => _BurstHeart(_random));
    });
    _controller.forward(from: 0);
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
          if (_hearts.isEmpty) return const SizedBox.shrink();
          final t = Curves.easeOut.transform(_controller.value);
          final fade = (1 - _controller.value).clamp(0.0, 1.0);

          return Stack(
            children: _hearts.map((h) {
              final dist = h.distance * t;
              final dx = math.cos(h.angle) * dist;
              final dy = math.sin(h.angle) * dist - (_controller.value * 70);
              final scale = 0.5 + t * h.scaleFactor;

              return Positioned(
                left: size.width / 2 + dx - h.size / 2,
                top: size.height / 2 + dy - h.size / 2,
                child: Opacity(
                  opacity: fade,
                  child: Transform.scale(
                    scale: scale,
                    child: Text(
                      '❤️',
                      style: TextStyle(
                        fontSize: h.size,
                        color: h.color,
                        shadows: [
                          Shadow(
                            color: h.color.withOpacity(0.7),
                            blurRadius: 12,
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

class _BurstHeart {
  final double angle;
  final double distance;
  final double size;
  final double scaleFactor;
  final Color color;

  _BurstHeart(math.Random random)
      : angle = random.nextDouble() * 2 * math.pi,
        distance = random.nextDouble() * 220 + 80,
        size = random.nextDouble() * 20 + 16,
        scaleFactor = random.nextDouble() * 0.8 + 0.6,
        color = [
          AppColors.hotPink,
          AppColors.softPink,
          AppColors.roseGold,
          AppColors.crimson,
          Colors.white,
        ][random.nextInt(5)];
}
