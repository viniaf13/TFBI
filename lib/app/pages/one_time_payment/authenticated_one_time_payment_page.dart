import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:plugin_haven/haven.dart';
import 'package:txfb_insurance_flutter/device/cookies/tfb_authenticated_payments_cookie_manager.dart';
import 'package:txfb_insurance_flutter/resources/theme/colors/tfb_brand_colors.dart';
import 'package:txfb_insurance_flutter/shared/widgets/tfb_animated_app_bar.dart';
import 'package:txfb_insurance_flutter/shared/widgets/tfb_brand_loading_icon.dart';
import 'package:txfb_insurance_flutter/texas_farm_bureau_insurance.dart';

class AuthenticatedOneTimePaymentPage extends StatelessWidget {
  const AuthenticatedOneTimePaymentPage({
    required this.policy,
    required this.paymentsCookieManager,
    super.key,
  });

  final PolicySummary policy;
  final TfbAuthenticatedPaymentsCookieManager paymentsCookieManager;

  @override
  Widget build(BuildContext context) {
    final isDone = ValueNotifier(false);

    // Provide a minimum progress of 5% so the user doesn't think
    // nothing is happening
    const minProgress = 0.05;
    final progress = ValueNotifier<double>(minProgress);

    paymentsCookieManager
        .clearAllCookies()
        .then((_) => paymentsCookieManager.setAllAuthPaymentCookies())
        .then((_) => isDone.value = true);

    return Scaffold(
      appBar: const TfbAnimatedAppBar(
        showBackButton: true,
      ),
      body: ValueListenableBuilder(
        valueListenable: isDone,
        builder: (context, value, child) {
          if (!value) return const TfbBrandLoadingIcon();

          return Stack(
            children: [
              SizedBox(
                child: InAppWebView(
                  key: GlobalKey(),
                  initialUrlRequest: URLRequest(
                    url: context
                        .getEnvironment<TfbEnvironment>()
                        .createPaymentUri(
                          policy.policyType,
                          policy.policyNumber,
                        ),
                  ),
                  onProgressChanged: (controller, localProgress) {
                    progress.value =
                        max(localProgress.toDouble() / 100, minProgress);
                  },
                ),
              ),
              ValueListenableBuilder(
                valueListenable: progress,
                builder: (context, value, state) {
                  return LinearProgressIndicator(
                    value: value,
                    backgroundColor: TfbBrandColors.grayLow,
                  );
                },
              ),
            ],
          );
        },
      ),
    );
  }
}
