import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:blurrycontainer/blurrycontainer.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

homecard(double? totalbalance, double? totalexpense, double? totalincome) {
  return BlurryContainer(
    blur: 50,
    width: double.infinity,
    height: 250,
    elevation: 26,
    color: Colors.blue.withOpacity(0.1),
    padding: const EdgeInsets.all(8),
    borderRadius: const BorderRadius.all(Radius.circular(30)),
    child: Stack(
      children: [
        const SizedBox(
          height: 50,
        ),
        Align(
            alignment: Alignment.topCenter,
            child: AnimatedTextKit(
              animatedTexts: [
                TyperAnimatedText('Arrange your money ',
                    textStyle: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(255, 5, 67, 96),
                        fontSize: 17)),
                TyperAnimatedText('Add Income/Expense',
                    textStyle: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(255, 5, 67, 96),
                        fontSize: 17)),
                TyperAnimatedText('Will do the calculations accordingly',
                    textStyle: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 17,
                      color: Color.fromARGB(255, 5, 67, 96),
                    )),
                TyperAnimatedText('You Can Add Category Separately',
                    textStyle: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 17,
                      color: Color.fromARGB(255, 5, 67, 96),
                    )),
              ],
              pause: const Duration(milliseconds: 1500),
              repeatForever: true,
            )),

        Padding(
          padding: const EdgeInsets.only(top: 60),
          child: Align(
            alignment: Alignment.topCenter,
            child: SizedBox(
              height: 30,
              child: Text('Current Balance',
                  style: GoogleFonts.acme(fontSize: 28)),
            ),
          ),
        ),

        Align(
          alignment: Alignment.center,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.currency_rupee_sharp,
                color: Colors.black,
                size: 30,
              ),
              Text(
                totalbalance.toString(),
                style: const TextStyle(fontSize: 25, color: Colors.black),
              ),
            ],
          ),
        ),

        Padding(
          padding: const EdgeInsets.only(left: 20, bottom: 30),
          child: Align(
            alignment: Alignment.bottomRight,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                const Padding(
                  padding: EdgeInsets.only(left: 14),
                  child: Text(
                    'Expense',
                    style: TextStyle(
                        fontSize: 20,
                        color: Color.fromARGB(255, 154, 20, 10),
                        fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const Icon(
                      Icons.currency_rupee,
                      color: Color.fromARGB(255, 154, 20, 10),
                    ),
                    Text(
                      totalexpense.toString(),
                      style: const TextStyle(
                        fontSize: 20,
                        color: Color.fromARGB(255, 154, 20, 10),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
        //
        // money
        Padding(
          padding: const EdgeInsets.only(right: 20, bottom: 30),
          child: Align(
            alignment: Alignment.bottomRight,
            child: Column(
              // mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                const Padding(
                  padding: EdgeInsets.only(right: 14),
                  child: Text(
                    "Income",
                    style: TextStyle(
                        fontSize: 20,
                        color: Color.fromARGB(255, 34, 150, 38),
                        fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    const Icon(
                      Icons.currency_rupee,
                      color: Color.fromARGB(255, 34, 150, 38),
                    ),
                    Text(
                      totalincome.toString(),
                      style: const TextStyle(
                        fontSize: 20,
                        color: Color.fromARGB(255, 34, 150, 38),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        )
      ],
    ),
  );
}
