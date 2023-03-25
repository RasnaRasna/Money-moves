import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SkipOne extends StatefulWidget {
  const SkipOne({super.key});

  @override
  State<SkipOne> createState() => _SkipOneState();
}

class _SkipOneState extends State<SkipOne> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Stack(
          children: [
            Center(
                child: Image.asset(
                    'lib/assets/images/41383-digital-finance-animation.gif')),
            Align(
              alignment: Alignment.bottomLeft,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 100, left: 30),
                child: Text(
                  'Manage your money \n with Money Moves',
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
