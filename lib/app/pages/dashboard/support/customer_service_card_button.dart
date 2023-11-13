import 'package:txfb_insurance_flutter/app/pages/dashboard/support/support_section_button.dart';
import 'package:txfb_insurance_flutter/app/router/router.dart';
import 'package:txfb_insurance_flutter/resources/theme/theme.dart';
import 'package:txfb_insurance_flutter/shared/shared.dart';

class CustomerServiceCardButton extends StatelessWidget {
  const CustomerServiceCardButton({super.key});

  @override
  Widget build(BuildContext context) {
    return SupportSectionButton(
      label: context.getLocalizationOf.customerService.toCapitalized(),
      onTap: context.navigator.pushCustomerServicePage,
    );
  }
}
