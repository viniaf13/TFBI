import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:txfb_insurance_flutter/app/cubits/auto_policy_document_pdf/auto_policy_document_pdf_cubit.dart';
import 'package:txfb_insurance_flutter/app/pages/pdf_viewer/tfb_pdf_viewer.dart';
import 'package:txfb_insurance_flutter/domain/models/policy/policy_list_metadata.dart';
import 'package:txfb_insurance_flutter/domain/models/policy/policy_summary.dart';
import 'package:txfb_insurance_flutter/resources/theme/theme.dart';
import 'package:txfb_insurance_flutter/shared/shared.dart';

class PolicyDocumentPage extends StatelessWidget {
  const PolicyDocumentPage({
    required this.params,
    super.key,
  });

  final PolicyDocumentPageParameters params;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AutoPolicyDocumentPdfCubit, AutoPolicyDocumentPdfState>(
      builder: (context, state) {
        if (state is AutoPolicyDocumentPdfInitial) {
          if (params.documentMetadata != null) {
            BlocProvider.of<AutoPolicyDocumentPdfCubit>(context)
                .getPolicyDocumentMetadata(
              params.policySummary,
              params.documentMetadata!,
            );
          }
          if (params.documentUrl != null && params.documentName != null) {
            BlocProvider.of<AutoPolicyDocumentPdfCubit>(context)
                .getStaticPolicyDocumentMetadata(
              params.policySummary,
              params.documentUrl!,
              params.documentName!,
            );
          }
        }

        final loadingState = state is AutoPolicyDocumentPdfProcessing ||
            state is AutoPolicyDocumentPdfInitial;

        return WillPopScope(
          onWillPop: () async {
            BlocProvider.of<AutoPolicyDocumentPdfCubit>(context)
                .deletePolicyDocumentsFromTemporary();

            return true;
          },
          child: Scaffold(
            body: TfbPdfViewer(
              title: '${context.getLocalizationOf.policy}'
                  ' #${params.policySummary.policyNumber}',
              filePath:
                  (state is AutoPolicyDocumentPdfSuccess) ? state.filePath : '',
              isLoading: loadingState,
              isError: state is AutoPolicyDocumentPdfError,
              isSuccess: state is AutoPolicyDocumentPdfSuccess,
              pdfViewerEventsParameters: params.pdfViewerEventsParameters ??
                  PdfViewerEventsParameters(),
            ),
          ),
        );
      },
    );
  }
}

class PolicyDocumentPageParameters {
  PolicyDocumentPageParameters({
    required this.policySummary,
    this.documentMetadata,
    this.documentUrl,
    this.documentName,
    this.pdfViewerEventsParameters,
  });

  final PolicySummary policySummary;
  final PdfViewerEventsParameters? pdfViewerEventsParameters;
  final PolicyListMetadata? documentMetadata;
  final String? documentUrl;
  final String? documentName;
}
