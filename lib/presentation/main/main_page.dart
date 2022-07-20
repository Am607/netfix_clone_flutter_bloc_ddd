import 'package:flutter/material.dart';
import 'package:netflix/presentation/dowloades/downloads.dart';
import 'package:netflix/presentation/fast_laugh/fast_laugh_page.dart';
import 'package:netflix/presentation/home/homepage.dart';
import 'package:netflix/presentation/main/widgets/bottom_navigation_bar.dart';
import 'package:netflix/presentation/new_and_hot/new_and_hot_page.dart';
import 'package:netflix/presentation/search/search.dart';

class MainPage extends StatelessWidget {
  MainPage({Key? key}) : super(key: key);

  final _pages = [
    const HomePage(),
    const NewAndHotPage(),
    SearchPage(),
    const FastLuaghPage(),
    const DownloadPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ValueListenableBuilder(
          valueListenable: indexChangeNotifier,
          builder: (context, int index, _) {
            return _pages[index];
          }),
      bottomNavigationBar: const BottomNavigationWidget(),
    );
  }
}
