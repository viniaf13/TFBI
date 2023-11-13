import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:txfb_insurance_flutter/app/pages/file_a_claim_forms/widgets/claims_form_progress_indicator.dart';
import 'package:txfb_insurance_flutter/resources/theme/colors/tfb_brand_colors.dart';

import '../../../../widgets/tfb_widget_tester.dart';

void main() {
  late bool step1WasPressed;
  late bool step2WasPressed;
  late bool step3WasPressed;

  final steps = [
    ClaimFormProgressIndicatorStep(
      label: 'Step 1',
      status: ValueNotifier<ProgressIndicatorStatus>(
        ProgressIndicatorStatus.completed,
      ),
      onTap: () {
        step1WasPressed = true;
      },
    ),
    ClaimFormProgressIndicatorStep(
      label: 'Step 2',
      status: ValueNotifier<ProgressIndicatorStatus>(
        ProgressIndicatorStatus.inProgress,
      ),
      onTap: () {
        step2WasPressed = true;
      },
    ),
    ClaimFormProgressIndicatorStep(
      label: 'Step 3',
      status: ValueNotifier<ProgressIndicatorStatus>(
        ProgressIndicatorStatus.notStarted,
      ),
      onTap: () {
        step3WasPressed = true;
      },
    ),
  ];

  setUp(() {
    step1WasPressed = false;
    step2WasPressed = false;
    step3WasPressed = false;
  });

  testWidgets(
    'Claims form progress indicator steps should show separators between steps',
    (tester) async {
      await tester.pumpWidget(
        TfbWidgetTester(
          child: Scaffold(
            body: ClaimsFormProgressIndicator(
              steps: steps,
            ),
          ),
        ),
      );
      await tester.pump();
      expect(
        find.byWidgetPredicate(
          (widget) => widget is Container && widget.constraints?.maxHeight == 1,
        ),
        findsNWidgets(2),
      );
    },
  );

  testWidgets(
    'Claims form progress indicator steps should be the right color for their status',
    (tester) async {
      await tester.pumpWidget(
        TfbWidgetTester(
          child: Scaffold(
            body: ClaimsFormProgressIndicator(
              steps: steps,
            ),
          ),
        ),
      );
      await tester.pump();
      // Step 1 is green
      expect(
        find.byWidgetPredicate(
          (widget) =>
              widget is Text &&
              widget.data == 'Step 1' &&
              widget.style?.color == TfbBrandColors.greenHighest,
        ),
        findsOneWidget,
      );
      expect(
        find.byWidgetPredicate(
          (widget) =>
              widget is Container &&
              widget.child is Text &&
              (widget.child as Text).data == '1' &&
              widget.decoration is BoxDecoration &&
              (widget.decoration as BoxDecoration).color ==
                  TfbBrandColors.greenHigh,
        ),
        findsOneWidget,
      );
      // Step 2 is blue
      expect(
        find.byWidgetPredicate(
          (widget) =>
              widget is Text &&
              widget.data == 'Step 2' &&
              widget.style?.color == TfbBrandColors.blueHighest,
        ),
        findsOneWidget,
      );
      expect(
        find.byWidgetPredicate(
          (widget) =>
              widget is Container &&
              widget.child is Text &&
              (widget.child as Text).data == '2' &&
              widget.decoration is BoxDecoration &&
              (widget.decoration as BoxDecoration).color ==
                  TfbBrandColors.blueHigh,
        ),
        findsOneWidget,
      );
      // Step 3 is gray
      expect(
        find.byWidgetPredicate(
          (widget) =>
              widget is Text &&
              widget.data == 'Step 3' &&
              widget.style?.color == TfbBrandColors.grayHigh,
        ),
        findsOneWidget,
      );
      expect(
        find.byWidgetPredicate(
          (widget) =>
              widget is Container &&
              widget.child is Text &&
              (widget.child as Text).data == '3' &&
              widget.decoration is BoxDecoration &&
              (widget.decoration as BoxDecoration).color ==
                  TfbBrandColors.grayHigh,
        ),
        findsOneWidget,
      );
    },
  );

  testWidgets(
    'On press steps, should call callback',
    (tester) async {
      await tester.pumpWidget(
        TfbWidgetTester(
          child: Scaffold(
            body: ClaimsFormProgressIndicator(
              steps: steps,
            ),
          ),
        ),
      );
      await tester.pump();
      await tester.tap(find.text('Step 1'));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Step 2'));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Step 3'));
      await tester.pumpAndSettle();
      expect(step1WasPressed, isTrue);
      expect(step2WasPressed, isTrue);
      expect(step3WasPressed, isTrue);
    },
  );
}
