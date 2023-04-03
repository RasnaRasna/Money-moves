import 'package:flutter/material.dart';
import 'package:money_management2/OnbordingScreen/skipone.dart';
import 'package:money_management2/OnbordingScreen/skiptwo.dart';
import 'package:money_management2/OnbordingScreen/start.dart';
import 'package:money_management2/widgets/bottonm%20google/gbottom_bar.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../onbording_functions.dart';

class Pageview extends StatefulWidget {
  const Pageview({super.key});

  @override
  State<Pageview> createState() => _PageviewState();
}

class _PageviewState extends State<Pageview> {
  //controller to keep track of which page we
  PageController controller = PageController();
  bool onLastPage = false;
  bool onLastSkip = false;
  int index = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      extendBody: true,
      body: Stack(
        children: [
          PageView(
            controller: controller,
            onPageChanged: (index) {
              if (index == 2) {
                setState(() {
                  onLastSkip = true;
                });
              }
              setState(() {
                onLastPage = (index == 1);
                this.index = index;
              });
            },
            children: const [
              // First Page
              SkipOne(),
              // Second Page
              Skiptwo(),
              // Last Page
              Started(),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 30),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ListTile(
                  leading: index == 0
                      ? GestureDetector(
                          child: ElevatedButton(
                              onPressed: () {
                                controller.jumpToPage(2);
                              },
                              child: const Text(
                                'Skip',
                                style: TextStyle(
                                  color: Color.fromARGB(255, 10, 92, 130),
                                ),
                              )),
                        )
                      : null,
                  title: Padding(
                    padding: const EdgeInsets.only(left: 35),
                    child: SmoothPageIndicator(
                      controller: controller,
                      count: 3,
                      effect: const WormEffect(
                          strokeWidth: 2.4,
                          activeDotColor: Color.fromARGB(255, 141, 169, 193),
                          dotWidth: 20,
                          dotHeight: 10,
                          dotColor: Color.fromARGB(255, 10, 92, 130),
                          spacing: 10),
                    ),
                  ),
                  trailing: index == 2
                      ? GestureDetector(
                          child: ElevatedButton(
                              onPressed: () {
                                oneTimeAdd(value: 1);

                                Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: ((context) =>
                                            const Bottomnav())));
                              },
                              child: const Text(
                                'Get Started',
                                style: TextStyle(
                                  color: Color.fromARGB(255, 10, 92, 130),
                                ),
                              )),
                        )
                      : GestureDetector(
                          child: ElevatedButton(
                              onPressed: () {
                                controller.nextPage(
                                    duration: const Duration(milliseconds: 500),
                                    curve: Curves.easeIn);
                              },
                              child: const Text(
                                'Next',
                                style: TextStyle(
                                  color: Color.fromARGB(255, 10, 92, 130),
                                ),
                              )),
                        ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
