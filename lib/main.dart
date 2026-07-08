// lib/main.dart
// Entry point for My Wifeu ❤️ My Grace — Flutter Web App

import 'package:flutter/material.dart';

import 'core/theme/app_theme.dart';
import 'core/constants/app_constants.dart';
import 'screens/login/login_screen.dart';
import 'screens/home/home_screen.dart';
import 'screens/apology/apology_screen.dart';
import 'screens/forever/forever_screen.dart';

void main() {
  runApp(const MyWifeuApp());
}

class MyWifeuApp extends StatelessWidget {
  const MyWifeuApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My Wifeu ❤️ My Grace',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.darkTheme,

      // === INITIAL ROUTE ===
      initialRoute: AppConstants.loginRoute,

      // === ROUTES ===
      routes: {
        AppConstants.loginRoute: (_) => const LoginScreen(),
        AppConstants.homeRoute: (_) => const HomeScreen(),
        AppConstants.apologyRoute: (_) => const ApologyScreen(),
        AppConstants.foreverRoute: (_) => const ForeverScreen(),
      },

      // === PAGE TRANSITIONS ===
      onGenerateRoute: (settings) {
        Widget page;

        switch (settings.name) {
          case AppConstants.loginRoute:
            page = const LoginScreen();
            break;
          case AppConstants.homeRoute:
            page = const HomeScreen();
            break;
          case AppConstants.apologyRoute:
            page = const ApologyScreen();
            break;
          case AppConstants.foreverRoute:
            page = const ForeverScreen();
            break;
          default:
            page = const LoginScreen();
        }

        return PageRouteBuilder(
          settings: settings,
          pageBuilder: (_, __, ___) => page,
          transitionDuration: const Duration(milliseconds: 800),
          reverseTransitionDuration: const Duration(milliseconds: 400),
          transitionsBuilder: (_, animation, secondaryAnimation, child) {
            // Fade + scale transition
            final fadeAnim = CurvedAnimation(
              parent: animation,
              curve: Curves.easeInOut,
            );
            final scaleAnim = Tween<double>(begin: 0.95, end: 1.0).animate(
              CurvedAnimation(parent: animation, curve: Curves.easeOut),
            );

            return FadeTransition(
              opacity: fadeAnim,
              child: ScaleTransition(
                scale: scaleAnim,
                child: child,
              ),
            );
          },
        );
      },
    );
  }
}
