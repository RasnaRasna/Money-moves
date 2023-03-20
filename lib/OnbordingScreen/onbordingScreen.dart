import 'package:flutter/material.dart';
import 'package:money_management2/widgets/pages/skipone/skipone.dart';
import 'package:money_management2/widgets/pages/skiptwo/skiptwo.dart';
import 'package:money_management2/widgets/pages/started/start.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _controller = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: [
        PageView(
          controller: _controller,
          children: const [
            SkipOne(),
            Skiptwo(),
            Started(),
          ],
        ),
        Container(
          alignment: const Alignment(0, 0.90),
          child: SmoothPageIndicator(controller: _controller, count: 3),
        )
      ]),
    );
  }
}