// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:google_nav_bar/google_nav_bar.dart';
// import 'package:money_management2/widgets/Category/categoryy.dart';
// import 'package:money_management2/widgets/pages/Hometransaction/home_transaction.dart';
// import 'package:money_management2/widgets/pages/static/static.dart';

// class Bottomnav extends StatefulWidget {
//   const Bottomnav({super.key});

//   @override
//   State<Bottomnav> createState() => _BottomnavState();
// }

// class _BottomnavState extends State<Bottomnav> {
// // ignore: non_constant_identifier_names
//   int Selectedindex = 0;

//   final List<Widget> tabs = [
//     HomeTransactonn(),
//     Categoryy(),
//     Statics(),
//   ];

//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Scaffold(
//         extendBody: true,
//         backgroundColor: Colors.transparent,
//         bottomNavigationBar: Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 20),
//           child: GNav(
//               onTabChange: (newIndex) {
//                 setState(() {
//                   Selectedindex = newIndex;
//                 });
//               },
//               curve: Curves.easeIn,
//               duration: const Duration(microseconds: 80),
//               activeColor: Colors.white,
//               textStyle: const TextStyle(
//                   color: Colors.white, fontWeight: FontWeight.w500),
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               gap: 8,
//               backgroundColor: Colors.transparent,
//               padding: const EdgeInsets.all(16),
//               tabBackgroundColor: Colors.blue,
//               iconSize: 29,
//               textSize: 24,
//               tabs: const [
//                 GButton(
//                   curve: Curves.easeIn,
//                   icon: Icons.home_outlined,
//                   text: 'Home',
//                   iconColor: Colors.black,
//                 ),
//                 GButton(
//                   curve: Curves.easeIn,
//                   icon: Icons.pie_chart_outline,
//                   text: 'Statistics',
//                   iconColor: Colors.black,
//                 ),
//                 GButton(
//                   curve: Curves.easeIn,
//                   icon: Icons.history_outlined,
//                   text: 'History',
//                   iconColor: Colors.black,
//                 ),
//                 GButton(
//                   curve: Curves.easeIn,
//                   icon: Icons.settings_outlined,
//                   iconColor: Colors.black,
//                   text: 'Settings',
//                 ),
//               ]),
//         ),
//         body: tabs[Selectedindex],
//       ),
//     );
//   }
// }
