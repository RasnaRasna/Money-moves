import 'package:flutter/material.dart';

import '../../Homeone/Homeonet.dart';

class MainHome extends StatelessWidget {
  const MainHome({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: Homeone.selectedIndexNotifier,
      builder: (BuildContext ctx, int updatedIndex, widget_) {
        return BottomNavigationBar(
          selectedItemColor: Color.fromARGB(255, 10, 92, 130),
          unselectedItemColor: Colors.black,
          currentIndex: updatedIndex,
          onTap: (newIndex) {
            Homeone.selectedIndexNotifier.value = newIndex;
          },
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'home'),
            BottomNavigationBarItem(
              icon: Icon(Icons.category_rounded),
              label: 'Category',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.graphic_eq_sharp),
              label: 'statics',
            ),
          ],
        );
      },
    );
  }
}
