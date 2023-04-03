import 'package:flutter/material.dart';
import 'package:flutter_share/flutter_share.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:money_management2/widgets/pages/settings/about.dart';
import 'package:money_management2/widgets/pages/settings/privacy.dart';
import 'package:money_management2/widgets/pages/settings/reset.dart';
// import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

class MenuNavbar extends StatelessWidget {
  const MenuNavbar({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: const Color.fromARGB(255, 10, 92, 130),
      // Color.fromARGB(255, 221, 210, 210),

      child: Column(
        children: [
          const SizedBox(
            height: 100,
          ),
          ListTile(
            onTap: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (ctx) => const About()));
            },
            leading: Container(
              width: 35,
              height: 35,
              decoration: BoxDecoration(
                  color: Color.fromARGB(255, 67, 124, 151),
                  borderRadius: BorderRadius.circular(10)),
              child: IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.person,
                  color: Colors.white,
                  size: 20,
                ),
              ),
            ),
            title: Text(
              'About',
              style: GoogleFonts.acme(fontSize: 20, color: Colors.white),
            ),
          ),
          const Divider(
            color: Colors.transparent,
          ),
          ListTile(
            onTap: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    backgroundColor: const Color.fromARGB(255, 10, 92, 130),
                    title: Text(
                      'Reset Data',
                      style: GoogleFonts.acme(color: Colors.white),
                    ),
                    content: Text(
                      'Are you sure you want to reset all data ?',
                      style:
                          GoogleFonts.acme(fontSize: 20, color: Colors.white),
                      // style: TextStyle(fontSize: 20, color: Colors.white),
                    ),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: const Text(
                          'CANCEL',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          resetAllData(context);
                          // Navigator.of(context).pop();
                          Navigator.pop(context);
                        },
                        child: const Text(
                          'RESET',
                          style: TextStyle(
                              color: Color.fromARGB(255, 236, 64, 52)),
                        ),
                      ),
                    ],
                  );
                },
              );
            },
            leading: Container(
              width: 35,
              height: 35,
              decoration: BoxDecoration(
                  color: Color.fromARGB(255, 67, 124, 151),
                  borderRadius: BorderRadius.circular(10)),
              child: IconButton(
                onPressed: () async {},
                icon: const Icon(
                  Icons.refresh,
                  color: Colors.white,
                  size: 20,
                ),
              ),
            ),
            title: Text(
              'Reset',
              style: GoogleFonts.acme(fontSize: 20, color: Colors.white),
              // style: TextStyle(),
            ),
          ),
          const Divider(
            color: Colors.transparent,
          ),
          ListTile(
            onTap: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (ctx) => const Privacy()));
            },
            leading: Container(
              width: 35,
              height: 35,
              decoration: BoxDecoration(
                  color: Color.fromARGB(255, 67, 124, 151),
                  borderRadius: BorderRadius.circular(10)),
              child: IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.privacy_tip,
                  color: Colors.white,
                  size: 20,
                ),
              ),
            ),
            title: Text(
              'Privacy Policy',
              style: GoogleFonts.acme(fontSize: 20, color: Colors.white),
            ),
          ),
          const Divider(
            color: Colors.transparent,
          ),
          ListTile(
            onTap: () {
              share();
            },
            leading: Container(
              width: 35,
              height: 35,
              decoration: BoxDecoration(
                  color: Color.fromARGB(255, 67, 124, 151),
                  borderRadius: BorderRadius.circular(10)),
              child: IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.share,
                  color: Colors.white,
                  size: 20,
                ),
              ),
            ),
            title: Text(
              'Share',
              style: GoogleFonts.acme(fontSize: 20, color: Colors.white),
            ),
          ),
          const Divider(
            color: Colors.transparent,
          ),
          ListTile(
            onTap: () async {
              const url =
                  'mailto:rasnack7@gmail.com?subject=Review on Money Moves &body= need';

              Uri uri = Uri.parse(url);
              await launchUrl(uri);
            },

            // tileColor: Color.fromARGB(187, 250, 163, 239),
            leading: Container(
              width: 35,
              height: 35,
              decoration: BoxDecoration(
                  color: Color.fromARGB(255, 67, 124, 151),
                  borderRadius: BorderRadius.circular(10)),
              child: IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.message,
                  color: Colors.white,
                  size: 20,
                ),
              ),
            ),
            title: Text(
              'Feedback',
              style: GoogleFonts.acme(fontSize: 20, color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}

Future share() async {
  await FlutterShare.share(
      title: ' Money Moves',
      text: 'Money Moves ',
      linkUrl:
          'https://play.google.com/store/apps/details?id=in.rasnaminnu.money_moves');
}
