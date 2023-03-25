import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// import 'package:google_fonts/google_fonts.dart';

class Skiptwo extends StatelessWidget {
  const Skiptwo({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Stack(
          children: [
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
          ],
        ),
      ),
    );
  }
}
