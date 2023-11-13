import 'package:flutter/widgets.dart';
import 'package:txfb_insurance_flutter/app/pages/pdf_viewer/tfb_pdf_viewer.dart';

class InsuranceCardViewerPage extends StatelessWidget {
  const InsuranceCardViewerPage({
    required this.params,
    super.key,
  });

  final PdfViewerPageParameters params;

  @override
  Widget build(BuildContext context) {
    return TfbPdfViewer(
      title: params.title,
      filePath: params.filePath,
      isLoading: false,
      isSuccess: true,
      pdfViewerEventsParameters: params.pdfViewerEventsParameters,
    );
  }
}
