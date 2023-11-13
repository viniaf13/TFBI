import 'package:txfb_insurance_flutter/resources/theme/theme.dart';
import 'package:txfb_insurance_flutter/shared/shared.dart';

class CommunicationPreferences extends StatelessWidget {
  const CommunicationPreferences({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: kSpacingSmall),
          child: Text(
            context.getLocalizationOf.primaryAccountHolderNameLabel,
            style: context.tfbText.caption,
          ),
        ),
        Text(
          context.user?.memberName?.toTitleCase() ??
              context.getLocalizationOf.noUserFound,
          style: context.tfbText.subHeaderRegular.copyWith(
            color: LightColors.primary,
          ),
        ),
        const SizedBox(
          height: kSpacingLarge,
        ),
        Text(
          context.getLocalizationOf.communicationPreferencesTitle,
          style: context.tfbText.subHeaderRegular.copyWith(
            color: TfbBrandColors.blueHighest,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(
            bottom: kSpacingMedium,
            top: kSpacingSmall,
          ),
          child: Text(
            context.getLocalizationOf.communicationPreferencesBody,
            style: context.tfbText.bodyMediumSmall,
          ),
        ),
      ],
    );
  }
}
