import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:money_management2/widgets/pages/about.dart';
import 'package:money_management2/widgets/pages/privacy.dart';
import 'package:money_management2/widgets/pages/settings/reset.dart';
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
          Card(
            elevation: 30,
            shape: BeveledRectangleBorder(
              borderRadius: BorderRadius.circular(40),
            ),
            child: ListTile(
              onTap: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (ctx) => const About()));
              },
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
              // tileColor: Color.fromARGB(181, 250, 163, 239),
              leading: IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.person,
                  size: 30,
                ),
              ),
              title: const Text(
                'About',
                style: TextStyle(fontSize: 20),
              ),
            ),
          ),
          const Divider(
            color: Colors.transparent,
          ),
          Card(
            elevation: 30,
            shape: BeveledRectangleBorder(
              borderRadius: BorderRadius.circular(40),
            ),
            child: ListTile(
              onTap: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Text('Reset Data'),
                      content: Text(
                        'Are you sure you want to reset all data?',
                        style: TextStyle(fontSize: 20),
                      ),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: Text('CANCEL'),
                        ),
                        TextButton(
                          onPressed: () {
                            resetAlldatas();
                            // Navigator.of(context).pop();
                            Navigator.pop(context);
                          },
                          child: Text(
                            'RESET',
                            style: TextStyle(color: Colors.red),
                          ),
                        ),
                      ],
                    );
                  },
                );
              },

              // onTap: () {

              //    resetAlldatas();
              //    Navigator.pop(context);
              // },
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
              leading: IconButton(
                onPressed: () async {},
                icon: const Icon(
                  Icons.refresh,
                  size: 30,
                ),
              ),
              title: const Text(
                'Reset',
                style: TextStyle(fontSize: 20),
              ),
            ),
          ),
          const Divider(
            color: Colors.transparent,
          ),
          Card(
            elevation: 30,
            shape: BeveledRectangleBorder(
              borderRadius: BorderRadius.circular(40),
            ),
            child: ListTile(
              onTap: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (ctx) => const Privacy()));
              },
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
              // tileColor: Color.fromARGB(181, 250, 163, 239),
              leading: IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.privacy_tip,
                  size: 30,
                ),
              ),
              title: const Text(
                'Privacy Policy',
                style: TextStyle(fontSize: 20),
              ),
            ),
          ),
          const Divider(
            color: Colors.transparent,
          ),
          Card(
            elevation: 30,
            shape: BeveledRectangleBorder(
              borderRadius: BorderRadius.circular(40),
            ),
            child: ListTile(
              // onTap: () async {
              //   await Share.share(
              //     'Check out this awesome app!',
              //     subject: 'App recommendation',
              //     sharePositionOrigin: const Rect.fromLTWH(0, 0, 100, 100),
              //   );
              // },
              // Navigator.of(context)
              //     .push(MaterialPageRoute(builder: (ctx) => const Terms()));

              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
              // tileColor: Color.fromARGB(181, 250, 163, 239),
              leading: IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.share,
                  size: 30,
                ),
              ),
              title: const Text(
                'Share',
                style: TextStyle(fontSize: 20),
              ),
            ),
          ),
          const Divider(
            color: Colors.transparent,
          ),
          Card(
            elevation: 30,
            shape: BeveledRectangleBorder(
              borderRadius: BorderRadius.circular(40),
            ),
            child: ListTile(
              onTap: () async {
                const url =
                    'mailto:rasnack7@gmail.com?subject=Review on Money Management &body= Can you help me';
                try {
                  Uri uri = Uri.parse(url);
                  await launchUrl(uri);
                  log("");
                } catch (e) {
                  log("error");
                }
              },
              // onTap: () async {
              //   await Share.share(
              //     'Check out this awesome app!',
              //     subject: 'App recommendation',
              //     sharePositionOrigin: const Rect.fromLTWH(0, 0, 100, 100),
              //   );
              // },

              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
              // tileColor: Color.fromARGB(187, 250, 163, 239),
              leading: IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.message,
                  size: 30,
                ),
              ),
              title: const Text(
                'Feedback',
                style: TextStyle(fontSize: 20),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
