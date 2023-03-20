import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Privacy extends StatelessWidget {
  const Privacy({super.key});

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
          backgroundColor: Colors.transparent,
          title: const Center(
              child: Text(
            'Privacy policy',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
          )),
        ),
        body: Center(
          child: SizedBox(
            width: 300,
            height: 400,
            child: Card(
              elevation: 60,
              color: Colors.white,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 5),
                    child: Text(
                      'Money  Moves',
                      style: GoogleFonts.acme(fontSize: 30),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: Text(
                      " Our money moves app values your Privacy and is commited to protecting your personal information We only collect information that is necessary to provide you with the best possible service .We do not sell or share your information with third parties your data is secured using industry standard measures.    ",
                      style: GoogleFonts.caudex(
                          fontSize: 17, fontWeight: FontWeight.bold),
                    ),
                  ),
                  const Text(
                    'version 1.0.1',
                    style: TextStyle(color: Colors.grey),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
