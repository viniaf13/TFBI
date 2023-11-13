import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:txfb_insurance_flutter/app/analytics/analytics.dart';
import 'package:txfb_insurance_flutter/app/blocs/autopay/autopay_bloc.dart';
import 'package:txfb_insurance_flutter/app/cubits/billing/autopay_enrollment/routing_number_validation_cubit.dart';
import 'package:txfb_insurance_flutter/app/pages/billing/auto_pay_enrollment/auto_pay_enrollment_cancel_modal.dart';
import 'package:txfb_insurance_flutter/app/pages/billing/auto_pay_enrollment/widgets/account_info_form.dart';
import 'package:txfb_insurance_flutter/app/pages/billing/auto_pay_enrollment/widgets/autopay_enrollment_button.dart';
import 'package:txfb_insurance_flutter/app/pages/billing/auto_pay_enrollment/widgets/autopay_subheader.dart';
import 'package:txfb_insurance_flutter/app/pages/billing/auto_pay_enrollment/widgets/autopay_terms_checkbox.dart';
import 'package:txfb_insurance_flutter/app/pages/billing/auto_pay_enrollment/widgets/bank_account_selector.dart';
import 'package:txfb_insurance_flutter/app/pages/billing/auto_pay_enrollment/widgets/discontinue_autopay_button.dart';
import 'package:txfb_insurance_flutter/app/pages/billing/auto_pay_enrollment/widgets/draft_day_selector.dart';
import 'package:txfb_insurance_flutter/app/router/router.dart';
import 'package:txfb_insurance_flutter/domain/domain.dart';
import 'package:txfb_insurance_flutter/domain/models/billing/account_info_form_data.dart';
import 'package:txfb_insurance_flutter/domain/models/billing/autopay_form_state.dart';
import 'package:txfb_insurance_flutter/resources/theme/colors/colors.dart';
import 'package:txfb_insurance_flutter/shared/mixins/full_screen_loading_overlay_mixin.dart';
import 'package:txfb_insurance_flutter/shared/shared.dart';
import 'package:txfb_insurance_flutter/shared/widgets/tfb_animated_app_bar.dart';
import 'package:txfb_insurance_flutter/shared/widgets/tfb_dropshadow_scroll_widget.dart';

class AutoPayEnrollmentPage extends StatefulWidget {
  const AutoPayEnrollmentPage({required this.policy, super.key});

  final PolicySummary policy;

  @override
  State<AutoPayEnrollmentPage> createState() => _AutoPayEnrollmentPageState();
}

class _AutoPayEnrollmentPageState extends State<AutoPayEnrollmentPage>
    with FullScreenLoadingOverlay {
  final isFormValid = ValueNotifier(false);
  final accountInfoData =
      ValueNotifier<AccountInfoFormData>(AccountInfoFormData.empty());
  final areTermsChecked = ValueNotifier(false);
  final draftDay = TextEditingController();
  final accountType =
      ValueNotifier<AutopayAccountType>(AutopayAccountType.checkings);

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool cancelDialogShowing = false;

  @override
  Widget build(BuildContext context) {
    final String autoPayHeader = widget.policy.isAutoPayEnabled
        ? context.getLocalizationOf.manageAutoPay
        : context.getLocalizationOf.enrollInAutoPay;

    final autoPayEnrollmentCancelModal = AutoPayEnrollmentCancelModal(
      policy: widget.policy,
      onConfirm: () {
        TfbAnalytics.instance.track(
          widget.policy.isAutoPayEnabled
              ? const EnrollInAutoPayCancelModalEvent()
              : const UpdateAutoPayCancelModalEvent(),
        );
        BlocProvider.of<AutopayBloc>(context).add(CancelledAutopayEnrollment());
        Navigator.pop(context);
      },
    );

    return ScaffoldMessenger(
      child: Scaffold(
        appBar: TfbAnimatedAppBar(
          onCancelPressed: () async {
            cancelDialogShowing = true;
            await showDialog<bool>(
              context: context,
              builder: (dialogContext) => autoPayEnrollmentCancelModal,
            );
            cancelDialogShowing = false;
          },
          showCancelButton: true,
          automaticallyImplyLeading: false,
          titleString: autoPayHeader,
          backgroundColor: TfbBrandColors.grayLow,
        ),
        body: GradientBackground(
          gradient: LightColors.authenticationBackgroundGradient,
          child: ScrollableViewWithPinnedButton(
            button: ListenableBuilder(
              listenable: Listenable.merge([
                isFormValid,
                areTermsChecked,
                draftDay,
              ]),
              builder: (context, _) => AutopayEnrollmentButton(
                isFormValid: isFormValid.value,
                areTermsChecked: areTermsChecked.value,
                accountInfo: accountInfoData.value,
                accountType: accountType.value,
                draftDay: draftDay.text,
                policy: widget.policy,
              ),
            ),
            child: MultiBlocListener(
              listeners: [
                BlocListener<RoutingValidationCubit, RoutingValidationState>(
                  listener: (context, state) => (state
                          is RoutingValidationFailureState)
                      ? context.showErrorSnackBar(text: state.error.message)
                      : ScaffoldMessenger.of(context).removeCurrentSnackBar(),
                ),
                BlocListener<AutopayBloc, AutopayState>(
                  listener: (context, state) {
                    hideFullscreenLoadingOverlay();
                    ScaffoldMessenger.of(context).removeCurrentSnackBar();

                    if (state is AutopayProcessing) {
                      showFullscreenLoadingOverlay();
                    } else if (state is AutopaySuccessful) {
                      context.navigator
                          .pushAutoPayEnrollmentSuccess(widget.policy);
                    } else if (state is AutopayFailed) {
                      context.showErrorSnackBar(text: state.error.message);
                    }
                  },
                ),
              ],
              child: WillPopScope(
                onWillPop: () async {
                  // If we are processing, prevent the screen from popping.
                  if (context.read<AutopayBloc>().state is AutopayProcessing ||
                      cancelDialogShowing) {
                    return false;
                  }

                  // Otherwise, show the cancellation dialog and keep track of whether
                  // the dialog is showing or not, otherwise multiple back presses
                  // will stack dialogs and overlays
                  cancelDialogShowing = true;
                  final bool? result = await showDialog<bool>(
                    context: context,
                    builder: (dialogContext) => autoPayEnrollmentCancelModal,
                  );
                  cancelDialogShowing = false;
                  return result ?? true;
                },
                child: TfbDropShadowScrollWidget(
                  showFooterShadow: true,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: kSpacingExtraLarge,
                    ),
                    child: ListView(
                      addSemanticIndexes: false,
                      children: [
                        Text(
                          autoPayHeader,
                          style: context.tfbText.header3.copyWith(
                            color: TfbBrandColors.blueHighest,
                          ),
                        ),
                        AutopaySubheader(policy: widget.policy),
                        AccountInfoForm(
                          formKey: _formKey,
                          isFormValid: isFormValid,
                          accountInfoData: accountInfoData,
                        ),
                        BankAccountSelector(accountType: accountType),
                        Padding(
                          padding: const EdgeInsets.only(top: kSpacingMedium),
                          child: DraftDaySelector(draftDay: draftDay),
                        ),
                        AutopayTermsCheckbox(checked: areTermsChecked),
                        if (widget.policy.isAutoPayEnabled)
                          DiscontinueAutoPayButton(policy: widget.policy),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
