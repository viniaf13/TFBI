import 'package:txfb_insurance_flutter/resources/theme/theme.dart';
import 'package:txfb_insurance_flutter/shared/shared.dart';

class ClaimDetailsExpandIconRow extends StatelessWidget {
  const ClaimDetailsExpandIconRow({required this.expandIcon, super.key});

  final ExpandCardIcon expandIcon;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: kSpacingSmall,
        horizontal: kSpacingMedium,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            context.getLocalizationOf.details,
            style: context.tfbText.bodyMediumSmall.copyWith(
              color: LightColors.primary,
            ),
          ),
          expandIcon,
        ],
      ),
    );
  }
}
