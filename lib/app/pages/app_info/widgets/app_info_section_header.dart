import 'package:txfb_insurance_flutter/shared/shared.dart';
import 'package:txfb_insurance_flutter/resources/theme/theme.dart';

class AppInfoSectionHeader extends StatelessWidget {
  const AppInfoSectionHeader({
    required this.title,
    super.key,
  });

  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          const EdgeInsets.only(top: kSpacingMedium, bottom: kSpacingMedium),
      child: Text(
        title,
        style: context.tfbText.subHeaderRegular
            .copyWith(color: TfbBrandColors.blueHighest),
      ),
    );
  }
}
