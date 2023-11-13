import 'package:txfb_insurance_flutter/app/pages/customer_service/widgets/customer_service_cta_tiles.dart';
import 'package:txfb_insurance_flutter/app/pages/customer_service/widgets/customer_service_phone_numbers.dart';
import 'package:txfb_insurance_flutter/shared/widgets/no_splash_theme_provider.dart';
import 'package:txfb_insurance_flutter/shared/widgets/tfb_dropshadow_scroll_widget.dart';
import 'package:txfb_insurance_flutter/shared/widgets/tfb_animated_app_bar.dart';
import 'package:txfb_insurance_flutter/resources/theme/theme.dart';
import 'package:txfb_insurance_flutter/shared/shared.dart';

class CustomerServicePage extends StatelessWidget {
  const CustomerServicePage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final phones = {
      context.getLocalizationOf.customerService: kCutomerServicePhoneNumber,
      context.getLocalizationOf.fraudHotline: kFraudHotlinePhoneNumber,
      context.getLocalizationOf.hourClaimsReportingCenter:
          kHourClaimsReportingCenterPhoneNumber,
      context.getLocalizationOf.roadsideAssistance:
          kRoadsideAssistancePhoneNumber,
      context.getLocalizationOf.payByPhone: kPayByPhonePhoneNumber,
    };

    return Scaffold(
      appBar: const TfbAnimatedAppBar(
        showBackButton: true,
      ),
      body: TfbDropShadowScrollWidget(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(
            horizontal: kSpacingExtraLarge,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(
                  bottom: kSpacingLarge,
                ),
                child: Text(
                  context.getLocalizationOf.contactCustomerService,
                  style: context.tfbText.header3.copyWith(
                    color: TfbBrandColors.blueHighest,
                  ),
                ),
              ),
              ...phones.entries.map(
                (mapEntry) => CustomerServicePhoneNumbers(phone: mapEntry),
              ),
              const NoSplashThemeProvider(child: CustomerServiceCtaTiles()),
            ],
          ),
        ),
      ),
    );
  }
}
