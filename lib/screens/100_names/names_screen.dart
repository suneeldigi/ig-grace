// lib/screens/100_names/names_screen.dart
// 100 Nicknames section with Next Name button and animated display

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gap/gap.dart';

import '../../core/constants/app_colors.dart';
import '../../models/nickname_model.dart';
import '../../widgets/glass_card.dart';
import '../../widgets/section_title.dart';

class NamesSection extends StatefulWidget {
  const NamesSection({super.key});

  @override
  State<NamesSection> createState() => _NamesSectionState();
}

class _NamesSectionState extends State<NamesSection>
    with SingleTickerProviderStateMixin {
  int _nameIndex = 0;
  bool _animating = false;

  late AnimationController _controller;
  late Animation<double> _scaleAnim;
  late Animation<double> _opacityAnim;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );
    _scaleAnim = Tween<double>(begin: 0.8, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.elasticOut),
    );
    _opacityAnim = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeIn),
    );
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _nextName() async {
    if (_animating) return;
    setState(() => _animating = true);

    await _controller.reverse();

    setState(() {
      _nameIndex = (_nameIndex + 1) % NicknameData.names.length;
    });

    await _controller.forward();
    setState(() => _animating = false);
  }

  void _prevName() async {
    if (_animating) return;
    setState(() => _animating = true);

    await _controller.reverse();

    setState(() {
      _nameIndex =
          (_nameIndex - 1 + NicknameData.names.length) % NicknameData.names.length;
    });

    await _controller.forward();
    setState(() => _animating = false);
  }

  @override
  Widget build(BuildContext context) {
    final isWide = MediaQuery.sizeOf(context).width > 700;
    final currentName = NicknameData.names[_nameIndex];

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: isWide ? 60 : 20,
        vertical: 60,
      ),
      child: Column(
        children: [
          const SectionTitle(
            title: '100 Names For My Love',
            subtitle: 'Because one name is never enough for you',
            emoji: '💕',
          ),

          const Gap(40),

          // Counter
          Text(
            '${_nameIndex + 1} / ${NicknameData.names.length}',
            style: GoogleFonts.lato(
              fontSize: 14,
              color: AppColors.softPink.withOpacity(0.6),
              letterSpacing: 2,
            ),
          ),

          const Gap(20),

          // Main name display card
          GlowCard(
            glowColor: AppColors.hotPink,
            borderRadius: 32,
            padding: const EdgeInsets.all(0),
            child: Container(
              constraints: const BoxConstraints(minHeight: 260),
              padding: const EdgeInsets.all(40),
              child: AnimatedBuilder(
                animation: _controller,
                builder: (_, child) {
                  return Opacity(
                    opacity: _opacityAnim.value,
                    child: Transform.scale(
                      scale: _scaleAnim.value,
                      child: child,
                    ),
                  );
                },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Prefix line
                    Text(
                      NicknameData.prefix,
                      style: GoogleFonts.satisfy(
                        fontSize: isWide ? 22 : 17,
                        color: AppColors.softPink.withOpacity(0.7),
                        fontStyle: FontStyle.italic,
                      ),
                      textAlign: TextAlign.center,
                    ),

                    const Gap(16),

                    // Name
                    ShaderMask(
                      shaderCallback: (b) =>
                          AppColors.pinkGradient.createShader(b),
                      child: Text(
                        currentName,
                        style: GoogleFonts.greatVibes(
                          fontSize: isWide ? 56 : 40,
                          color: Colors.white,
                          fontWeight: FontWeight.w400,
                          letterSpacing: 1.5,
                          height: 1.2,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),

                    const Gap(20),

                    // Decorative row
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Text('✦', style: TextStyle(color: AppColors.roseGold)),
                        Gap(12),
                        Text('❤️', style: TextStyle(fontSize: 18)),
                        Gap(12),
                        Text('✦', style: TextStyle(color: AppColors.roseGold)),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),

          const Gap(32),

          // Navigation buttons
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Previous button
              _buildNavButton(
                label: 'Prev',
                icon: Icons.arrow_back_ios_rounded,
                onTap: _prevName,
                isPrimary: false,
              ),

              const Gap(20),

              // Next button (main CTA)
              _buildNavButton(
                label: 'Next Name',
                icon: Icons.favorite_rounded,
                onTap: _nextName,
                isPrimary: true,
              ),

              const Gap(20),

              // Random button
              _buildNavButton(
                label: 'Random',
                icon: Icons.shuffle_rounded,
                onTap: () {
                  setState(() => _nameIndex =
                      (NicknameData.names.length * 0.5).toInt() +
                          (_nameIndex * 7 + 13) %
                              (NicknameData.names.length ~/ 2));
                  _controller.forward(from: 0);
                },
                isPrimary: false,
              ),
            ],
          ),

          const Gap(40),

          // Mini grid of all names (scrollable preview)
          _buildNamesPreview(isWide),
        ],
      ),
    );
  }

  Widget _buildNavButton({
    required String label,
    required IconData icon,
    required VoidCallback onTap,
    required bool isPrimary,
  }) {
    if (isPrimary) {
      return DecoratedBox(
        decoration: BoxDecoration(
          gradient: AppColors.pinkGradient,
          borderRadius: BorderRadius.circular(28),
          boxShadow: [
            BoxShadow(
              color: AppColors.hotPink.withOpacity(0.4),
              blurRadius: 20,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: ElevatedButton.icon(
          onPressed: onTap,
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.transparent,
            shadowColor: Colors.transparent,
            padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 14),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(28),
            ),
          ),
          icon: Icon(icon, size: 18),
          label: Text(
            label,
            style: GoogleFonts.dancingScript(
              fontSize: 20,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      );
    }

    return OutlinedButton.icon(
      onPressed: onTap,
      style: OutlinedButton.styleFrom(
        foregroundColor: AppColors.softPink,
        side: BorderSide(color: AppColors.softPink.withOpacity(0.4)),
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
      ),
      icon: Icon(icon, size: 16),
      label: Text(
        label,
        style: GoogleFonts.lato(fontSize: 14, fontWeight: FontWeight.w600),
      ),
    );
  }

  Widget _buildNamesPreview(bool isWide) {
    return GlassCard(
      padding: const EdgeInsets.all(24),
      borderRadius: 24,
      child: Column(
        children: [
          Text(
            'All 100 Names of My Love 💕',
            style: GoogleFonts.dancingScript(
              fontSize: 22,
              color: AppColors.softPink,
              fontWeight: FontWeight.w700,
            ),
          ),
          const Gap(16),
          Wrap(
            alignment: WrapAlignment.center,
            spacing: 8,
            runSpacing: 8,
            children: NicknameData.names.asMap().entries.map((e) {
              final isActive = e.key == _nameIndex;
              return GestureDetector(
                onTap: () {
                  setState(() => _nameIndex = e.key);
                  _controller.forward(from: 0);
                },
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: isActive
                        ? AppColors.hotPink.withOpacity(0.3)
                        : AppColors.glassWhite,
                    border: Border.all(
                      color: isActive
                          ? AppColors.hotPink.withOpacity(0.6)
                          : AppColors.glassBorder,
                    ),
                    boxShadow: isActive
                        ? [
                            BoxShadow(
                              color: AppColors.hotPink.withOpacity(0.3),
                              blurRadius: 10,
                            )
                          ]
                        : null,
                  ),
                  child: Text(
                    e.value,
                    style: GoogleFonts.lato(
                      fontSize: 12,
                      color: isActive ? AppColors.softPink : Colors.white60,
                      fontWeight: isActive
                          ? FontWeight.w700
                          : FontWeight.w400,
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}
