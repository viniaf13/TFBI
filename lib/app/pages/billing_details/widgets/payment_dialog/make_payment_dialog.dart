import 'package:flutter/material.dart';
import 'package:plugin_haven/plugin_haven.dart';
import 'package:txfb_insurance_flutter/app/pages/billing_details/widgets/payment_dialog/payment_dialog_button.dart';
import 'package:txfb_insurance_flutter/app/router/router.dart';
import 'package:txfb_insurance_flutter/resources/theme/colors/tfb_brand_colors.dart';
import 'package:txfb_insurance_flutter/texas_farm_bureau_insurance.dart';
import 'package:url_launcher/url_launcher.dart';

class MakePaymentDialog extends StatelessWidget {
  const MakePaymentDialog({required this.policySummary, super.key});

  final PolicySummary policySummary;

  Future<void> _launchURL(String urlForLaunch) async {
    final Uri url = Uri.parse(urlForLaunch);
    await canLaunchUrl(url)
        ? await launchUrl(url)
        : throw 'Could not launch $url';
  }

  @override
  Widget build(BuildContext context) {
    final guestPaymentsUrl =
        context.getEnvironment<TfbEnvironment>().unauthenticatedPaymentsUrl;

    return AlertDialog(
      contentPadding: const EdgeInsets.fromLTRB(
        kSpacingMedium,
        kSpacingSmall,
        kSpacingMedium,
        kSpacingMedium,
      ),
      insetPadding: const EdgeInsets.symmetric(horizontal: kSpacingSmall),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: kSpacingSmall),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  context.getLocalizationOf.makeAPaymentCtaTitle,
                  style: context.tfbText.header3.copyWith(
                    color: TfbBrandColors.blueHighest,
                  ),
                ),
                IconButton(
                  icon: ImageIcon(
                    AssetImage(TfbAssetStrings.closeIcon),
                  ),
                  onPressed: Navigator.of(context).pop,
                  color: TfbBrandColors.grayHighest,
                  style: IconButton.styleFrom(
                    splashFactory: NoSplash.splashFactory,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: kSpacingSmall),
            child: PaymentDialogButton(
              title: context.getLocalizationOf.oneTimePaymentNoFeesTitle,
              subtitle: context.getLocalizationOf.oneTimePaymentNoFeesSubtitle,
              onPressed: () {
                // Dismiss the payment dialog
                Navigator.of(context).pop();

                context.navigator.goToOneTimePaymentsPage(policySummary);
              },
            ),
          ),
          PaymentDialogButton(
            title: context.getLocalizationOf.oneTimePaymentFeesTitle,
            subtitle: context.getLocalizationOf.oneTimePaymentFeesSubtitle,
            onPressed: () {
              // Dismiss the payment dialog
              Navigator.of(context).pop();
              _launchURL(guestPaymentsUrl);
            },
          ),
        ],
      ),
    );
  }
}
