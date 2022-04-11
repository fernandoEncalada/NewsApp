import 'package:flutter/material.dart';
import 'package:news_app/src/screens/tab1_screen.dart';
import 'package:provider/provider.dart';

import 'tab2_screen.dart';

class TabsPage extends StatelessWidget {
  const TabsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => _NavigationModel(),
      child: Scaffold(
        body: _Screens(),
        bottomNavigationBar: _Navigation(),
      ),
    );
  }
}

class _Navigation extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final navigationModel = Provider.of<_NavigationModel>(context);

    return BottomNavigationBar(
        currentIndex: navigationModel.actualScreen,
        onTap: (i) => navigationModel.actualScreen = i,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.people), label: 'For you'),
          BottomNavigationBarItem(icon: Icon(Icons.public), label: 'headlines'),
        ]);
  }
}

class _Screens extends StatelessWidget {
  const _Screens({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final navigationModel = Provider.of<_NavigationModel>(context);

    return PageView(
      controller: navigationModel.pageController,
      physics: NeverScrollableScrollPhysics(),
      children: [
        Tab1Screen(),
        Tab2Screen(),
      ],
    );
  }
}

class _NavigationModel with ChangeNotifier {
  int _actualScreen = 0;
  PageController _pageController = PageController();

  int get actualScreen => _actualScreen;

  set actualScreen(int value) {
    _actualScreen = value;
    _pageController.animateToPage(value,
        duration: Duration(milliseconds: 200), curve: Curves.easeInOut);
    notifyListeners();
  }

  PageController get pageController => _pageController;
}
