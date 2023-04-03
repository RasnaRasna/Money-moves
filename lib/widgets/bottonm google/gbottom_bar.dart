import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:money_management2/widgets/Category/categoryy.dart';
import 'package:money_management2/widgets/pages/Hometransaction/home_transaction.dart';
import 'package:money_management2/widgets/pages/static/static.dart';

class Bottomnav extends StatefulWidget {
  const Bottomnav({super.key});

  @override
  State<Bottomnav> createState() => _BottomnavState();
}

class _BottomnavState extends State<Bottomnav> {
// ignore: non_constant_identifier_names
  int Selectedindex = 0;

  final List<Widget> tabs = [
    const HomeTransactonn(),
    const Categoryy(),
    const Statics(),
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        extendBody: true,
        backgroundColor: Colors.transparent,
        bottomNavigationBar: Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
          decoration: const BoxDecoration(
              gradient: LinearGradient(colors: [
                Color.fromARGB(255, 19, 97, 133),
                Color.fromARGB(255, 107, 105, 105),
                Color.fromARGB(255, 19, 97, 133),
              ]),
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30), topRight: Radius.circular(30))),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4.0, vertical: 2),
            child: GNav(
                onTabChange: (newIndex) {
                  setState(() {
                    Selectedindex = newIndex;
                  });
                },
                tabBorderRadius: 70,
                curve: Curves.easeIn,
                duration: const Duration(microseconds: 80),
                activeColor: Colors.white,
                textStyle: const TextStyle(
                    color: Colors.white, fontWeight: FontWeight.w500),
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                gap: 8,
                backgroundColor: Colors.transparent,
                padding: const EdgeInsets.all(14),
                tabBackgroundColor: Colors.grey.withOpacity(0.5),
                iconSize: 29,
                textSize: 24,
                tabs: const [
                  GButton(
                    curve: Curves.easeIn,
                    icon: Icons.home_outlined,
                    text: 'Home',
                    iconColor: Colors.black,
                  ),
                  GButton(
                    curve: Curves.easeIn,
                    icon: Icons.category,
                    text: 'Category',
                    iconColor: Colors.black,
                  ),
                  GButton(
                    curve: Curves.easeIn,
                    icon: Icons.bar_chart,
                    text: 'Statistics',
                    iconColor: Colors.black,
                  ),
                ]),
          ),
        ),
        body: tabs[Selectedindex],
      ),
    );
  }
}
