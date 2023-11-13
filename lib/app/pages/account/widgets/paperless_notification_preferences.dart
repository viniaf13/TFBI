import 'package:txfb_insurance_flutter/resources/theme/theme.dart';
import 'package:txfb_insurance_flutter/shared/shared.dart';
import 'package:txfb_insurance_flutter/shared/widgets/bullet_list.dart';

class PaperlessNotificationPreferences extends StatelessWidget {
  const PaperlessNotificationPreferences({
    required this.preferencesCopy,
    super.key,
  });

  final String preferencesCopy;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          context.getLocalizationOf.paperlessNotificationsHeader,
          style: context.tfbText.subHeaderRegular.copyWith(
            color: TfbBrandColors.blueHighest,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: kSpacingSmall),
          child: Text(
            preferencesCopy,
            style: context.tfbText.bodyMediumSmall,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(
            top: kSpacingMedium,
            bottom: kSpacingSmall,
          ),
          child: Text(
            context.getLocalizationOf.notificationsBenefitList,
            style: context.tfbText.bodyRegularSmall,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(
            left: kSpacingSmall,
            right: kSpacingSmall,
          ),
          child: BulletList(
            [
              context.getLocalizationOf.benefitBulletList1,
              context.getLocalizationOf.benefitBulletList2,
              context.getLocalizationOf.benefitBulletList3,
              context.getLocalizationOf.benefitBulletList4,
            ],
          ),
        ),
      ],
    );
  }
}
