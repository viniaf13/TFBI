//  Copyright © 2022 Bottle Rocket Studios. All rights reserved.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:plugin_haven/widgets/tab_bar_flow/tab_bar_home.dart';

const itemLabel1 = 'Page 1';
const itemLabel2 = 'Page 2';

Widget createTabBarHome() {
  final pages = <TabBarPage>[
    TabBarPage(
      body: const Placeholder(),
      navBarIcon: const BottomNavigationBarItem(
        label: itemLabel1,
        icon: Icon(Icons.format_list_numbered),
      ),
    ),
    TabBarPage(
      body: const Placeholder(),
      navBarIcon: const BottomNavigationBarItem(
        label: itemLabel2,
        icon: Icon(Icons.format_list_numbered),
      ),
    )
  ];
  return TabBarHome(pages: pages);
}

void main() {
  group('TabBarHome Widget Tests', () {
    // TabBarHome assumes MediaQuery parent
    final appWidget = MaterialApp(home: createTabBarHome());

    testWidgets('Nav item labels are visible', (tester) async {
      await tester.pumpWidget(appWidget);
      expect(find.text(itemLabel1), findsOneWidget);
      expect(find.text(itemLabel2), findsOneWidget);
    });
  });
}
