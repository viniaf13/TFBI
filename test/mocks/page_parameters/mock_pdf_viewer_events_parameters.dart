import 'package:txfb_insurance_flutter/app/pages/pdf_viewer/tfb_pdf_viewer.dart';

abstract class MockPdfViewerEventsParameters {
  static PdfViewerEventsParameters getEventsParameters() {
    return PdfViewerEventsParameters(
      screenName: 'screen name',
      cta: 'cta',
    );
  }
}
