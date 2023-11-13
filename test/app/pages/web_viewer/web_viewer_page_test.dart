import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:txfb_insurance_flutter/app/pages/web_viewer/web_viewer_page.dart';

import '../../../widgets/tfb_widget_tester.dart';

void main() {
  final fakeUri = Uri.parse('https://example.com');

  testWidgets('WebViewerPage displays correctly', (WidgetTester tester) async {
    await tester.pumpWidget(
      TfbWidgetTester(
        child: WebViewerPage(uri: fakeUri),
      ),
    );

    expect(find.byType(SizedBox), findsOneWidget);
  });
}
