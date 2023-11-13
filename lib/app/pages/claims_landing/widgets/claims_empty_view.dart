import 'package:txfb_insurance_flutter/resources/theme/theme.dart';
import 'package:txfb_insurance_flutter/shared/shared.dart';

class ClaimsEmptyView extends StatelessWidget {
  const ClaimsEmptyView({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(kSpacingMedium),
      child: Text(
        context.getLocalizationOf.claimsEmptyMessage,
        style: context.tfbText.bodyMediumSmall.copyWith(
          color: TfbBrandColors.blueHighest,
        ),
      ),
    );
  }
}
