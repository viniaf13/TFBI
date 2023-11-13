import 'package:txfb_insurance_flutter/resources/theme/theme.dart';
import 'package:txfb_insurance_flutter/shared/shared.dart';
import 'package:txfb_insurance_flutter/shared/widgets/text_with_url.dart';

class AppInfoLink extends StatelessWidget {
  const AppInfoLink({
    required this.displayLabel,
    required this.urlForLaunch,
    super.key,
  });

  final String displayLabel;
  final String urlForLaunch;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: kSpacingMedium),
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.only(right: kSpacingSmall),
            child: Image.asset(
              TfbAssetStrings.externalLinkIcon,
              height: 16,
              width: 16,
            ),
          ),
          TextWithUrl(
            urlForDisplay: displayLabel,
            urlForLaunch: urlForLaunch,
            styleForUrl: context.tfbText.bodyMediumLarge
                .copyWith(color: TfbBrandColors.blueHigh),
          ),
        ],
      ),
    );
  }
}
