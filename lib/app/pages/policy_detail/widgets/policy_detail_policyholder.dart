import 'package:txfb_insurance_flutter/app/pages/policy_detail/widgets/policy_detail_widgets.dart';
import 'package:txfb_insurance_flutter/resources/theme/theme.dart';
import 'package:txfb_insurance_flutter/texas_farm_bureau_insurance.dart';

class PolicyDetailPolicyHolder extends StatelessWidget {
  const PolicyDetailPolicyHolder({
    required this.detail,
    super.key,
  });

  final PolicyDetail detail;

  @override
  Widget build(BuildContext context) {
    String name = (detail.namedInsuredOne ?? '').toTitleCase();
    if (detail.namedInsuredTwo != null) {
      name += ', ${detail.namedInsuredTwo!.toTitleCase()}';
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        PolicyDetailCardTitle(
          title: context.getLocalizationOf.policyHolderCardTitle,
        ),
        Text(
          name,
          style: context.tfbText.bodyMediumLarge,
        ),
        if (detail.fullAddress != null)
          Padding(
            padding: const EdgeInsets.only(
              left: kSpacingSmall,
              top: kSpacingExtraSmall,
            ),
            child: AddressWidget(address: detail.fullAddress!),
          ),
      ],
    );
  }
}
