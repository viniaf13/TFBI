import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:txfb_insurance_flutter/app/cubits/billing_document_pdf/billing_document_pdf_cubit.dart';
import 'package:txfb_insurance_flutter/app/pages/pdf_viewer/tfb_pdf_viewer.dart';
import 'package:txfb_insurance_flutter/domain/models/billing/billing_list_metadata.dart';
import 'package:txfb_insurance_flutter/domain/models/policy/policy_summary.dart';

class BillingDocumentPdfViewerPage extends StatelessWidget {
  const BillingDocumentPdfViewerPage({
    required this.params,
    super.key,
  });

  final BillingDocumentPdfViewerPageParameters params;

  @override
  Widget build(BuildContext context) {
    return ScaffoldMessenger(
      child: Scaffold(
        body: BlocBuilder<BillingDocumentPdfCubit, BillingDocumentPdfState>(
          builder: (context, state) {
            if (state is BillingDocumentPdfInitial) {
              context
                  .read<BillingDocumentPdfCubit>()
                  .getBillingDocument(params.policySummary, params.metadata);
            }

            return TfbPdfViewer(
              title: params.metadata.labelDescription,
              filePath:
                  state is BillingDocumentPdfSuccess ? state.filePath : '',
              isLoading: state is BillingDocumentPdfInitial ||
                  state is BillingDocumentPdfProcessing,
              isError: state is BillingDocumentPdfError,
              isSuccess: state is BillingDocumentPdfSuccess,
              pdfViewerEventsParameters: params.pdfViewerEventsParameters ??
                  PdfViewerEventsParameters(),
            );
          },
        ),
      ),
    );
  }
}

class BillingDocumentPdfViewerPageParameters {
  BillingDocumentPdfViewerPageParameters({
    required this.policySummary,
    required this.metadata,
    this.pdfViewerEventsParameters,
  });

  final PolicySummary policySummary;
  final BillingListMetadata metadata;
  final PdfViewerEventsParameters? pdfViewerEventsParameters;
}
