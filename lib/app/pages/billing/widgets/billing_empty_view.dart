import 'package:txfb_insurance_flutter/resources/theme/theme.dart';
import 'package:txfb_insurance_flutter/shared/shared.dart';
import 'package:txfb_insurance_flutter/shared/widgets/text_with_padding.dart';

class BillingEmptyView extends StatelessWidget {
  const BillingEmptyView({super.key});

  @override
  Widget build(BuildContext context) {
    return TextWithPadding(
      padding: const EdgeInsets.symmetric(horizontal: kSpacingLarge),
      textData: context.getLocalizationOf.billingEmptyMessage,
      style: context.tfbText.bodyMediumSmall.copyWith(
        color: TfbBrandColors.blueHighest,
      ),
    );
  }
}
