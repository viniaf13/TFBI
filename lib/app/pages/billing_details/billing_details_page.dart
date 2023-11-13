import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:txfb_insurance_flutter/app/blocs/autopay/autopay_bloc.dart';
import 'package:txfb_insurance_flutter/app/cubits/member_summary/member_summary_cubit.dart';
import 'package:txfb_insurance_flutter/app/pages/account/widgets/paperless_notification_preferences.dart';
import 'package:txfb_insurance_flutter/app/pages/billing/paperless_billing/paperless_billing_container.dart';
import 'package:txfb_insurance_flutter/app/pages/billing_details/widgets/billing_document_list/billing_document_list_container.dart';
import 'package:txfb_insurance_flutter/app/pages/billing_details/widgets/billing_payment_list/billing_payment_list_container.dart';
import 'package:txfb_insurance_flutter/app/pages/policy_detail/widgets/policy_detail_card.dart';
import 'package:txfb_insurance_flutter/app/pages/policy_detail/widgets/policy_detail_widgets.dart';
import 'package:txfb_insurance_flutter/domain/models/policy/policy_detail.dart';
import 'package:txfb_insurance_flutter/domain/models/policy/policy_summary.dart';
import 'package:txfb_insurance_flutter/shared/constants/spacing.dart';
import 'package:txfb_insurance_flutter/shared/constants/tfb_asset_strings.dart';
import 'package:txfb_insurance_flutter/shared/enum/widget_location_enum.dart';
import 'package:txfb_insurance_flutter/shared/extensions/extensions.dart';
import 'package:txfb_insurance_flutter/shared/mixins/page_properties_mixin.dart';
import 'package:txfb_insurance_flutter/shared/widgets/tfb_animated_app_bar.dart';
import 'package:txfb_insurance_flutter/shared/widgets/tfb_brand_loading_icon.dart';
import 'package:txfb_insurance_flutter/shared/widgets/tfb_dropshadow_scroll_widget.dart';

class BillingDetailsPage extends StatelessWidget with PagePropertiesMixin {
  const BillingDetailsPage({
    required this.policy,
    this.locationQueryParameters = '',
    super.key,
  });

  @override
  String get screenName => 'Billing screen';

  final PolicySummary policy;
  final String locationQueryParameters;
  final loadingIndicator = const Center(child: TfbBrandLoadingIcon());

  @override
  Widget build(BuildContext context) {
    final String autopayCancelledSuccess = policy.isAutoPayEnabled
        ? context.getLocalizationOf.autoPayManageCancelledSuccess
        : context.getLocalizationOf.autoPayEnrollCancelledSuccess;
    return ScaffoldMessenger(
      child: Scaffold(
        appBar: TfbAnimatedAppBar(
          titleString: context.getLocalizationOf.billingTitle,
          showBackButton: true,
        ),
        body: TfbDropShadowScrollWidget(
          child: BlocListener<AutopayBloc, AutopayState>(
            listener: (context, state) {
              if (state is AutopayCancelled) {
                context.showSuccessSnackBar(
                  text: autopayCancelledSuccess,
                  icon: ImageIcon(
                    AssetImage(TfbAssetStrings.checkCircleIcon),
                  ),
                );
                context.read<AutopayBloc>().add(ResetAutopayBloc());
              } else if (state is AutopayDiscontinueSuccess) {
                context.showSuccessSnackBar(
                  text: context.getLocalizationOf.discontinueAutopaySuccessMsg,
                  icon: ImageIcon(AssetImage(TfbAssetStrings.checkCircleIcon)),
                );
              }
            },
            child: BlocConsumer<MemberSummaryCubit, MemberSummaryState>(
              listener: (context, state) {
                if (state is MemberSummaryFailure) {
                  context.showErrorSnackBar(text: state.error.message);
                }

                if (state is MemberSummaryDetailsSuccess) {
                  final details = state.policyMap[policy.policyNumber];
                  if (details == null || state.error != null) {
                    context.showErrorSnackBar(
                      text: context.getLocalizationOf.somethingWentWrong,
                    );
                  }
                }
              },
              builder: (context, state) {
                if (state is MemberSummaryProcessing) {
                  return loadingIndicator;
                }

                if (state is MemberSummaryDetailsSuccess) {
                  return BillingDetailsList(
                    policy: policy,
                    details: state.policyMap[policy.policyNumber],
                    locationQueryParameters: locationQueryParameters,
                  );
                }

                return loadingIndicator;
              },
            ),
          ),
        ),
      ),
    );
  }
}

class BillingDetailsList extends StatelessWidget {
  const BillingDetailsList({
    required this.policy,
    required this.locationQueryParameters,
    this.details,
    super.key,
  });

  final PolicySummary policy;
  final PolicyDetail? details;
  final String locationQueryParameters;

  @override
  Widget build(BuildContext context) {
    final items = [
      PolicyDetailCard(
        child: PolicyDetailOverview.billing(policy, details),
      ),
      Builder(
        builder: (context) {
          if (locationQueryParameters ==
              WidgetLocationEnum.paymentHistory.name) {
            _scrollToWidget(context);
          }
          return BillingPaymentListContainer(
            policy: policy,
          );
        },
      ),
      Provider.value(
        value: policy,
        child: Builder(
          builder: (context) {
            final shouldScrollToBillingDocuments = locationQueryParameters ==
                WidgetLocationEnum.billingDocuments.name;

            if (shouldScrollToBillingDocuments) {
              _scrollToWidget(context);
            }
            return BillingDocumentListContainer(policy: policy);
          },
        ),
      ),
      Padding(
        padding: const EdgeInsets.fromLTRB(
          // Account for the padding already added by the ListView builder
          kSpacingLarge - kSpacingSmall,
          kSpacingExtraLarge - kSpacingSmall,
          kSpacingLarge - kSpacingSmall,
          0,
        ),
        child: PaperlessNotificationPreferences(
          preferencesCopy:
              context.getLocalizationOf.preferencesDirectionBilling,
        ),
      ),
      PaperlessBillingContainer(policy: policy),
      const SizedBox(
        height: kSpacingMedium,
      ),
    ];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: kSpacingSmall),
      child: ListView.separated(
        separatorBuilder: (context, index) =>
            const SizedBox(height: kSpacingMedium),
        itemCount: items.length,
        itemBuilder: (context, index) => items[index],
      ),
    );
  }

  void _scrollToWidget(BuildContext context) {
    Future.delayed(
      const Duration(milliseconds: 300),
      () {
        if (context.mounted) {
          Scrollable.ensureVisible(
            alignment: 0.28,
            context,
            duration: const Duration(seconds: 1),
          );
        }
      },
    );
  }
}
