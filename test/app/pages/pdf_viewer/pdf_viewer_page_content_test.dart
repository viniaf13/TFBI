import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:pdf_render/pdf_render_widgets.dart';
import 'package:txfb_insurance_flutter/app/pages/pdf_viewer/widgets/pdf_current_page_display.dart';
import 'package:txfb_insurance_flutter/app/pages/pdf_viewer/widgets/pdf_viewer_page_content.dart';
import 'package:txfb_insurance_flutter/app/pages/pdf_viewer/widgets/pdf_zoom_level_display.dart';

import '../../../mocks/mock_context_provider.dart';

void main() {
  final mockContext = MockBuildContext();

  setUpAll(() {
    registerFallbackValue(mockContext);
  });

  testWidgets('PDF viewer page content is rendered properly', (tester) async {
    const testFilePath = 'test_path';
    final testController = PdfViewerController();

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: PdfViewerPageContent(
            filePath: testFilePath,
            controller: testController,
          ),
        ),
      ),
    );

    expect(find.byType(PdfViewerPageContent), findsOneWidget);
    expect(find.byType(PdfCurrentPageDisplay), findsOneWidget);
    expect(find.byType(PdfZoomLevelDisplay), findsOneWidget);
  });

  testWidgets(
      'PDF viewer page content adjusts layout for landscape orientation',
      (tester) async {
    const testFilePath = 'test_path';
    final testController = PdfViewerController();

    await tester.binding.setSurfaceSize(const Size(1200, 800));

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: OrientationBuilder(
            builder: (context, orientation) {
              expect(orientation, Orientation.landscape);
              return PdfViewerPageContent(
                filePath: testFilePath,
                controller: testController,
              );
            },
          ),
        ),
      ),
    );

    expect(find.byType(PdfViewerPageContent), findsOneWidget);
  });
}
