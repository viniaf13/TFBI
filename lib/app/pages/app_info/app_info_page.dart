import 'package:txfb_insurance_flutter/shared/widgets/tfb_animated_app_bar.dart';
import 'package:txfb_insurance_flutter/resources/theme/theme.dart';
import 'package:txfb_insurance_flutter/shared/shared.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:txfb_insurance_flutter/shared/widgets/tfb_dropshadow_scroll_widget.dart';
import 'package:txfb_insurance_flutter/app/pages/app_info/widgets/widgets.dart';
import 'package:plugin_haven/plugin_haven.dart';
import 'package:txfb_insurance_flutter/device/device.dart';
import 'package:txfb_insurance_flutter/app/analytics/analytics.dart';
import 'package:txfb_insurance_flutter/domain/models/app_info/enums/web_uri_enums.dart';

const libreFranklinUrl =
    'https://scripts.sil.org/cms/scripts/page.php?item_id=OFL-FAQ_web';
const featherIconsUrl =
    'https://raw.githubusercontent.com/feathericons/feather/main/LICENSE';

class AppInfoPage extends StatelessWidget {
  const AppInfoPage({super.key});

  @override
  Widget build(BuildContext context) {
    TfbAnalytics.instance.track(const AppInformationEvent());
    final environment = context.getEnvironment<TfbEnvironment>();

    return Scaffold(
      appBar: TfbAnimatedAppBar(
        titleString: context.getLocalizationOf.appInfoPageTitle,
        showBackButton: true,
      ),
      body: TfbDropShadowScrollWidget(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: kSpacingLarge),
          child: ListView(
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: kSpacingLarge),
                child: Text(
                  context.getLocalizationOf.appInfoPageTitle,
                  style: context.tfbText.header3
                      .copyWith(color: TfbBrandColors.blueHighest),
                ),
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const AppIcon(),
                  Padding(
                    padding: const EdgeInsets.only(left: kSpacingLarge),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Flexible(
                          child: Text(
                            context.getLocalizationOf.appInfoAppTitle,
                            style: context.tfbText.subHeaderRegular
                                .copyWith(color: TfbBrandColors.blueHighest),
                          ),
                        ),
                        FutureBuilder(
                          future: PackageInfo.fromPlatform(),
                          builder: (_, snapshot) {
                            return Text(
                              context.getLocalizationOf.appInfoVersionDisplay(
                                snapshot.data?.buildNumber ?? '',
                                snapshot.data?.version ?? '',
                              ),
                              textAlign: TextAlign.center,
                              style: context.tfbText.bodyRegularSmall,
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SeparatorLine(
                padding:
                    EdgeInsets.only(top: kSpacingLarge, bottom: kSpacingSmall),
              ),
              AppInfoSectionHeader(
                title:
                    context.getLocalizationOf.appInfoDocumentationSectionTitle,
              ),
              AppInfoLink(
                displayLabel:
                    context.getLocalizationOf.appInfoPrivacyNoticeTitle,
                urlForLaunch:
                    environment.createWebsiteUri(WebUriEnum.privacyPolicy),
              ),
              AppInfoLink(
                displayLabel:
                    context.getLocalizationOf.appInfoRequiredNoticesTitle,
                urlForLaunch:
                    environment.createWebsiteUri(WebUriEnum.requiredNotices),
              ),
              AppInfoLink(
                displayLabel:
                    context.getLocalizationOf.appInfoTermsConditionsTitle,
                urlForLaunch:
                    environment.createWebsiteUri(WebUriEnum.termsAndConditions),
              ),
              AppInfoSectionHeader(
                title: context.getLocalizationOf.appInfoBillingSectionTitle,
              ),
              AppInfoLink(
                displayLabel:
                    context.getLocalizationOf.appInfoAssurancePayTitle,
                urlForLaunch:
                    environment.createWebsiteUri(WebUriEnum.assurancePay),
              ),
              AppInfoLink(
                displayLabel: context.getLocalizationOf.appInfoAccountBillTitle,
                urlForLaunch:
                    environment.createWebsiteUri(WebUriEnum.accountBill),
              ),
              AppInfoSectionHeader(
                title: context.getLocalizationOf.appInfoLicensingSectionTitle,
              ),
              AppInfoLink(
                displayLabel:
                    context.getLocalizationOf.appInfoLibreFranklinTitle,
                urlForLaunch: libreFranklinUrl,
              ),
              AppInfoLink(
                displayLabel:
                    context.getLocalizationOf.appInfoFeatherIconsTitle,
                urlForLaunch: featherIconsUrl,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
