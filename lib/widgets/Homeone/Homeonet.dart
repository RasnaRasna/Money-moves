// import 'package:flutter/material.dart';
// import 'package:money_management2/widgets/Category/categoryy.dart';
// import 'package:money_management2/widgets/pages/Hometransaction/home_transaction.dart';
// import 'package:money_management2/widgets/pages/static/static.dart';

// class Homeone extends StatelessWidget {
//   const Homeone({super.key});
//   static ValueNotifier<int> selectedIndexNotifier = ValueNotifier(0);
//   final _pages = const [
//     HomeTransactonn(),
//     Categoryy(),
//     Statics(),
//   ];

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       decoration: const BoxDecoration(
//         gradient: LinearGradient(colors: [
//           Color.fromARGB(255, 10, 92, 130),
//           Color.fromARGB(255, 221, 210, 210),
//           Color.fromRGBO(206, 216, 223, 1),
//         ]),
//       ),
//       child: Scaffold(
//           backgroundColor: Colors.transparent,
//           bottomNavigationBar: ValueListenableBuilder(
//             valueListenable: selectedIndexNotifier,
//             builder: (BuildContext context, int updatedIndex, widget_) {
//               return BottomNavigationBar(
//                 selectedItemColor: Color.fromARGB(255, 10, 92, 130),
//                 unselectedItemColor: Color.fromARGB(255, 79, 78, 78),
//                 currentIndex: updatedIndex,
//                 onTap: (newIndex) {
//                   selectedIndexNotifier.value = newIndex;
//                 },
//                 items: const [
//                   BottomNavigationBarItem(
//                       icon: Icon(Icons.home), label: 'home'),
//                   BottomNavigationBarItem(
//                     icon: Icon(Icons.category_rounded),
//                     label: 'Category',
//                   ),
//                   BottomNavigationBarItem(
//                     icon: Icon(Icons.graphic_eq_sharp),
//                     label: 'statics',
//                   ),
//                 ],
//               );
//             },
//           ),
//           body: SafeArea(
//             child: ValueListenableBuilder(
//               valueListenable: selectedIndexNotifier,
//               builder: (BuildContext context, int updatedIndex, _) {
//                 return _pages[updatedIndex];
//               },
//             ),
//           )),
//     );
//   }
// }
