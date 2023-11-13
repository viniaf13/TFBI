import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:txfb_insurance_flutter/app/pages/file_a_claim_forms/widgets/generic_fields/yesno_button.dart';
import 'package:txfb_insurance_flutter/app/pages/file_a_claim_forms/widgets/generic_fields/yesno_card_header.dart';
import '../../../../widgets/tfb_widget_tester.dart';

void main() {
  testWidgets('yesno button should have child text when enum is set to yes.',
      (tester) async {
    await tester.pumpWidget(
      TfbWidgetTester(
        child: YesNoCardHeader(
          title: 'Title',
          onSelect: (_) {},
          selectionValue: () {
            return YesNoButtonKind.yes;
          },
          validationMessage: null,
          displayChildrenWhenSelected: YesNoButtonKind.yes,
          child: const Text('child'),
        ),
      ),
    );
    await tester.pumpAndSettle();
    expect(
      find.byType(YesNoCardHeader),
      findsOneWidget,
    );
    expect(
      find.text('Title'),
      findsOneWidget,
    );
    expect(
      find.text('child'),
      findsOneWidget,
    );
  });

  testWidgets('yesno button should not have child text when enum is set to no.',
      (tester) async {
    await tester.pumpWidget(
      TfbWidgetTester(
        child: YesNoCardHeader(
          title: 'Title',
          onSelect: (_) {},
          selectionValue: () {
            return YesNoButtonKind.yes;
          },
          validationMessage: null,
          displayChildrenWhenSelected: YesNoButtonKind.no,
          child: const Text('child'),
        ),
      ),
    );
    await tester.pumpAndSettle();
    expect(
      find.byType(YesNoCardHeader),
      findsOneWidget,
    );
    expect(
      find.text('Title'),
      findsOneWidget,
    );
    expect(
      find.text('child'),
      findsNothing,
    );
  });
}
