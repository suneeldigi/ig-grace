// lib/widgets/animated_background.dart
// Premium animated particle background with glow effects

import 'dart:math' as math;
import 'package:flutter/material.dart';
import '../core/constants/app_colors.dart';

class AnimatedBackground extends StatefulWidget {
  final Widget child;
  const AnimatedBackground({super.key, required this.child});

  @override
  State<AnimatedBackground> createState() => _AnimatedBackgroundState();
}

class _AnimatedBackgroundState extends State<AnimatedBackground>
    with TickerProviderStateMixin {
  late List<_Particle> _particles;
  late AnimationController _controller;
  final _random = math.Random();

  @override
  void initState() {
    super.initState();
    _particles = List.generate(60, (_) => _Particle(_random));
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 20),
    )..repeat();
    _controller.addListener(() {
      setState(() {
        for (var p in _particles) {
          p.update();
        }
      });
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Base gradient
        Container(
          decoration: const BoxDecoration(
            gradient: AppColors.backgroundGradient,
          ),
        ),

        // Animated particles
        CustomPaint(
          painter: _ParticlePainter(_particles),
          child: const SizedBox.expand(),
        ),

        // Glow orbs
        _buildGlowOrb(0.1, 0.2, 200, AppColors.hotPink.withOpacity(0.08)),
        _buildGlowOrb(0.8, 0.6, 300, AppColors.mediumPurple.withOpacity(0.06)),
        _buildGlowOrb(0.5, 0.9, 250, AppColors.roseGold.withOpacity(0.07)),
        _buildGlowOrb(0.9, 0.1, 180, AppColors.softPurple.withOpacity(0.05)),

        // Child content
        widget.child,
      ],
    );
  }

  Widget _buildGlowOrb(double x, double y, double size, Color color) {
    return Positioned(
      left: MediaQuery.sizeOf(context).width * x - size / 2,
      top: MediaQuery.sizeOf(context).height * y - size / 2,
      child: AnimatedBuilder(
        animation: _controller,
        builder: (_, __) {
          final pulse = (math.sin(_controller.value * 2 * math.pi) + 1) / 2;
          return Container(
            width: size + pulse * 30,
            height: size + pulse * 30,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: color,
              boxShadow: [
                BoxShadow(
                  color: color.withOpacity(0.5),
                  blurRadius: 80 + pulse * 20,
                  spreadRadius: 10,
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class _Particle {
  double x, y;
  double vx, vy;
  double size;
  double opacity;
  double life;
  bool isHeart;
  final math.Random _random;

  _Particle(this._random)
      : x = _random.nextDouble(),
        y = _random.nextDouble(),
        vx = (_random.nextDouble() - 0.5) * 0.001,
        vy = -_random.nextDouble() * 0.001 - 0.0003,
        size = _random.nextDouble() * 4 + 1,
        opacity = _random.nextDouble() * 0.6 + 0.2,
        life = _random.nextDouble(),
        isHeart = _random.nextDouble() > 0.7;

  void update() {
    x += vx;
    y += vy;
    life += 0.002;
    if (life > 1 || x < 0 || x > 1 || y < 0) {
      _reset();
    }
  }

  void _reset() {
    x = _random.nextDouble();
    y = 1.05;
    vx = (_random.nextDouble() - 0.5) * 0.001;
    vy = -_random.nextDouble() * 0.001 - 0.0003;
    size = _random.nextDouble() * 4 + 1;
    opacity = _random.nextDouble() * 0.6 + 0.2;
    life = 0;
    isHeart = _random.nextDouble() > 0.7;
  }
}

class _ParticlePainter extends CustomPainter {
  final List<_Particle> particles;

  _ParticlePainter(this.particles);

  @override
  void paint(Canvas canvas, Size size) {
    for (final p in particles) {
      final paint = Paint()
        ..color = _getColor(p).withOpacity(p.opacity * (1 - p.life))
        ..style = PaintingStyle.fill;

      if (p.isHeart) {
        _drawHeart(canvas, Offset(p.x * size.width, p.y * size.height),
            p.size * 1.5, paint);
      } else {
        canvas.drawCircle(
          Offset(p.x * size.width, p.y * size.height),
          p.size,
          paint,
        );
      }
    }
  }

  Color _getColor(_Particle p) {
    final colors = [
      AppColors.hotPink,
      AppColors.softPink,
      AppColors.roseGold,
      AppColors.softPurple,
      AppColors.lilac,
      Colors.white,
    ];
    return colors[(p.x * 100).toInt() % colors.length];
  }

  void _drawHeart(Canvas canvas, Offset center, double size, Paint paint) {
    final path = Path();
    final x = center.dx;
    final y = center.dy;
    final s = size;

    path.moveTo(x, y + s * 0.3);
    path.cubicTo(x, y, x - s, y, x - s, y + s * 0.4);
    path.cubicTo(x - s, y + s * 0.8, x, y + s * 1.1, x, y + s * 1.1);
    path.cubicTo(x, y + s * 1.1, x + s, y + s * 0.8, x + s, y + s * 0.4);
    path.cubicTo(x + s, y, x, y, x, y + s * 0.3);
    path.close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
