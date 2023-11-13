import 'package:txfb_insurance_flutter/domain/models/models.dart';
import 'package:txfb_insurance_flutter/resources/theme/theme.dart';
import 'package:txfb_insurance_flutter/shared/shared.dart';

class DriverListItem extends StatelessWidget {
  const DriverListItem(
    this.driver, {
    super.key,
  });

  final Driver driver;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          driver.fullName.toTitleCase(),
          style: context.tfbText.bodyMediumLarge,
        ),
        Padding(
          padding: const EdgeInsets.only(
            top: kSpacingExtraSmall,
            left: kSpacingSmall,
            bottom: kSpacingSmall,
          ),
          child: !driver.hasInformationError
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${context.getLocalizationOf.yearOfBirthLabel}: ${driver.yearOfBirth}',
                      style: context.tfbText.bodyRegularLarge,
                    ),
                    Text(
                      '${context.getLocalizationOf.driversLicenseLabel}: ${driver.obfuscatedLicense}',
                      style: context.tfbText.bodyRegularLarge,
                    ),
                  ],
                )
              : Text(
                  context.getLocalizationOf.noInformationToDisplay,
                  style: context.tfbText.bodyRegularLarge,
                ),
        ),
      ],
    );
  }
}
