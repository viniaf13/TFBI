import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:txfb_insurance_flutter/app/pages/email_update_success_failure/email_update_success_failure_page.dart';
import 'package:txfb_insurance_flutter/domain/models/tfb_request_error.dart';

import '../../../widgets/tfb_widget_tester.dart';

void main() {
  testWidgets('displays success text and image when no error is provided',
      (tester) async {
    await tester.pumpWidget(
      Provider<Navigator>.value(
        value: const Navigator(),
        child: const TfbWidgetTester(
          child: EmailUpdateSuccessFailurePage(),
        ),
      ),
    );

    bool predicate(Widget widget) =>
        widget is Image &&
        widget.image is AssetImage &&
        (widget.image as AssetImage).assetName ==
            'lib/resources/assets/images/success_check.png';

    expect(find.text('Success!'), findsOneWidget);
    expect(
      find.text('Your new email has been successfully verified.'),
      findsOneWidget,
    );
    expect(find.byWidgetPredicate(predicate), findsOneWidget);
  });

  testWidgets('displays error text and image when error is provided',
      (tester) async {
    await tester.pumpWidget(
      Provider<Navigator>.value(
        value: const Navigator(),
        child: TfbWidgetTester(
          child: EmailUpdateSuccessFailurePage(
            error: TfbRequestError(message: 'An error occurred'),
          ),
        ),
      ),
    );

    bool predicate(Widget widget) =>
        widget is Image &&
        widget.image is AssetImage &&
        (widget.image as AssetImage).assetName ==
            'lib/resources/assets/images/failure_check.png';

    expect(find.text('Something Went Wrong'), findsOneWidget);
    expect(find.text('An error occurred'), findsOneWidget);
    expect(find.byWidgetPredicate(predicate), findsOneWidget);
  });
}
