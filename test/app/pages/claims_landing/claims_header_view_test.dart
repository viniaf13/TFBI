import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:txfb_insurance_flutter/app/pages/claims_landing/widgets/claims_header_view.dart';
import 'package:txfb_insurance_flutter/shared/widgets/text_with_phone.dart';
import 'package:txfb_insurance_flutter/shared/shared.dart';
import '../../../widgets/tfb_widget_tester.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('ClaimsHeaderView builds without error',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      const TfbWidgetTester(
        child: ClaimsHeaderView(),
      ),
    );

    expect(find.byType(ClaimsHeaderView), findsOneWidget);
  });

  testWidgets('ClaimsHeaderView uses correct color for DecoratedBox',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      const TfbWidgetTester(
        child: ClaimsHeaderView(),
      ),
    );

    final decoratedBox =
        tester.firstWidget(find.byType(DecoratedBox)) as DecoratedBox;
    expect((decoratedBox.decoration as ShapeDecoration).color, Colors.white);
  });

  testWidgets('ClaimsHeaderView contains all expected widgets',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      const TfbWidgetTester(
        child: ClaimsHeaderView(),
      ),
    );

    expect(find.byType(Text), findsNWidgets(4)); // Changed this line
    expect(find.byType(TextWithPhone), findsOneWidget);
    expect(find.byType(TfbFilledButton), findsOneWidget);
  });

//   testWidgets('ClaimsHeaderView FilledButton shows Snackbar when pressed',
//       (WidgetTester tester) async {
//     await tester.pumpWidget(
//       const TfbWidgetTester(
//         child: Scaffold(body: ClaimsHeaderView()),
//       ),
//     );

//     await tester.tap(find.byType(FilledButton));
//     await tester.pump();

//     expect(find.byType(SnackBar), findsOneWidget);
//     expect(find.text('not implemented'), findsOneWidget);
//   });
}
