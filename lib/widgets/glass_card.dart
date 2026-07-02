// lib/widgets/glass_card.dart
// Reusable glassmorphism card component

import 'dart:ui';
import 'package:flutter/material.dart';
import '../core/constants/app_colors.dart';

class GlassCard extends StatelessWidget {
  final Widget child;
  final double? width;
  final double? height;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final double borderRadius;
  final Color? backgroundColor;
  final Color? borderColor;
  final double blurSigma;
  final List<BoxShadow>? boxShadow;
  final VoidCallback? onTap;
  final Gradient? gradient;

  const GlassCard({
    super.key,
    required this.child,
    this.width,
    this.height,
    this.padding,
    this.margin,
    this.borderRadius = 24,
    this.backgroundColor,
    this.borderColor,
    this.blurSigma = 15,
    this.boxShadow,
    this.onTap,
    this.gradient,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: width,
        height: height,
        margin: margin,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(borderRadius),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: blurSigma, sigmaY: blurSigma),
            child: Container(
              width: width,
              height: height,
              padding:
                  padding ?? const EdgeInsets.all(24),
              decoration: BoxDecoration(
                gradient: gradient ??
                    LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        (backgroundColor ?? AppColors.glassWhite),
                        (backgroundColor ?? Colors.white).withOpacity(0.05),
                      ],
                    ),
                borderRadius: BorderRadius.circular(borderRadius),
                border: Border.all(
                  color: borderColor ?? AppColors.glassBorder,
                  width: 1.2,
                ),
                boxShadow: boxShadow ??
                    [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.3),
                        blurRadius: 20,
                        offset: const Offset(0, 8),
                      ),
                      BoxShadow(
                        color: AppColors.hotPink.withOpacity(0.08),
                        blurRadius: 30,
                        spreadRadius: 2,
                      ),
                    ],
              ),
              child: child,
            ),
          ),
        ),
      ),
    );
  }
}

/// A glowing bordered card for special sections
class GlowCard extends StatefulWidget {
  final Widget child;
  final Color glowColor;
  final double borderRadius;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;

  const GlowCard({
    super.key,
    required this.child,
    this.glowColor = AppColors.hotPink,
    this.borderRadius = 24,
    this.padding,
    this.margin,
  });

  @override
  State<GlowCard> createState() => _GlowCardState();
}

class _GlowCardState extends State<GlowCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _glowAnim;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    )..repeat(reverse: true);
    _glowAnim = Tween<double>(begin: 0.3, end: 0.8).animate(
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
      animation: _glowAnim,
      builder: (_, child) {
        return Container(
          margin: widget.margin,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(widget.borderRadius + 2),
            boxShadow: [
              BoxShadow(
                color: widget.glowColor.withOpacity(_glowAnim.value * 0.4),
                blurRadius: 30,
                spreadRadius: 4,
              ),
            ],
          ),
          child: child,
        );
      },
      child: GlassCard(
        padding: widget.padding,
        borderRadius: widget.borderRadius,
        borderColor: widget.glowColor.withOpacity(0.5),
        child: widget.child,
      ),
    );
  }
}
