// lib/screens/memories/memories_screen.dart
// Memories section with placeholder cards for personal moments

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gap/gap.dart';

import '../../core/constants/app_colors.dart';
import '../../core/constants/app_constants.dart';
import '../../widgets/glass_card.dart';
import '../../widgets/section_title.dart';

class MemoriesSection extends StatelessWidget {
  const MemoriesSection({super.key});

  static const List<_MemoryItem> _memories = [
    _MemoryItem(
      path: AppConstants.placeholderMemory1,
      title: 'First Video Call 📹',
      date: '27 June 2026',
      description:
          'The day I saw you for the first time. You were in a saree and I completely lost my heart.',
      emoji: '💫',
      color: AppColors.hotPink,
    ),
    _MemoryItem(
      path: AppConstants.placeholderMemory2,
      title: 'Special Moment 💕',
      date: 'Coming soon...',
      description:
          'Every moment with you is a memory I will treasure for the rest of my life.',
      emoji: '🌸',
      color: AppColors.roseGold,
    ),
    _MemoryItem(
      path: AppConstants.placeholderMemory3,
      title: 'Our Story 🌙',
      date: 'Always...',
      description:
          'Our story is my favorite love story. Written by God, gifted to me.',
      emoji: '🌙',
      color: AppColors.softPurple,
    ),
    _MemoryItem(
      path: AppConstants.placeholderMemory4,
      title: 'Forever Mine 👑',
      date: 'Every day',
      description:
          'You are mine. I am yours. That is my greatest joy and my biggest blessing.',
      emoji: '👑',
      color: AppColors.lilac,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final isWide = MediaQuery.sizeOf(context).width > 700;

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: isWide ? 60 : 20,
        vertical: 60,
      ),
      child: Column(
        children: [
          const SectionTitle(
            title: 'Memories',
            subtitle: 'Every second with you is a memory',
            emoji: '🎞️',
          ),

          const Gap(40),

          LayoutBuilder(
            builder: (_, constraints) {
              final cols = constraints.maxWidth > 800 ? 2 : 1;
              return GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: cols,
                  mainAxisSpacing: 24,
                  crossAxisSpacing: 24,
                  childAspectRatio: cols == 2 ? 1.3 : 1.6,
                ),
                itemCount: _memories.length,
                itemBuilder: (_, i) {
                  return _buildMemoryCard(_memories[i])
                      .animate()
                      .fadeIn(
                        delay: Duration(milliseconds: 150 * i),
                        duration: 700.ms,
                      )
                      .slideY(begin: 0.2, curve: Curves.easeOut);
                },
              );
            },
          ),

          const Gap(40),

          // "More memories coming" note
          GlassCard(
            padding: const EdgeInsets.all(24),
            borderRadius: 20,
            child: Column(
              children: [
                const Text('📸', style: TextStyle(fontSize: 40)),
                const Gap(12),
                Text(
                  'More memories being created every day...',
                  style: GoogleFonts.dancingScript(
                    fontSize: 22,
                    color: AppColors.softPink,
                    fontWeight: FontWeight.w700,
                  ),
                  textAlign: TextAlign.center,
                ),
                const Gap(8),
                Text(
                  'Add your photos to assets/images/ folder',
                  style: GoogleFonts.lato(
                    fontSize: 13,
                    color: Colors.white.withOpacity(0.4),
                    fontStyle: FontStyle.italic,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ).animate().fadeIn(delay: 600.ms),
        ],
      ),
    );
  }

  Widget _buildMemoryCard(_MemoryItem memory) {
    return GlowCard(
      glowColor: memory.color,
      borderRadius: 24,
      padding: const EdgeInsets.all(0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(24),
        child: Stack(
          fit: StackFit.expand,
          children: [
            // Gradient background
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    memory.color.withOpacity(0.2),
                    AppColors.darkBg2,
                    memory.color.withOpacity(0.05),
                  ],
                ),
              ),
            ),

            // Content
            Padding(
              padding: const EdgeInsets.all(28),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        memory.emoji,
                        style: const TextStyle(fontSize: 36),
                      ),
                      const Gap(12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              memory.title,
                              style: GoogleFonts.dancingScript(
                                fontSize: 22,
                                color: Colors.white,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            Text(
                              memory.date,
                              style: GoogleFonts.lato(
                                fontSize: 12,
                                color: memory.color.withOpacity(0.8),
                                fontWeight: FontWeight.w600,
                                letterSpacing: 0.5,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),

                  const Spacer(),

                  // Photo display or placeholder
                  Center(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Container(
                        height: 110,
                        width: double.infinity,
                        color: memory.color.withOpacity(0.05),
                        child: Image.asset(
                          memory.path,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return Center(
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 16, vertical: 8),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12),
                                  color: memory.color.withOpacity(0.15),
                                  border: Border.all(
                                    color: memory.color.withOpacity(0.3),
                                  ),
                                ),
                                child: Text(
                                  memory.path.split('/').last,
                                  style: GoogleFonts.lato(
                                    fontSize: 11,
                                    color: memory.color.withOpacity(0.7),
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  ),

                  const Gap(12),

                  Text(
                    memory.description,
                    style: GoogleFonts.lato(
                      fontSize: 14,
                      color: Colors.white.withOpacity(0.75),
                      height: 1.6,
                      fontStyle: FontStyle.italic,
                    ),
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _MemoryItem {
  final String path;
  final String title;
  final String date;
  final String description;
  final String emoji;
  final Color color;

  const _MemoryItem({
    required this.path,
    required this.title,
    required this.date,
    required this.description,
    required this.emoji,
    required this.color,
  });
}
