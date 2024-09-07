import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:poets_paradise/cores/logo/app_logo.dart';
import 'package:poets_paradise/cores/onboard/pages/onboarding_page.dart';
import 'package:poets_paradise/features/poetry/presentation/page/landing_page.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
      duration: 800,
      splash: const AppLogo(),
      nextScreen: _getNextPage(),
      splashTransition: SplashTransition.fadeTransition,
    );
  }

  Widget _getNextPage() {
    final User? user = _auth.currentUser;
    if (user == null) {
      return const OnboardingPage();
    } else {
      return LandingPage();
    }
  }
}
