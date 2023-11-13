import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:txfb_insurance_flutter/shared/widgets/bottom_sheet_selector.dart';

import '../../widgets/tfb_widget_tester.dart';

void main() {
  final List<BottomSheetSelectorOption> options = [
    BottomSheetSelectorOption(label: 'label 1', value: 'value 1'),
    BottomSheetSelectorOption(label: 'label 2', value: 'value 2'),
  ];

  testWidgets('Bottom Sheet Selector should render options', (tester) async {
    await tester.pumpWidget(
      TfbWidgetTester(
        child: Scaffold(
          body: BottomSheetSelector(
            title: 'title',
            options: options,
            onChanged: (_) {},
            selectedValueController: TextEditingController(),
          ),
        ),
      ),
    );

    await tester.tap(find.byType(TextFormField));
    await tester.pump(const Duration(milliseconds: 500));
    expect(find.text(options[0].label), findsOneWidget);
    expect(find.text(options[1].label), findsOneWidget);
  });

  testWidgets('Bottom Sheet Selector should call callback with onChanged value',
      (tester) async {
    String onChangedValue = '';

    await tester.pumpWidget(
      TfbWidgetTester(
        child: Scaffold(
          body: BottomSheetSelector(
            title: 'title',
            options: options,
            onChanged: (value) {
              onChangedValue = value as String;
            },
            selectedValueController: TextEditingController(),
          ),
        ),
      ),
    );

    await tester.tap(find.byType(TextFormField));
    await tester.pump(const Duration(milliseconds: 500));
    final widgetToTap = find.byType(TextButton).first;
    await tester.ensureVisible(widgetToTap);
    await tester.pumpAndSettle();
    await tester.tap(widgetToTap);
    await tester.pumpAndSettle();

    expect(onChangedValue, options[0].value);
  });
}
