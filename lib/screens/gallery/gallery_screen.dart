// lib/screens/gallery/gallery_screen.dart
// Premium gallery section with placeholder cards for images

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gap/gap.dart';

import '../../core/constants/app_colors.dart';
import '../../core/constants/app_constants.dart';
import '../../widgets/glass_card.dart';
import '../../widgets/section_title.dart';

class GallerySection extends StatelessWidget {
  const GallerySection({super.key});

  static final List<_GalleryItem> _items = [
    _GalleryItem(
      path: AppConstants.placeholderGallery1,
      label: 'Our First Memory ✨',
      emoji: '💕',
    ),
    _GalleryItem(
      path: AppConstants.placeholderGallery2,
      label: 'Beautiful Smile 😊',
      emoji: '🌸',
    ),
    _GalleryItem(
      path: AppConstants.placeholderGallery3,
      label: 'My Queen 👑',
      emoji: '👑',
    ),
    _GalleryItem(
      path: AppConstants.placeholderGallery4,
      label: 'Precious Moment 💖',
      emoji: '💖',
    ),
    _GalleryItem(
      path: AppConstants.placeholderGallery5,
      label: 'Forever & Always 🌙',
      emoji: '🌙',
    ),
    _GalleryItem(
      path: AppConstants.placeholderGallery6,
      label: 'My Everything 🌟',
      emoji: '🌟',
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
            title: 'Our Gallery',
            subtitle: 'Moments I will treasure forever',
            emoji: '📸',
          ),

          const Gap(16),

          GlassCard(
            padding: const EdgeInsets.all(20),
            borderRadius: 20,
            child: Text(
              '📸 Add your photos to the assets/images/ folder with the names below',
              style: GoogleFonts.lato(
                fontSize: 13,
                color: AppColors.softPink.withOpacity(0.7),
                fontStyle: FontStyle.italic,
              ),
              textAlign: TextAlign.center,
            ),
          ),

          const Gap(32),

          // Gallery grid
          LayoutBuilder(
            builder: (_, constraints) {
              final cols = constraints.maxWidth > 900
                  ? 3
                  : constraints.maxWidth > 600
                      ? 2
                      : 1;
              return GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: cols,
                  mainAxisSpacing: 20,
                  crossAxisSpacing: 20,
                  childAspectRatio: 1.2,
                ),
                itemCount: _items.length,
                itemBuilder: (_, i) {
                  return _buildGalleryCard(_items[i], i)
                      .animate()
                      .fadeIn(
                        delay: Duration(milliseconds: 100 * i),
                        duration: 600.ms,
                      )
                      .scale(
                        delay: Duration(milliseconds: 100 * i),
                        duration: 600.ms,
                        curve: Curves.easeOut,
                      );
                },
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildGalleryCard(_GalleryItem item, int index) {
    return GlowCard(
      glowColor: _getGlowColor(index),
      borderRadius: 20,
      padding: const EdgeInsets.all(0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Stack(
          fit: StackFit.expand,
          children: [
            // Background gradient (placeholder for image)
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    _getGlowColor(index).withOpacity(0.25),
                    AppColors.darkBg2,
                  ],
                ),
              ),
            ),

            // Center emoji placeholder
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(item.emoji,
                      style: const TextStyle(fontSize: 56))
                      .animate(onPlay: (c) => c.repeat(reverse: true))
                      .scale(
                        begin: const Offset(1, 1),
                        end: const Offset(1.08, 1.08),
                        duration: 2000.ms,
                      ),
                  const Gap(10),
                  Text(
                    'Add Photo',
                    style: GoogleFonts.lato(
                      fontSize: 12,
                      color: Colors.white.withOpacity(0.3),
                    ),
                  ),
                  Text(
                    item.path.split('/').last,
                    style: GoogleFonts.lato(
                      fontSize: 10,
                      color: Colors.white.withOpacity(0.2),
                    ),
                  ),
                ],
              ),
            ),

            // Actual Image Layer (loads image if present, transparent fallback on error)
            Image.asset(
              item.path,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return const SizedBox.shrink();
              },
            ),

            // Bottom label overlay
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                    colors: [
                      Colors.black.withOpacity(0.7),
                      Colors.transparent,
                    ],
                  ),
                ),
                child: Text(
                  item.label,
                  style: GoogleFonts.dancingScript(
                    fontSize: 18,
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Color _getGlowColor(int index) {
    final colors = [
      AppColors.hotPink,
      AppColors.roseGold,
      AppColors.softPurple,
      AppColors.lilac,
      AppColors.crimson,
      AppColors.mediumPurple,
    ];
    return colors[index % colors.length];
  }
}

class _GalleryItem {
  final String path;
  final String label;
  final String emoji;
  const _GalleryItem({
    required this.path,
    required this.label,
    required this.emoji,
  });
}
