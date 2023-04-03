import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:money_management2/widgets/bottonm%20google/gbottom_bar.dart';

class About extends StatelessWidget {
  const About({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.topRight,
            colors: [
              Color.fromARGB(255, 10, 92, 130),
              Color.fromARGB(255, 221, 210, 210),
              Color.fromRGBO(206, 216, 223, 1),
            ]),
        shape: BoxShape.rectangle,
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          leading: IconButton(
              onPressed: () {
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (context) => const Bottomnav(),
                  ),
                );
                // Navigator.of(context).push(MaterialPageRoute(
                //     builder: ((context) => const Bottomnav())));
              },
              icon: const Icon(
                Icons.arrow_back,
                color: Colors.black,
              )),
          backgroundColor: Colors.transparent,
          centerTitle: true,
          title: const Text(
            'About',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
          ),
        ),
        body: Center(
          child: SizedBox(
            width: 300,
            height: 300,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 70),
                  child: Text(
                    'Money  Moves',
                    style: GoogleFonts.acme(fontSize: 30),
                  ),
                ),
                Text(
                  "Developed By RASNA",
                  style: GoogleFonts.caudex(
                      fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 50,
                  width: 30,
                ),
                const Text(
                  'version 1.0.2',
                  style: TextStyle(color: Colors.grey),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
