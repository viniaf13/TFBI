import 'package:txfb_insurance_flutter/domain/models/models.dart';
import 'package:txfb_insurance_flutter/resources/theme/theme.dart';
import 'package:txfb_insurance_flutter/shared/shared.dart';

class AddressWidget extends StatelessWidget {
  const AddressWidget({
    required this.address,
    this.fontWeight,
    super.key,
  });

  final Address address;
  final FontWeight? fontWeight;

  // Use of toTitleCase assumes response format is all caps. This means any
  // mixed case City or Street names may not display as expected.
  // (e.g. MCHENRY, IL becomes Mchenry vs McHenry)
  @override
  Widget build(BuildContext context) {
    final textStyle =
        context.tfbText.bodyRegularLarge.copyWith(fontWeight: fontWeight);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          address.address1.toTitleCase(),
          style: textStyle,
        ),
        if (address.address2 != null && address.address2!.isNotEmpty)
          Text(
            address.address2!.toTitleCase(),
            style: textStyle,
          ),
        if (address.address3 != null && address.address3!.isNotEmpty)
          Text(
            address.address3!.toTitleCase(),
            style: textStyle,
          ),
        Text(
          address.cityStateZip,
          style: textStyle,
        ),
      ],
    );
  }
}
