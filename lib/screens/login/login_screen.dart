// lib/screens/login/login_screen.dart
// Premium romantic login screen — dropdown date selectors for My Wifeu My Grace

import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gap/gap.dart';

import '../../core/constants/app_colors.dart';
import '../../core/constants/app_constants.dart';
import '../../widgets/animated_background.dart';
import '../../widgets/floating_hearts.dart';
import '../../widgets/glass_card.dart';
import '../../widgets/sparkle_widget.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen>
    with TickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();

  // Selected values
  String? _selectedUsername; // e.g. "27june"
  String? _selectedPassword; // e.g. "28jan"

  bool _isLoading = false;

  // June dates for username (1june..30june)
  static final List<Map<String, String>> _juneDates = List.generate(
    30,
    (i) => {
      'label': '${i + 1} June 🌸',
      'value': '${i + 1}june',
    },
  );

  // Jan dates for password (1jan..30jan)
  static final List<Map<String, String>> _janDates = List.generate(
    30,
    (i) => {
      'label': '${i + 1} Jan 🎂',
      'value': '${i + 1}jan',
    },
  );

  // Animation controllers
  late AnimationController _heartbeatController;
  late AnimationController _wrongShakeController;
  late AnimationController _successController;
  late Animation<double> _heartbeatScale;
  late Animation<double> _shakeOffset;

  // Popup state
  bool _showCorrectPopup = false;
  bool _showWrongPopup = false;

  @override
  void initState() {
    super.initState();

    // Heartbeat animation
    _heartbeatController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    )..repeat(reverse: true);
    _heartbeatScale = Tween<double>(begin: 1.0, end: 1.18).animate(
      CurvedAnimation(parent: _heartbeatController, curve: Curves.easeInOut),
    );

    // Wrong shake animation
    _wrongShakeController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    _shakeOffset = TweenSequence<double>([
      TweenSequenceItem(tween: Tween(begin: 0, end: -14), weight: 1),
      TweenSequenceItem(tween: Tween(begin: -14, end: 14), weight: 2),
      TweenSequenceItem(tween: Tween(begin: 14, end: -10), weight: 2),
      TweenSequenceItem(tween: Tween(begin: -10, end: 10), weight: 2),
      TweenSequenceItem(tween: Tween(begin: 10, end: 0), weight: 1),
    ]).animate(
      CurvedAnimation(parent: _wrongShakeController, curve: Curves.easeInOut),
    );

    // Success scale
    _successController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );
  }

  @override
  void dispose() {
    _heartbeatController.dispose();
    _wrongShakeController.dispose();
    _successController.dispose();
    super.dispose();
  }

  Future<void> _handleLogin() async {
    setState(() {
      _showCorrectPopup = false;
      _showWrongPopup = false;
    });

    // Must select both
    if (_selectedUsername == null || _selectedPassword == null) {
      _wrongShakeController.forward(from: 0);
      setState(() => _showWrongPopup = true);
      Future.delayed(const Duration(seconds: 3), () {
        if (mounted) setState(() => _showWrongPopup = false);
      });
      return;
    }

    final usernameOk = _selectedUsername == AppConstants.correctUsername;
    final passwordOk = _selectedPassword == AppConstants.correctPassword;

    if (usernameOk && passwordOk) {
      // ✅ Correct!
      setState(() {
        _isLoading = true;
        _showCorrectPopup = true;
      });

      await Future.delayed(const Duration(seconds: 3));
      if (mounted) {
        Navigator.of(context).pushReplacementNamed(AppConstants.homeRoute);
      }
    } else {
      // ❌ Wrong
      _wrongShakeController.forward(from: 0);
      setState(() => _showWrongPopup = true);
      Future.delayed(const Duration(seconds: 3), () {
        if (mounted) setState(() => _showWrongPopup = false);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    final isWide = size.width > 700;

    return Scaffold(
      body: AnimatedBackground(
        child: Stack(
          children: [
            // Floating hearts + sparkles
            const FloatingHearts(heartCount: 20),
            const SparkleWidget(sparkleCount: 12),

            // Main content
            Center(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(24),
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    maxWidth: isWide ? 500 : double.infinity,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // === BIG HEART ===
                      ScaleTransition(
                        scale: _heartbeatScale,
                        child: Text(
                          '❤️',
                          style: TextStyle(
                            fontSize: 70,
                            shadows: [
                              Shadow(
                                color: AppColors.hotPink.withOpacity(0.8),
                                blurRadius: 30,
                              ),
                            ],
                          ),
                        ),
                      ).animate().scale(
                            delay: 200.ms,
                            duration: 800.ms,
                            curve: Curves.elasticOut,
                          ),

                      const Gap(20),

                      // === APP TITLE ===
                      ShaderMask(
                        shaderCallback: (bounds) =>
                            AppColors.pinkGradient.createShader(bounds),
                        child: Text(
                          'My Wifeu ❤️ My Grace',
                          style: GoogleFonts.greatVibes(
                            fontSize: isWide ? 52 : 38,
                            color: Colors.white,
                            fontWeight: FontWeight.w400,
                            letterSpacing: 2,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      )
                          .animate()
                          .fadeIn(delay: 400.ms, duration: 800.ms)
                          .slideY(begin: -0.3),

                      const Gap(8),

                      Text(
                        'A website made only for my wife.',
                        style: GoogleFonts.dancingScript(
                          fontSize: 20,
                          color: AppColors.softPink.withOpacity(0.85),
                          fontWeight: FontWeight.w500,
                        ),
                        textAlign: TextAlign.center,
                      ).animate().fadeIn(delay: 600.ms),

                      const Gap(8),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: ['✦', '❤️', '✦']
                            .map((s) => Padding(
                                  padding:
                                      const EdgeInsets.symmetric(horizontal: 8),
                                  child: Text(
                                    s,
                                    style: TextStyle(
                                      fontSize: 16,
                                      color:
                                          AppColors.roseGold.withOpacity(0.8),
                                    ),
                                  ),
                                ))
                            .toList(),
                      ).animate().fadeIn(delay: 700.ms),

                      const Gap(32),

                      // === LOGIN CARD ===
                      AnimatedBuilder(
                        animation: _shakeOffset,
                        builder: (_, child) => Transform.translate(
                          offset: Offset(_shakeOffset.value, 0),
                          child: child,
                        ),
                        child: GlowCard(
                          borderRadius: 28,
                          padding: const EdgeInsets.all(32),
                          child: Form(
                            key: _formKey,
                            child: Column(
                              children: [
                                // Card heading
                                Text(
                                  'Enter Your Love Code 💕',
                                  style: GoogleFonts.dancingScript(
                                    fontSize: 24,
                                    color: AppColors.softPink,
                                    fontWeight: FontWeight.w700,
                                  ),
                                  textAlign: TextAlign.center,
                                ),

                                const Gap(24),

                                // === USERNAME DROPDOWN ===
                                _buildDropdownField(
                                  label: 'Username',
                                  hint: 'Select date...',
                                  icon: Icons.favorite_rounded,
                                  items: _juneDates,
                                  selectedValue: _selectedUsername,
                                  onChanged: (v) =>
                                      setState(() => _selectedUsername = v),
                                  glowColor: AppColors.hotPink,
                                ),

                                // Username hint label
                                Padding(
                                  padding:
                                      const EdgeInsets.only(left: 4, top: 7),
                                  child: Row(
                                    children: [
                                      const Text('💡 ',
                                          style: TextStyle(fontSize: 11)),
                                      Text(
                                        'We Meet Date',
                                        style: GoogleFonts.dancingScript(
                                          fontSize: 14,
                                          color: AppColors.roseGold
                                              .withOpacity(0.8),
                                          fontWeight: FontWeight.w700,
                                          letterSpacing: 0.5,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),

                                const Gap(16),

                                // === PASSWORD DROPDOWN ===
                                _buildDropdownField(
                                  label: 'Password',
                                  hint: 'Select date...',
                                  icon: Icons.lock_rounded,
                                  items: _janDates,
                                  selectedValue: _selectedPassword,
                                  onChanged: (v) =>
                                      setState(() => _selectedPassword = v),
                                  glowColor: AppColors.roseGold,
                                ),

                                // Password hint label
                                Padding(
                                  padding:
                                      const EdgeInsets.only(left: 4, top: 7),
                                  child: Row(
                                    children: [
                                      const Text('🎂 ',
                                          style: TextStyle(fontSize: 11)),
                                      Text(
                                        "My Wife's Birthday",
                                        style: GoogleFonts.dancingScript(
                                          fontSize: 14,
                                          color: AppColors.softPink
                                              .withOpacity(0.75),
                                          fontWeight: FontWeight.w700,
                                          letterSpacing: 0.5,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),

                                const Gap(26),

                                // === LOGIN BUTTON ===
                                _buildLoginButton(),

                                const Gap(18),

                                Text(
                                  'Only someone very special knows the dates 🌸',
                                  style: GoogleFonts.lato(
                                    fontSize: 12,
                                    color: Colors.white.withOpacity(0.4),
                                    fontStyle: FontStyle.italic,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                          ),
                        ).animate().slideY(
                              begin: 0.4,
                              delay: 800.ms,
                              duration: 900.ms,
                              curve: Curves.easeOut,
                            ),
                      ),

                      const Gap(24),

                      Text(
                        '"You are my today and all of my tomorrows."',
                        style: GoogleFonts.satisfy(
                          fontSize: 14,
                          color: AppColors.roseGold.withOpacity(0.55),
                        ),
                        textAlign: TextAlign.center,
                      ).animate().fadeIn(delay: 1200.ms),
                    ],
                  ),
                ),
              ),
            ),

            // === CORRECT POPUP ===
            if (_showCorrectPopup) _buildCorrectPopup(),

            // === WRONG POPUP ===
            if (_showWrongPopup) _buildWrongPopup(),
          ],
        ),
      ),
    );
  }

  // ─────────────────────────────────────────────
  // Glass Dropdown Field
  // ─────────────────────────────────────────────
  Widget _buildDropdownField({
    required String label,
    required String hint,
    required IconData icon,
    required List<Map<String, String>> items,
    required String? selectedValue,
    required ValueChanged<String?> onChanged,
    required Color glowColor,
  }) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: glowColor.withOpacity(0.15),
            blurRadius: 14,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
            decoration: BoxDecoration(
              color: AppColors.glassWhite,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: selectedValue != null
                    ? glowColor.withOpacity(0.5)
                    : AppColors.glassBorder,
                width: 1.2,
              ),
            ),
            child: DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                value: selectedValue,
                hint: Row(
                  children: [
                    Icon(icon, color: AppColors.softPink, size: 18),
                    const Gap(10),
                    Text(
                      hint,
                      style: GoogleFonts.lato(
                        color: Colors.white.withOpacity(0.4),
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
                isExpanded: true,
                dropdownColor: const Color(0xFF2A0035),
                iconSize: 22,
                icon: Icon(
                  Icons.keyboard_arrow_down_rounded,
                  color: glowColor.withOpacity(0.8),
                ),
                style: GoogleFonts.dancingScript(
                  fontSize: 18,
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                ),
                selectedItemBuilder: (ctx) => items.map((item) {
                  return Row(
                    children: [
                      Icon(icon, color: glowColor, size: 18),
                      const Gap(10),
                      Text(
                        item['label']!,
                        style: GoogleFonts.dancingScript(
                          fontSize: 18,
                          color: glowColor,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  );
                }).toList(),
                items: items.map((item) {
                  final isSelected = selectedValue == item['value'];
                  return DropdownMenuItem<String>(
                    value: item['value'],
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 6, horizontal: 4),
                      decoration: isSelected
                          ? BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: glowColor.withOpacity(0.15),
                            )
                          : null,
                      child: Text(
                        item['label']!,
                        style: GoogleFonts.dancingScript(
                          fontSize: 17,
                          color: isSelected ? glowColor : Colors.white70,
                          fontWeight: isSelected
                              ? FontWeight.w700
                              : FontWeight.w400,
                        ),
                      ),
                    ),
                  );
                }).toList(),
                onChanged: onChanged,
              ),
            ),
          ),
        ),
      ),
    );
  }

  // ─────────────────────────────────────────────
  // Login Button
  // ─────────────────────────────────────────────
  Widget _buildLoginButton() {
    return SizedBox(
      width: double.infinity,
      height: 56,
      child: DecoratedBox(
        decoration: BoxDecoration(
          gradient: AppColors.pinkGradient,
          borderRadius: BorderRadius.circular(28),
          boxShadow: [
            BoxShadow(
              color: AppColors.hotPink.withOpacity(0.5),
              blurRadius: 20,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: ElevatedButton(
          onPressed: _isLoading ? null : _handleLogin,
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.transparent,
            shadowColor: Colors.transparent,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(28),
            ),
          ),
          child: _isLoading
              ? const SizedBox(
                  width: 24,
                  height: 24,
                  child: CircularProgressIndicator(
                    color: Colors.white,
                    strokeWidth: 2,
                  ),
                )
              : Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Enter With Love',
                      style: GoogleFonts.dancingScript(
                        fontSize: 22,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                        letterSpacing: 1,
                      ),
                    ),
                    const Gap(8),
                    const Text('❤️', style: TextStyle(fontSize: 18)),
                  ],
                ),
        ),
      ),
    );
  }

  // ─────────────────────────────────────────────
  // ✅ CORRECT LOGIN POPUP
  // ─────────────────────────────────────────────
  Widget _buildCorrectPopup() {
    return Positioned(
      top: 30,
      left: 0,
      right: 0,
      child: Center(
        child: GlassCard(
          width: 340,
          padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 28),
          borderRadius: 28,
          borderColor: AppColors.hotPink.withOpacity(0.6),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Bouncing hearts row
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: ['❤️', '🥺', '❤️']
                    .asMap()
                    .entries
                    .map((e) => Padding(
                          padding:
                              const EdgeInsets.symmetric(horizontal: 4),
                          child: Text(
                            e.value,
                            style: const TextStyle(fontSize: 32),
                          )
                              .animate(
                                onPlay: (c) => c.repeat(reverse: true),
                                delay:
                                    Duration(milliseconds: e.key * 150),
                              )
                              .scale(
                                begin: const Offset(1, 1),
                                end: const Offset(1.25, 1.25),
                                duration: 500.ms,
                              ),
                        ))
                    .toList(),
              ),

              const Gap(14),

              ShaderMask(
                shaderCallback: (b) =>
                    AppColors.pinkGradient.createShader(b),
                child: Text(
                  'Oh apko yad h! 🥺',
                  style: GoogleFonts.dancingScript(
                    fontSize: 26,
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),

              const Gap(8),

              Text(
                'Itna pyar... Jaana\nLuv u Bche 💕',
                style: GoogleFonts.lato(
                  fontSize: 18,
                  color: AppColors.blushPink,
                  height: 1.6,
                  fontWeight: FontWeight.w500,
                ),
                textAlign: TextAlign.center,
              ),

              const Gap(10),

              Text(
                'Opening your special website... ✨',
                style: GoogleFonts.lato(
                  fontSize: 12,
                  color: Colors.white.withOpacity(0.5),
                  fontStyle: FontStyle.italic,
                ),
              ),
            ],
          ),
        )
            .animate()
            .scale(
              begin: const Offset(0.5, 0.5),
              duration: 400.ms,
              curve: Curves.elasticOut,
            )
            .fadeIn(duration: 300.ms),
      ),
    );
  }

  // ─────────────────────────────────────────────
  // ❌ WRONG LOGIN POPUP
  // ─────────────────────────────────────────────
  Widget _buildWrongPopup() {
    return Positioned(
      top: 30,
      left: 0,
      right: 0,
      child: Center(
        child: GlassCard(
          width: 320,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
          borderRadius: 28,
          borderColor: AppColors.crimson.withOpacity(0.5),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Crying emoji that shakes
              Text(
                '😭',
                style: const TextStyle(fontSize: 52),
              )
                  .animate(onPlay: (c) => c.repeat(reverse: true))
                  .moveX(
                    begin: -5,
                    end: 5,
                    duration: 200.ms,
                    curve: Curves.easeInOut,
                  ),

              const Gap(12),

              Text(
                'Jaan apko yad ni kya? 🥺',
                style: GoogleFonts.dancingScript(
                  fontSize: 22,
                  color: AppColors.softPink,
                  fontWeight: FontWeight.w700,
                ),
                textAlign: TextAlign.center,
              ),

              const Gap(8),

              Text(
                'Sahi date select kro...\nMain wait kar raha hun 💔',
                style: GoogleFonts.lato(
                  fontSize: 15,
                  color: Colors.white.withOpacity(0.75),
                  height: 1.6,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        )
            .animate()
            .slideY(
              begin: -0.8,
              duration: 400.ms,
              curve: Curves.easeOut,
            )
            .fadeIn(duration: 300.ms),
      ),
    );
  }
}
