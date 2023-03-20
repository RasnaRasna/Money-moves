import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:money_management2/OnbordingScreen/onbordingScreen.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.topRight,
            colors: [
              Color.fromARGB(255, 10, 92, 130),
              Color.fromARGB(255, 228, 221, 221),
            ]),
        shape: BoxShape.rectangle,
      ),
      child: AnimatedSplashScreen(
        duration: 2000,
        backgroundColor: Colors.transparent,
        splashTransition: SplashTransition.fadeTransition,
        nextScreen: const OnboardingScreen(),
        splash: Scaffold(
          backgroundColor: Colors.transparent,
          body: Column(
            children: [
              Align(
                alignment: Alignment.bottomLeft,
                child: Center(
                  child: Text(
                    'Money Moves',
                    style: GoogleFonts.acme(fontSize: 30),
                  ),
                ),
              ),
              const Text('version 1.0.1'),
            ],
          ),
        ),
      ),
    );
  }
}
