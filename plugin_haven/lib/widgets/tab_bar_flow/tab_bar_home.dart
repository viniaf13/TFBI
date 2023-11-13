//  Copyright © 2022 Bottle Rocket Studios. All rights reserved.

import 'package:flutter/material.dart';
import 'package:plugin_haven/widgets/tab_bar_flow/tab_navigator.dart';

class TabBarPage {
  TabBarPage({
    this.appBar,
    this.nestedNavigatorKey,
    this.routes,
    required this.body,
    required this.navBarIcon,
  });

  AppBar? appBar;
  Widget body;
  GlobalKey<NavigatorState>? nestedNavigatorKey;
  Map<String, WidgetBuilder>? routes;
  BottomNavigationBarItem navBarIcon;
}

// Future: Consider hide on scroll tab bar option. Example here...
// https://blog.logrocket.com/how-to-build-a-bottom-navigation-bar-in-flutter/

class TabBarHome extends StatelessWidget {
  TabBarHome({Key? key, required this.pages}) : super(key: key) {
    _items = pages.map((e) => e.navBarIcon).toList();
  }

  final List<TabBarPage> pages;
  late final List<BottomNavigationBarItem> _items;
  final ValueNotifier<int> _selectedIndex = ValueNotifier(0);

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<int>(
      builder: (context, selected, object) => Scaffold(
        appBar: pages[_selectedIndex.value].appBar,
        body: IndexedStack(
          index: _selectedIndex.value,
          children: pages.map((e) {
            //Check if TabBarPage is nested or not
            if (e.nestedNavigatorKey == null) {
              return e.body;
            } else {
              return TabNavigator(
                navigatorKey: e.nestedNavigatorKey!,
                nestedRoutes: e.routes!,
              );
            }
          }).toList(),
        ),
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          selectedFontSize: 12,
          unselectedFontSize: 12,
          items: _items,
          currentIndex: selected,
          showUnselectedLabels: true,
          onTap: (index) => _selectedIndex.value = index,
        ),
      ),
      valueListenable: _selectedIndex,
    );
  }
}
