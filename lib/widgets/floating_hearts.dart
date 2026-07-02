// lib/widgets/floating_hearts.dart
// Floating heart rain animation widget

import 'dart:math' as math;
import 'package:flutter/material.dart';
import '../core/constants/app_colors.dart';

class FloatingHearts extends StatefulWidget {
  final int heartCount;
  final bool enabled;

  const FloatingHearts({
    super.key,
    this.heartCount = 15,
    this.enabled = true,
  });

  @override
  State<FloatingHearts> createState() => _FloatingHeartsState();
}

class _FloatingHeartsState extends State<FloatingHearts>
    with TickerProviderStateMixin {
  final List<_HeartData> _hearts = [];
  final _random = math.Random();

  @override
  void initState() {
    super.initState();
    if (widget.enabled) {
      _spawnHearts();
    }
  }

  void _spawnHearts() {
    for (int i = 0; i < widget.heartCount; i++) {
      Future.delayed(Duration(milliseconds: i * 400), () {
        if (mounted) {
          _addHeart();
        }
      });
    }
  }

  void _addHeart() {
    final controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 3000 + _random.nextInt(3000)),
    );

    final xPos = _random.nextDouble();
    final size = _random.nextDouble() * 20 + 10;
    final wobble = (_random.nextDouble() - 0.5) * 40;

    final heart = _HeartData(
      controller: controller,
      xPos: xPos,
      size: size,
      wobble: wobble,
      color: _getRandomHeartColor(),
    );

    setState(() => _hearts.add(heart));

    controller.forward().then((_) {
      if (mounted) {
        setState(() => _hearts.remove(heart));
        controller.dispose();
        // Respawn
        Future.delayed(Duration(milliseconds: _random.nextInt(2000)), () {
          if (mounted) _addHeart();
        });
      }
    });
  }

  Color _getRandomHeartColor() {
    final colors = [
      AppColors.hotPink,
      AppColors.softPink,
      AppColors.roseGold,
      AppColors.crimson,
      Colors.white.withOpacity(0.8),
    ];
    return colors[_random.nextInt(colors.length)];
  }

  @override
  void dispose() {
    for (final h in _hearts) {
      h.controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      child: Stack(
        children: _hearts.map((heart) {
          return _FloatingHeart(heart: heart);
        }).toList(),
      ),
    );
  }
}

class _HeartData {
  final AnimationController controller;
  final double xPos;
  final double size;
  final double wobble;
  final Color color;

  _HeartData({
    required this.controller,
    required this.xPos,
    required this.size,
    required this.wobble,
    required this.color,
  });
}

class _FloatingHeart extends StatelessWidget {
  final _HeartData heart;

  const _FloatingHeart({required this.heart});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);

    return AnimatedBuilder(
      animation: heart.controller,
      builder: (_, __) {
        final t = heart.controller.value;
        final x = heart.xPos * size.width +
            math.sin(t * 2 * math.pi) * heart.wobble;
        final y = size.height - (t * (size.height + 60));
        final opacity = t < 0.2
            ? t / 0.2
            : t > 0.8
                ? (1 - t) / 0.2
                : 1.0;

        return Positioned(
          left: x,
          top: y,
          child: Opacity(
            opacity: opacity.clamp(0.0, 1.0),
            child: Text(
              '❤️',
              style: TextStyle(
                fontSize: heart.size,
                color: heart.color,
                shadows: [
                  Shadow(
                    color: heart.color.withOpacity(0.6),
                    blurRadius: 10,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

/// A single pulsating heart widget for decorative use
class PulsingHeart extends StatefulWidget {
  final double size;
  final Color color;

  const PulsingHeart({
    super.key,
    this.size = 40,
    this.color = AppColors.hotPink,
  });

  @override
  State<PulsingHeart> createState() => _PulsingHeartState();
}

class _PulsingHeartState extends State<PulsingHeart>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scale;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    )..repeat(reverse: true);
    _scale = Tween<double>(begin: 1.0, end: 1.25).animate(
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
    return ScaleTransition(
      scale: _scale,
      child: Text(
        '❤️',
        style: TextStyle(
          fontSize: widget.size,
          shadows: [
            Shadow(
              color: widget.color.withOpacity(0.6),
              blurRadius: 15,
            ),
          ],
        ),
      ),
    );
  }
}
