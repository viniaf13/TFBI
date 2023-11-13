import 'package:flutter/material.dart';
import 'package:txfb_insurance_flutter/shared/constants/spacing.dart';
import 'package:txfb_insurance_flutter/shared/extensions/extensions.dart';
import 'package:txfb_insurance_flutter/resources/theme/colors/colors.dart';
import 'package:txfb_insurance_flutter/shared/widgets/text_with_phone.dart';

class DriversAndVehiclesHeader extends StatelessWidget {
  const DriversAndVehiclesHeader({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Semantics(
          label: context.getLocalizationOf.driversAndVehiclesHeaderTitle,
          child: Text(
            context.getLocalizationOf.driversAndVehiclesHeaderTitle,
            style: context.tfbText.subHeaderRegular
                .copyWith(color: TfbBrandColors.blueHighest),
          ),
        ),
        const SizedBox(height: kSpacingSmall),
        Semantics(
          label: context.getLocalizationOf.driversAndVehiclesSubtitle,
          child: TextWithPhone(
            prePhoneNumberString:
                context.getLocalizationOf.driversAndVehiclesSubtitle,
            phoneNumberForDisplay:
                context.getLocalizationOf.claimsHeaderPhoneNumber,
            phoneNumberForDialing: '800-266-5458',
            postPhoneNumberString:
                context.getLocalizationOf.claimsHeaderPhonePostfix,
            styleForPhoneNumber: context.tfbText.bodyRegularLarge
                .copyWith(color: TfbBrandColors.blueHigh),
            styleForBodyText: context.tfbText.bodyRegularLarge
                .copyWith(color: TfbBrandColors.grayHighest),
          ),
        ),
      ],
    );
  }
}
