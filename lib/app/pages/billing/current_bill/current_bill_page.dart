import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:txfb_insurance_flutter/app/cubits/billing/current_bill/current_billing_doc_cubit.dart';
import 'package:txfb_insurance_flutter/app/pages/pdf_viewer/tfb_pdf_viewer.dart';
import 'package:txfb_insurance_flutter/domain/models/policy/policy_summary.dart';
import 'package:txfb_insurance_flutter/shared/shared.dart';

class CurrentBillPageParameters {
  CurrentBillPageParameters({
    required this.policySummary,
    this.pdfViewerEventsParameters,
  });

  final PolicySummary policySummary;
  final PdfViewerEventsParameters? pdfViewerEventsParameters;
}

class CurrentBillPage extends StatelessWidget {
  const CurrentBillPage({
    required this.params,
    super.key,
  });

  final CurrentBillPageParameters params;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CurrentBillingDocCubit, CurrentBillingDocState>(
      builder: (context, state) {
        if (state is CurrentBillingDocInitState) {
          BlocProvider.of<CurrentBillingDocCubit>(context)
              .fetchCurrentBillingDocument(params.policySummary);
        }

        final loadingState = state is! CurrentBillingDocFailureState &&
            state is! CurrentBillingDocSuccessState;

        return TfbPdfViewer(
          title:
              '${context.getLocalizationOf.policy} #${params.policySummary.policyNumber}',
          filePath:
              (state is CurrentBillingDocSuccessState) ? state.filePath : '',
          isLoading: loadingState,
          isError: state is CurrentBillingDocFailureState,
          isSuccess: state is CurrentBillingDocSuccessState,
          pdfViewerEventsParameters:
              params.pdfViewerEventsParameters ?? PdfViewerEventsParameters(),
        );
      },
    );
  }
}
