import 'package:txfb_insurance_flutter/resources/theme/theme.dart';
import 'package:txfb_insurance_flutter/shared/shared.dart';

class CardTitle extends StatelessWidget {
  const CardTitle({
    required this.title,
    super.key,
  });

  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(
        kSpacingMedium,
        kSpacingMedium,
        kSpacingMedium,
        0,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: context.tfbText.subHeaderRegular.copyWith(
              color: TfbBrandColors.blueHighest,
            ),
          ),
          const SeparatorLine(),
        ],
      ),
    );
  }
}
