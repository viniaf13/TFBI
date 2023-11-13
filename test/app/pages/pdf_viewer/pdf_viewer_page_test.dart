import 'package:flutter_test/flutter_test.dart';
import 'package:txfb_insurance_flutter/app/pages/pdf_viewer/tfb_pdf_viewer.dart';
import 'package:txfb_insurance_flutter/app/pages/pdf_viewer/widgets/pdf_viewer_page_content.dart';
import 'package:txfb_insurance_flutter/resources/theme/theme.dart';
import 'package:txfb_insurance_flutter/shared/constants/tfb_asset_strings.dart';
import 'package:txfb_insurance_flutter/shared/widgets/tfb_loading_overlay.dart';

import '../../../mocks/page_parameters/mock_pdf_viewer_events_parameters.dart';
import '../../../widgets/tfb_widget_tester.dart';

void main() {
  final pdfViewerEventsParameters =
      MockPdfViewerEventsParameters.getEventsParameters();

  testWidgets(
      'PDF viewer page should show the title in the app bar at the top of the page',
      (tester) async {
    const pdfViewerTitle = 'TEST_TITLE';

    await tester.pumpWidget(
      TfbWidgetTester(
        child: TfbPdfViewer(
          title: pdfViewerTitle,
          filePath: 'filePath',
          pdfViewerEventsParameters: pdfViewerEventsParameters,
        ),
      ),
    );

    expect(find.text(pdfViewerTitle), findsOneWidget);
    expect(
      find.byWidgetPredicate(
        (widget) =>
            widget is AppBar &&
            widget.title is Text &&
            (widget.title as Text).data == pdfViewerTitle,
      ),
      findsOneWidget,
    );
  });

  testWidgets('PDF viewer should show snackbar when isError is true',
      (tester) async {
    await tester.pumpWidget(
      TfbWidgetTester(
        child: TfbPdfViewer(
          title: 'TEST_TITLE',
          filePath: 'filePath',
          isError: true,
          pdfViewerEventsParameters: pdfViewerEventsParameters,
        ),
      ),
    );
    await tester.pump();
    expect(find.byType(SnackBar), findsOneWidget);
  });

  testWidgets('PDF viewer should show loading overlay when isLoading is true',
      (tester) async {
    await tester.pumpWidget(
      TfbWidgetTester(
        child: TfbPdfViewer(
          title: 'TEST_TITLE',
          filePath: 'filePath',
          pdfViewerEventsParameters: pdfViewerEventsParameters,
        ),
      ),
    );

    expect(find.byType(TfbLoadingOverlay), findsOneWidget);
  });

  testWidgets('PDF viewer should show PDF content when isSuccess is true',
      (tester) async {
    await tester.pumpWidget(
      TfbWidgetTester(
        child: TfbPdfViewer(
          title: 'TEST_TITLE',
          filePath: 'filePath',
          isSuccess: true,
          isLoading: false,
          pdfViewerEventsParameters: pdfViewerEventsParameters,
        ),
      ),
    );

    expect(find.byType(PdfViewerPageContent), findsOneWidget);
  });

  testWidgets('PDF viewer should show share icon when isSuccess is true',
      (tester) async {
    await tester.pumpWidget(
      TfbWidgetTester(
        child: TfbPdfViewer(
          title: 'TEST_TITLE',
          filePath: 'filePath',
          isSuccess: true,
          pdfViewerEventsParameters: pdfViewerEventsParameters,
        ),
      ),
    );

    expect(
      find.byWidgetPredicate(
        (widget) =>
            widget is Image &&
            widget.image is AssetImage &&
            (widget.image as AssetImage).assetName == TfbAssetStrings.shareIcon,
      ),
      findsOneWidget,
    );
  });

  testWidgets('PDF viewer should show nothing when no conditions are met',
      (tester) async {
    await tester.pumpWidget(
      TfbWidgetTester(
        child: TfbPdfViewer(
          title: 'TEST_TITLE',
          filePath: 'filePath',
          pdfViewerEventsParameters: pdfViewerEventsParameters,
        ),
      ),
    );

    expect(find.byType(SizedBox), findsOneWidget);
  });
}
