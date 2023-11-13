import 'package:txfb_insurance_flutter/resources/theme/theme.dart';
import 'package:txfb_insurance_flutter/shared/shared.dart';
import 'package:txfb_insurance_flutter/shared/widgets/text_with_phone.dart';

class CustomerServicePhoneNumbers extends StatelessWidget {
  const CustomerServicePhoneNumbers({
    required this.phone,
    super.key,
  });

  final MapEntry<String, String> phone;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        bottom: kSpacingMedium,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(
              bottom: kSpacingExtraSmall,
            ),
            child: Text(
              '${phone.key}:',
              style: context.tfbText.bodyRegularLarge.copyWith(
                color: TfbBrandColors.blueHighest,
              ),
            ),
          ),
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(
                  right: kSpacingSmall,
                ),
                child: Image.asset(
                  TfbAssetStrings.phoneIcon,
                  width: 16,
                  height: 16,
                ),
              ),
              TextWithPhone(
                phoneNumberForDisplay: phone.value,
                phoneNumberForDialing: phone.value,
                styleForPhoneNumber: context.tfbText.bodyMediumLarge.copyWith(
                  color: TfbBrandColors.blueHigh,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
