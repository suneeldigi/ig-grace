// lib/screens/love_timer/love_timer_section.dart
// Live love timer widget — shows time since first meeting

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gap/gap.dart';

import '../../core/constants/app_colors.dart';
import '../../core/utils/date_utils.dart';
import '../../widgets/glass_card.dart';
import '../../widgets/section_title.dart';

class LoveTimerSection extends StatefulWidget {
  const LoveTimerSection({super.key});

  @override
  State<LoveTimerSection> createState() => _LoveTimerSectionState();
}

class _LoveTimerSectionState extends State<LoveTimerSection> {
  late Timer _timer;
  late DateTime _now;

  @override
  void initState() {
    super.initState();
    _now = DateTime.now();
    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      if (mounted) setState(() => _now = DateTime.now());
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final duration = LoveDateUtils.calculateLoveDuration();
    final isWide = MediaQuery.sizeOf(context).width > 700;

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: isWide ? 60 : 20,
        vertical: 60,
      ),
      child: Column(
        children: [
          // Current date and time
          _buildDateTimeCard(isWide),

          const Gap(40),

          // "We first met" card
          _buildFirstMetCard(isWide),

          const Gap(50),

          // LIVE LOVE TIMER TITLE
          const SectionTitle(
            title: 'Live Love Timer',
            subtitle: 'Every second, my love for you grows',
            emoji: '⏳',
          ),

          const Gap(32),

          // Timer display
          _buildTimerDisplay(duration, isWide),
        ],
      ),
    );
  }

  Widget _buildDateTimeCard(bool isWide) {
    return GlassCard(
      padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 24),
      borderRadius: 28,
      borderColor: AppColors.roseGold.withOpacity(0.4),
      child: Column(
        children: [
          Text(
            LoveDateUtils.formatCurrentDate(_now),
            style: GoogleFonts.dancingScript(
              fontSize: isWide ? 28 : 22,
              color: AppColors.softPink,
              fontWeight: FontWeight.w700,
            ),
            textAlign: TextAlign.center,
          ),
          const Gap(8),
          ShaderMask(
            shaderCallback: (b) => AppColors.pinkGradient.createShader(b),
            child: Text(
              LoveDateUtils.formatCurrentTime(_now),
              style: GoogleFonts.lato(
                fontSize: isWide ? 42 : 32,
                color: Colors.white,
                fontWeight: FontWeight.w700,
                letterSpacing: 4,
                fontFeatures: const [FontFeature.tabularFigures()],
              ),
            ),
          ),
        ],
      ),
    ).animate().fadeIn(duration: 800.ms).slideY(begin: 0.3);
  }

  Widget _buildFirstMetCard(bool isWide) {
    return GlassCard(
      padding: const EdgeInsets.all(28),
      borderRadius: 24,
      borderColor: AppColors.hotPink.withOpacity(0.3),
      child: Column(
        children: [
          Text(
            '💕 We First Met',
            style: GoogleFonts.dancingScript(
              fontSize: 20,
              color: AppColors.softPink.withOpacity(0.8),
              fontWeight: FontWeight.w600,
            ),
          ),
          const Gap(8),
          Text(
            '27 June 2026',
            style: GoogleFonts.greatVibes(
              fontSize: isWide ? 44 : 34,
              color: AppColors.softPink,
              shadows: [
                Shadow(
                  color: AppColors.hotPink.withOpacity(0.5),
                  blurRadius: 15,
                ),
              ],
            ),
            textAlign: TextAlign.center,
          ),
          const Gap(4),
          Text(
            '4:00 PM',
            style: GoogleFonts.lato(
              fontSize: 20,
              color: AppColors.roseGold,
              fontWeight: FontWeight.w500,
              letterSpacing: 2,
            ),
          ),
          const Gap(12),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('✦', style: TextStyle(color: AppColors.roseGold)),
              const Gap(8),
              Text(
                'The day my life became beautiful',
                style: GoogleFonts.satisfy(
                  fontSize: 15,
                  color: Colors.white.withOpacity(0.6),
                ),
              ),
              const Gap(8),
              const Text('✦', style: TextStyle(color: AppColors.roseGold)),
            ],
          ),
        ],
      ),
    ).animate().fadeIn(delay: 200.ms, duration: 800.ms).slideY(begin: 0.3);
  }

  Widget _buildTimerDisplay(LoveDuration duration, bool isWide) {
    final units = [
      _TimerUnit(label: 'Years', value: duration.years, emoji: '🗓️'),
      _TimerUnit(label: 'Months', value: duration.months, emoji: '🌸'),
      _TimerUnit(label: 'Days', value: duration.days, emoji: '☀️'),
      _TimerUnit(label: 'Hours', value: duration.hours, emoji: '⏰'),
      _TimerUnit(label: 'Minutes', value: duration.minutes, emoji: '⌛'),
      _TimerUnit(label: 'Seconds', value: duration.seconds, emoji: '💓'),
      _TimerUnit(label: 'Milliseconds', value: duration.milliseconds, emoji: '✨'),
    ];

    return Wrap(
      alignment: WrapAlignment.center,
      spacing: 16,
      runSpacing: 16,
      children: units.asMap().entries.map((entry) {
        final i = entry.key;
        final unit = entry.value;
        return _buildTimerUnit(unit, i)
            .animate()
            .scale(
              delay: Duration(milliseconds: 100 * i),
              duration: 600.ms,
              curve: Curves.elasticOut,
            )
            .fadeIn(delay: Duration(milliseconds: 100 * i));
      }).toList(),
    );
  }

  Widget _buildTimerUnit(_TimerUnit unit, int index) {
    final isSeconds = unit.label == 'Seconds';
    final isMilliseconds = unit.label == 'Milliseconds';
    final digits = isMilliseconds ? 3 : 2;

    final digitStyle = GoogleFonts.lato(
      fontSize: isMilliseconds ? 32 : 40,
      color: isSeconds ? AppColors.hotPink : Colors.white,
      fontWeight: FontWeight.w700,
      letterSpacing: 2,
      fontFeatures: const [FontFeature.tabularFigures()],
      shadows: isSeconds
          ? [
              Shadow(
                color: AppColors.hotPink.withOpacity(0.6),
                blurRadius: 15,
              ),
            ]
          : null,
    );

    return GlowCard(
      glowColor: isSeconds ? AppColors.hotPink : AppColors.roseGold,
      borderRadius: 20,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      child: Column(
        children: [
          Text(unit.emoji, style: const TextStyle(fontSize: 22)),
          const Gap(6),
          // Runs its own fast timer in an isolated leaf widget so the
          // 30fps ms tick doesn't force the whole (glowing, blurred) section
          // to rebuild — that was causing app-wide jank.
          isMilliseconds
              ? _MillisecondsDigit(style: digitStyle)
              : AnimatedSwitcher(
                  duration: const Duration(milliseconds: 300),
                  transitionBuilder: (child, anim) => ScaleTransition(
                    scale: anim,
                    child: child,
                  ),
                  child: Text(
                    unit.value.toString().padLeft(digits, '0'),
                    key: ValueKey('${unit.label}_${unit.value}'),
                    style: digitStyle,
                  ),
                ),
          const Gap(4),
          Text(
            unit.label,
            style: GoogleFonts.lato(
              fontSize: 13,
              color: AppColors.softPink.withOpacity(0.7),
              letterSpacing: 1.5,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}

class _TimerUnit {
  final String label;
  final int value;
  final String emoji;
  const _TimerUnit({required this.label, required this.value, required this.emoji});
}

/// Ticks the millisecond digit on its own fast timer, isolated so only
/// this leaf widget rebuilds 30x/sec instead of the whole section.
class _MillisecondsDigit extends StatefulWidget {
  final TextStyle style;
  const _MillisecondsDigit({required this.style});

  @override
  State<_MillisecondsDigit> createState() => _MillisecondsDigitState();
}

class _MillisecondsDigitState extends State<_MillisecondsDigit> {
  late Timer _timer;
  int _ms = DateTime.now().millisecond;

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(milliseconds: 33), (_) {
      if (mounted) setState(() => _ms = DateTime.now().millisecond);
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Text(_ms.toString().padLeft(3, '0'), style: widget.style);
  }
}
