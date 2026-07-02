// lib/core/constants/app_constants.dart
// App-wide constants for My Wifeu My Grace

class AppConstants {
  AppConstants._();

  // === CREDENTIALS ===
  static const String correctUsername = '27june';
  static const String correctPassword = '28jan';

  // === APP INFO ===
  static const String appName = 'My Wifeu ❤️ My Grace';
  static const String appTagline = 'A website made only for my wife.';
  static const String madeBy = 'Hubby Grey ❤️';
  static const String madeFor = 'My Wifeu ❤️ My Grace';

  // === LOVE STORY DATES ===
  static const int meetYear = 2026;
  static const int meetMonth = 6; // June
  static const int meetDay = 27;
  static const int meetHour = 16; // 4:00 PM
  static const int meetMinute = 0;
  static const int meetSecond = 0;

  // === ASSET PATHS ===
  static const String imagesPath = 'assets/images/';
  static const String iconsPath = 'assets/icons/';

  // === PLACEHOLDER IMAGES (to be replaced) ===
  static const String placeholderEyes = 'assets/images/placeholder_eyes.jpeg';
  static const String placeholderNose = 'assets/images/placeholder_nose.jpeg';
  static const String placeholderLips = 'assets/images/placeholder_lips.jpeg';
  static const String placeholderForehead = 'assets/images/placeholder_forehead.jpeg';
  static const String placeholderAngry = 'assets/images/placeholder_angry.png';
  static const String placeholderSad = 'assets/images/placeholder_sad.png';
  static const String placeholderGallery1 = 'assets/images/gallery_1.jpeg';
  static const String placeholderGallery2 = 'assets/images/gallery_2.jpeg';
  static const String placeholderGallery3 = 'assets/images/gallery_3.jpeg';
  static const String placeholderGallery4 = 'assets/images/gallery_4.jpeg';
  static const String placeholderGallery5 = 'assets/images/gallery_1.jpeg';
  static const String placeholderGallery6 = 'assets/images/gallery_3.jpeg';
  static const String placeholderMemory1 = 'assets/images/memory_1.jpeg';
  static const String placeholderMemory2 = 'assets/images/gallery_1.jpeg';
  static const String placeholderMemory3 = 'assets/images/gallery_1.jpeg';
  static const String placeholderMemory4 = 'assets/images/gallery_1.jpeg';

  // === ROUTES ===
  static const String loginRoute = '/';
  static const String homeRoute = '/home';

  // === ANIMATION DURATIONS ===
  static const Duration fastAnimation = Duration(milliseconds: 300);
  static const Duration normalAnimation = Duration(milliseconds: 600);
  static const Duration slowAnimation = Duration(milliseconds: 1200);
  static const Duration heartbeatDuration = Duration(milliseconds: 800);

  // === SIZES ===
  static const double borderRadius = 20.0;
  static const double cardBorderRadius = 24.0;
  static const double largeBorderRadius = 40.0;
  static const double sectionPadding = 60.0;
  static const double mobilePadding = 24.0;

  // === HEART RAIN ===
  static const int heartCount = 20;
  static const double heartMinSize = 12.0;
  static const double heartMaxSize = 28.0;

  // === PARTICLES ===
  static const int particleCount = 50;
}
