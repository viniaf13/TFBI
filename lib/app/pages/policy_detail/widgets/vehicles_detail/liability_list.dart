import 'package:txfb_insurance_flutter/app/pages/policy_detail/widgets/dual_color_list/dual_color_list_item.dart';
import 'package:txfb_insurance_flutter/domain/domain.dart';
import 'package:txfb_insurance_flutter/resources/theme/theme.dart';
import 'package:txfb_insurance_flutter/shared/shared.dart';

class LiabilityList extends StatelessWidget {
  const LiabilityList({
    required this.coverages,
    super.key,
  });

  final List<Coverage> coverages;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: kSpacingSmall),
          child: Text(
            context.getLocalizationOf.liabilityCoverageLabel,
            style: context.tfbText.bodyMediumLarge,
          ),
        ),
        _showListItems(context),
      ],
    );
  }

  Widget _showListItems(BuildContext context) {
    if (coverages.isEmpty) {
      return Text(
        context.getLocalizationOf.emptyLabel,
        style: context.tfbText.bodyRegularSmall,
      );
    }

    return Column(
      children: [
        for (int index = 0; index < coverages.length; index++)
          Container(
            color: index.isEven ? TfbBrandColors.white : null,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                DualColorListItem(
                  label: parseCoverageAttribute(
                    coverages[index].coverageTypeDescription,
                  ),
                  values: coverages[index]
                      .limitDescription
                      .map(parseCoverageAttribute)
                      .toList(),
                ),
              ],
            ),
          ),
      ],
    );
  }

  String parseCoverageAttribute(String attribute) {
    const dictionary = {' each ': '/', ' per ': '/', ' list': ''};
    String parsedAttribute = attribute;

    dictionary.forEach(
      (key, value) => parsedAttribute = parsedAttribute.replaceAll(key, value),
    );

    return parsedAttribute;
  }
}
