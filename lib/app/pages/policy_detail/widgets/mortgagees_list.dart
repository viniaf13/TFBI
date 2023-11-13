import 'package:txfb_insurance_flutter/app/pages/policy_detail/widgets/policy_detail_information_item.dart';
import 'package:txfb_insurance_flutter/domain/models/policy/mortgagee.dart';
import 'package:txfb_insurance_flutter/resources/theme/theme.dart';
import 'package:txfb_insurance_flutter/shared/shared.dart';

class MortgageesList extends StatelessWidget {
  const MortgageesList({required this.mortgagees, super.key});

  final List<Mortgagee> mortgagees;

  @override
  Widget build(BuildContext context) {
    return PolicyDetailInformationItem(
      title: context.getLocalizationOf.mortgageesCoverageLabel,
      children: mortgagees.map((mortgagee) {
        return Padding(
          padding: const EdgeInsets.only(bottom: kSpacingExtraSmall),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                mortgagee.name.toTitleCase(),
                style: context.tfbText.bodyBoldSmall,
              ),
              Text(
                mortgagee.address.toTitleCase(),
                style: context.tfbText.bodyRegularSmall,
              ),
            ],
          ),
        );
      }).toList(),
    );
  }
}
