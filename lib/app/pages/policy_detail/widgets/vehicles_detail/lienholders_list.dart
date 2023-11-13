import 'package:txfb_insurance_flutter/app/pages/policy_detail/widgets/policy_detail_information_item.dart';
import 'package:txfb_insurance_flutter/domain/models/policy/auto_policy_detail.dart';
import 'package:txfb_insurance_flutter/resources/theme/theme.dart';
import 'package:txfb_insurance_flutter/shared/shared.dart';

class LienholdersList extends StatelessWidget {
  const LienholdersList({
    required this.lienHolders,
    super.key,
  });

  final List<LienHolder> lienHolders;

  @override
  Widget build(BuildContext context) {
    return PolicyDetailInformationItem(
      title: context.getLocalizationOf.lienHoldersCoverageLabel,
      children: lienHolders.map((LienHolder lienHolder) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              lienHolder.name,
              style: context.tfbText.bodyRegularSmall,
            ),
            Text(
              '${lienHolder.address.address1} ${lienHolder.address.city.toCapitalized()}, ${lienHolder.address.state} ${lienHolder.address.zipCode}',
              style: context.tfbText.bodyRegularSmall,
            ),
          ],
        );
      }).toList(),
    );
  }
}
