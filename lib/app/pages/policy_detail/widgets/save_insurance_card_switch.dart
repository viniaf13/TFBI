import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:txfb_insurance_flutter/app/analytics/analytics.dart';
import 'package:txfb_insurance_flutter/app/cubits/save_auto_id_card/save_auto_id_card_cubit.dart';
import 'package:txfb_insurance_flutter/resources/theme/theme.dart';
import 'package:txfb_insurance_flutter/shared/widgets/processing_snackbar_icon.dart';
import 'package:txfb_insurance_flutter/texas_farm_bureau_insurance.dart';

class SaveInsuranceCardSwitch extends StatefulWidget {
  const SaveInsuranceCardSwitch({
    required this.policySummary,
    required this.policyDetails,
    super.key,
  });

  final PolicySummary policySummary;
  final AutoPolicyDetail policyDetails;

  @override
  State<SaveInsuranceCardSwitch> createState() =>
      _SaveInsuranceCardSwitchState();
}

class _SaveInsuranceCardSwitchState extends State<SaveInsuranceCardSwitch> {
  @override
  void initState() {
    super.initState();

    BlocProvider.of<SaveAutoIdCardCubit>(context).getIsIdCardSaved(
      widget.policySummary,
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SaveAutoIdCardCubit, SaveAutoIdCardState>(
      listener: _saveAutoIdCardListener,
      builder: (context, state) {
        return AnimatedOpacity(
          opacity: state is SaveAutoIdCardProcessing ? 0.4 : 1.0,
          duration: const Duration(milliseconds: 300),
          child: IgnorePointer(
            ignoring: state is SaveAutoIdCardProcessing,
            child: SwitchListTile(
              contentPadding: const EdgeInsets.all(0),
              title: Text(
                context
                    .getLocalizationOf.insuranceCardAvailableOfflineSwitchLabel,
                style: context.tfbText.bodyMediumSmall.copyWith(
                  color: TfbBrandColors.grayHighest,
                ),
              ),
              value: state is SaveAutoIdCardSuccess &&
                  !state.idCardMetadata.documentIsTemporary,
              onChanged: (value) {
                if (value) {
                  BlocProvider.of<SaveAutoIdCardCubit>(context)
                      .downloadAndSaveAutoIdCard(
                    widget.policySummary,
                    widget.policyDetails,
                    isTemporary: false,
                    showLoadingSnackbar: true,
                  );

                  TfbAnalytics.instance.track(
                    InsuranceCardOfflineToggleActiveEvent(
                      widget.policySummary.policyType.name(context),
                      widget.policySummary.policyNumber,
                      context.screenName,
                    ),
                  );
                } else if (state is SaveAutoIdCardSuccess) {
                  BlocProvider.of<SaveAutoIdCardCubit>(context)
                      .removeSavedAutoIdCard(
                    state.idCardMetadata,
                  );
                }
              },
            ),
          ),
        );
      },
    );
  }

  void _saveAutoIdCardListener(
    BuildContext context,
    SaveAutoIdCardState state,
  ) {
    if (state is SaveAutoIdCardProcessing && state.showSnackbar) {
      context.showProcessingSnackBar(
        text: context.getLocalizationOf.insuranceCardSaveProcessing,
        icon: const ProcessingSnackbarIcon(),
      );
    } else if (state is SaveAutoIdCardFailure ||
        state is SaveAutoIdCardFailure) {
      context.showErrorSnackBar(
        text: context.getLocalizationOf.somethingWentWrong,
      );
    } else if (state is SaveAutoIdCardSuccess && state.showSnackbar) {
      context.showSuccessSnackBar(
        text: context.getLocalizationOf.insuranceCardSaveSuccess,
        icon: Image.asset(TfbAssetStrings.checkCircleIcon),
      );
    } else if (state is SaveAutoIdCardUncached && state.showSnackbar) {
      context.showSuccessSnackBar(
        text: context.getLocalizationOf.insuranceCardRemoveSuccess,
        icon: Image.asset(TfbAssetStrings.checkCircleIcon),
      );
    }
  }
}
