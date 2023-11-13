import 'package:flutter_test/flutter_test.dart';
import 'package:txfb_insurance_flutter/shared/widgets/list_tile_with_arrow.dart';
import 'package:txfb_insurance_flutter/resources/theme/theme.dart';

import '../../../../widgets/tfb_widget_tester.dart';

void main() {
  testWidgets('Account list tile should display title', (tester) async {
    const tileTitle = 'TITLE';

    await tester.pumpWidget(
      TfbWidgetTester(
        child: Scaffold(
          body: ListTileWithArrow(
            title: tileTitle,
          ),
        ),
      ),
    );

    expect(find.text(tileTitle), findsOneWidget);
  });

  testWidgets(
      'Hiding the arrow should remove the navigation arrow on the list tile',
      (tester) async {
    await tester.pumpWidget(
      TfbWidgetTester(
        child: Scaffold(
          body: ListTileWithArrow(
            title: 'TITLE',
            showArrow: false,
          ),
        ),
      ),
    );

    expect(find.byType(Icon), findsNothing);
  });

  testWidgets(
      'Tapping on the list tile should call the "onPress" function on the tile',
      (tester) async {
    int numCalls = 0;

    await tester.pumpWidget(
      TfbWidgetTester(
        child: Scaffold(
          body: ListTileWithArrow(
            title: 'TITLE',
            onPress: () {
              numCalls++;
            },
          ),
        ),
      ),
    );

    await tester.tap(find.byType(ListTileWithArrow));

    expect(numCalls, 1);
  });
}
