import 'package:flutter/material.dart';

ValueNotifier<int> indexChangeNotifier = ValueNotifier<int>(0);

class BottomNavigationWidget extends StatelessWidget {
  const BottomNavigationWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: indexChangeNotifier,
        builder: (context, int index, _) {
          return BottomNavigationBar(
            currentIndex: index,
            elevation: 0,
            type: BottomNavigationBarType.fixed,
            selectedItemColor: Colors.white,
            unselectedItemColor: Colors.grey,
            backgroundColor: Colors.black,
            selectedIconTheme: const IconThemeData(color: Colors.white),
            onTap: (index) {
              indexChangeNotifier.value = index;
            }, //for icon
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.collections),
                label: 'New & Hot',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.search),
                label: 'Search',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.emoji_emotions),
                label: 'Fast laugh',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.arrow_drop_down_circle_rounded),
                label: 'Downloads',
              ),
            ],
          );
        });
  }
}
