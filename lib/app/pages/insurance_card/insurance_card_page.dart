import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:txfb_insurance_flutter/app/analytics/analytics.dart';
import 'package:txfb_insurance_flutter/app/analytics/events/insurance_card_pdf_view_event.dart';
import 'package:txfb_insurance_flutter/app/cubits/auto_policy/auto_policy_cubit.dart';
import 'package:txfb_insurance_flutter/app/cubits/save_auto_id_card/save_auto_id_card_cubit.dart';
import 'package:txfb_insurance_flutter/app/pages/pdf_viewer/tfb_pdf_viewer.dart';
import 'package:txfb_insurance_flutter/domain/models/policy/policy_summary.dart';
import 'package:txfb_insurance_flutter/shared/extensions/context_extension.dart';

class InsuranceCardPageParameters {
  InsuranceCardPageParameters({
    required this.policySummary,
    this.pdfViewerEventsParameters,
  });

  final PolicySummary policySummary;
  final PdfViewerEventsParameters? pdfViewerEventsParameters;
}

class InsuranceCardPage extends StatelessWidget {
  const InsuranceCardPage({
    required this.params,
    super.key,
  });

  final InsuranceCardPageParameters params;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AutoPolicyCubit, AutoPolicyState>(
      builder: (context, autoPolicyState) {
        if (autoPolicyState is AutoPolicyInitial) {
          context
              .read<AutoPolicyCubit>()
              .getPersonalAutoPolicy(params.policySummary);
        }

        final loadingStateAutoPolicy =
            autoPolicyState is AutoPolicyProcessing ||
                autoPolicyState is AutoPolicyInitial;

        final errorStateAutoPolicy = autoPolicyState is AutoPolicyFailure;
        final successStateAutoPolicy = autoPolicyState is AutoPolicySuccess;

        return BlocBuilder<SaveAutoIdCardCubit, SaveAutoIdCardState>(
          builder: (context, saveAutoState) {
            if (successStateAutoPolicy &&
                saveAutoState is SaveAutoIdCardInitial) {
              BlocProvider.of<SaveAutoIdCardCubit>(context)
                  .insuranceCardDownload(
                policySummary: params.policySummary,
                autoPolicyDetail: autoPolicyState.autoPolicyDetail,
              );
            }

            final uncachedStateSaveAutoIdCard =
                saveAutoState is SaveAutoIdCardUncached;

            final loadingStateSaveAutoIdCard =
                saveAutoState is SaveAutoIdCardProcessing ||
                    saveAutoState is SaveAutoIdCardInitial;

            final errorStateSaveAutoIdCard =
                saveAutoState is SaveAutoIdCardFailure ||
                    saveAutoState is SaveAutoIdCardFailure;

            final successStateSaveAutoIdCard =
                saveAutoState is SaveAutoIdCardSuccess ||
                    saveAutoState is SaveAutoIdCardSuccess;

            final documentFilePath = saveAutoState is SaveAutoIdCardSuccess
                ? saveAutoState.idCardMetadata.documentPath
                : '';

            if (successStateSaveAutoIdCard && successStateAutoPolicy) {
              TfbAnalytics.instance.track(const InsuranceCardPdfViewEvent());
            }

            return WillPopScope(
              onWillPop: () async {
                if (successStateSaveAutoIdCard &&
                    saveAutoState.idCardMetadata.documentIsTemporary) {
                  BlocProvider.of<SaveAutoIdCardCubit>(context)
                      .removeSavedAutoIdCard(
                    saveAutoState.idCardMetadata,
                    fromTemp: true,
                  );
                }
                return true;
              },
              child: Scaffold(
                body: TfbPdfViewer(
                  title: '${context.getLocalizationOf.policy} '
                      '#${params.policySummary.policyNumber}',
                  filePath: documentFilePath,
                  isLoading: (loadingStateAutoPolicy ||
                          loadingStateSaveAutoIdCard ||
                          uncachedStateSaveAutoIdCard) &&
                      !(errorStateAutoPolicy || errorStateSaveAutoIdCard),
                  isError: errorStateAutoPolicy || errorStateSaveAutoIdCard,
                  isSuccess:
                      successStateSaveAutoIdCard && successStateAutoPolicy,
                  pdfViewerEventsParameters: params.pdfViewerEventsParameters ??
                      PdfViewerEventsParameters(),
                ),
              ),
            );
          },
        );
      },
    );
  }
}
