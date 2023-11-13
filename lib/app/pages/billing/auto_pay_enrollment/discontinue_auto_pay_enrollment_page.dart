import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:txfb_insurance_flutter/app/blocs/autopay/autopay_bloc.dart';
import 'package:txfb_insurance_flutter/app/pages/billing/auto_pay_enrollment/widgets/discontinue_autopay_terms_checkbox.dart';
import 'package:txfb_insurance_flutter/app/router/tfb_navigator.dart';
import 'package:txfb_insurance_flutter/resources/theme/theme.dart';
import 'package:txfb_insurance_flutter/shared/widgets/tfb_animated_app_bar.dart';
import 'package:txfb_insurance_flutter/shared/widgets/tfb_dropshadow_scroll_widget.dart';
import 'package:txfb_insurance_flutter/texas_farm_bureau_insurance.dart';

class DiscontinueAutoPayEnrollmentPage extends StatefulWidget {
  const DiscontinueAutoPayEnrollmentPage({required this.policy, super.key});

  final PolicySummary policy;

  @override
  State<DiscontinueAutoPayEnrollmentPage> createState() =>
      _DiscontinueAutoPayEnrollmentPageState();
}

class _DiscontinueAutoPayEnrollmentPageState
    extends State<DiscontinueAutoPayEnrollmentPage> {
  @override
  Widget build(BuildContext context) {
    final areTermsChecked = ValueNotifier(false);

    return ScaffoldMessenger(
      child: Scaffold(
        appBar: TfbAnimatedAppBar(
          titleString: context.getLocalizationOf.autopayEnrollDiscontinueTitle,
          automaticallyImplyLeading: false,
          showCancelButton: true,
          onCancelPressed: context.navigator.pop,
        ),
        body: SafeArea(
          child: ScrollableViewWithPinnedButton(
            button: ValueListenableBuilder<bool>(
              valueListenable: areTermsChecked,
              builder: (context, areTermsCheckedValue, child) {
                return TfbFilledButton.primaryTextButton(
                  title: context.getLocalizationOf.discontinueAndDelete,
                  style: context.tfbText.bodyMediumSmall.copyWith(
                    color: areTermsCheckedValue
                        ? TfbBrandColors.white
                        : TfbBrandColors.grayHigh,
                  ),
                  onPressed: areTermsCheckedValue
                      ? () => context.read<AutopayBloc>().add(
                            DisenrollInAutopay(
                              policy: widget.policy,
                              user: context.user!,
                            ),
                          )
                      : null,
                );
              },
            ),
            child: BlocListener<AutopayBloc, AutopayState>(
              listener: (context, state) {
                if (state is AutopayDiscontinueSuccess) {
                  Navigator.of(context)
                    ..pop()
                    ..pop();
                } else if (state is DiscontinueAutopayFailed) {
                  context.showErrorSnackBar(text: state.error.message);
                }
              },
              child: TfbDropShadowScrollWidget(
                showFooterShadow: true,
                child: ListView(
                  padding: const EdgeInsets.symmetric(
                    horizontal: kSpacingExtraLarge,
                  ),
                  addSemanticIndexes: false,
                  children: [
                    Text(
                      context.getLocalizationOf.autopayEnrollDiscontinueTitle,
                      style: context.tfbText.header3.copyWith(
                        color: TfbBrandColors.blueHighest,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        top: kSpacingMedium,
                        bottom: kSpacingLarge,
                      ),
                      child: Text(
                        context
                            .getLocalizationOf.autopayEnrollDiscontinueSubTitle,
                        style: context.tfbText.bodyRegularLarge,
                      ),
                    ),
                    DiscontinueAutopayTermsCheckbox(checked: areTermsChecked),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
