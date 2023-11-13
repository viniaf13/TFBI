import 'package:txfb_insurance_flutter/resources/theme/theme.dart';
import 'package:txfb_insurance_flutter/shared/shared.dart';

class PolicyDetailInformationItem extends StatelessWidget {
  const PolicyDetailInformationItem({
    required this.title,
    required this.children,
    this.titleStyle,
    super.key,
  });

  final String title;
  final List<Widget> children;
  final TextStyle? titleStyle;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: kSpacingLarge),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: titleStyle ?? context.tfbText.bodyMediumLarge,
          ),
          Padding(
            padding: const EdgeInsets.only(
              top: kSpacingExtraSmall,
              left: kSpacingSmall,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: children.isEmpty
                  ? [
                      Text(
                        context.getLocalizationOf.emptyLabel,
                        style: context.tfbText.bodyRegularSmall,
                      ),
                    ]
                  : children,
            ),
          ),
        ],
      ),
    );
  }
}
