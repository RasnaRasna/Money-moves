import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:money_management2/widgets/pages/started/start.dart';

class Skiptwo extends StatelessWidget {
  const Skiptwo({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.transparent,
      body: Stack(
        children: [
          Align(
              child: Align(
            alignment: Alignment.topRight,
            child: Padding(
                padding: const EdgeInsets.only(top: 30, right: 20),
                child: Directionality(
                  textDirection: TextDirection.rtl,
                  child: ElevatedButton.icon(
                    style: const ButtonStyle(
                      backgroundColor: MaterialStatePropertyAll<Color>(
                        Color.fromARGB(255, 10, 92, 130),
                      ),
                    ),
                    onPressed: () {
                      Navigator.of(context).push(
                          MaterialPageRoute(builder: (ctx) => const Started()));
                    },
                    label: const Text(
                      'Skip',
                      style: TextStyle(color: Colors.white),
                    ),
                    icon: const Icon(
                      Icons.skip_next,
                      color: Colors.white,
                    ),
                  ),
                )),
          )),
          Center(
            child: Image.asset('lib/assets/images/animation1.gif'),
          ),
          Align(
            alignment: Alignment.bottomLeft,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 100, left: 30),
              child: Text(
                'Arrage  your money \nconvenientley',
                style: GoogleFonts.acme(fontSize: 30),
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 30, right: 20),
              child: Directionality(
                textDirection: TextDirection.rtl,
                child: ElevatedButton.icon(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(
                        Color.fromARGB(255, 10, 92, 130)),
                  ),
                  onPressed: () {
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (ctx) => const Started()));
                  },
                  icon: const Icon(
                    Icons.arrow_back,
                    color: Colors.white,
                  ),
                  label: const Text(
                    'next',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
