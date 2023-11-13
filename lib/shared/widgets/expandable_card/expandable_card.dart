import 'package:txfb_insurance_flutter/resources/theme/theme.dart';
import 'package:txfb_insurance_flutter/shared/shared.dart';
import 'package:txfb_insurance_flutter/shared/widgets/expandable_card/expandable_section_content.dart';

class ExpandableCard extends StatelessWidget {
  const ExpandableCard({
    required this.headerContent,
    required this.expandableSectionLabel,
    this.expandableSectionContent,
    this.headerCrossAxisAlignment = CrossAxisAlignment.center,
    super.key,
  });

  final Widget headerContent;
  final Text expandableSectionLabel;
  final List<Widget>? expandableSectionContent;
  final CrossAxisAlignment headerCrossAxisAlignment;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: TfbBrandColors.white,
        borderRadius: context.radii.defaultRadius,
      ),
      child: Column(
        crossAxisAlignment: headerCrossAxisAlignment,
        children: [
          Padding(
            padding: const EdgeInsets.all(
              kSpacingMedium,
            ),
            child: headerContent,
          ),
          if (expandableSectionContent != null)
            ExpandableSectionContent(
              title: expandableSectionLabel,
              children: expandableSectionContent!,
            ),
        ],
      ),
    );
  }
}
