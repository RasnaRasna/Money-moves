import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Terms extends StatelessWidget {
  const Terms({super.key});

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
            'Terms&Conditions',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
          )),
        ),
        body: Center(
          child: SizedBox(
            width: 300,
            height: 700,
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
                      " By using Our Money moves app,you agree to our terms and conditions .this includes our fee  shedule,which outlines any transactions made  through the app and agree to promtly report any arrors our unauthorized access to your account .our privacy poicy outlines hoe we collect and use your personal information ,and you agree to the collection and use your data in accordance with the policy .we are not liable for any errors orunauthorized access to your account ,and you agree to indemnify and hold us harmless for any damages resulting from such errors or unauthorized access.these terms and conditions are subject to chnge at any time,and it is your   .",
                      style: GoogleFonts.caudex(
                          fontSize: 17, fontWeight: FontWeight.bold),
                    ),
                  ),
                  const Text(
                    'version 1.0.1',
                    style: TextStyle(color: Colors.grey),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
