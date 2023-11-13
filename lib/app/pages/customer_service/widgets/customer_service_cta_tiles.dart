import 'package:txfb_insurance_flutter/app/pages/customer_service/widgets/email_us_cta.dart';
import 'package:txfb_insurance_flutter/app/pages/customer_service/widgets/find_an_office_cta.dart';
import 'package:txfb_insurance_flutter/resources/theme/theme.dart';

class CustomerServiceCtaTiles extends StatelessWidget {
  const CustomerServiceCtaTiles({
    this.emailAddress,
    super.key,
  });

  final String? emailAddress;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: ListTile.divideTiles(
        color: TfbBrandColors.grayMedium,
        context: context,
        tiles: [
          const FindAnOfficeCTA(),
          EmailUsCTA(emailAddress: emailAddress),
          const SizedBox.shrink(),
        ],
      ).toList(),
    );
  }
}
