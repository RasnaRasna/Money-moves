import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:money_management2/widgets/Homeone/Homeonet.dart';
import 'package:money_management2/widgets/bottonm%20google/gbottom_bar.dart';

class Started extends StatelessWidget {
  const Started({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.transparent,
      body: Stack(
        children: [
          Center(
            child: Image.asset('lib/assets/images/126891-money-runner.gif'),
          ),
          Align(
            alignment: Alignment.bottomLeft,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 100, left: 30),
              child: Text(
                "Grow your Money orderley\n  Let's get started ",
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
                  onPressed: () {
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (ctx) => const Homeone()));
                  },
                  icon: const Icon(Icons.arrow_back),
                  label: const Text('Get started '),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
