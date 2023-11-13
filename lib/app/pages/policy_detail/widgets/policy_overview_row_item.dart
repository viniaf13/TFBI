import 'package:txfb_insurance_flutter/resources/theme/theme.dart';
import 'package:txfb_insurance_flutter/shared/shared.dart';

class PolicyOverviewRowItem extends StatelessWidget {
  const PolicyOverviewRowItem({
    required this.title,
    required this.value,
    required this.icon,
    super.key,
  });

  final String title;
  final String value;
  final String icon;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: kSpacingSmall),
      child: Row(
        children: [
          Image.asset(icon, width: kSpacingLarge),
          const SizedBox(width: kSpacingSmall),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: context.tfbText.caption,
              ),
              Text(
                value,
                style: context.tfbText.bodyRegularLarge,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
