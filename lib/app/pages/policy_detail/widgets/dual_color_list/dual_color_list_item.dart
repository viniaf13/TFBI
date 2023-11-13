import 'package:txfb_insurance_flutter/resources/theme/theme.dart';
import 'package:txfb_insurance_flutter/shared/shared.dart';

class DualColorListItem extends StatelessWidget {
  const DualColorListItem({
    required this.label,
    required this.values,
    this.backgroundColor,
    super.key,
  });

  final String label;
  final List<String> values;
  final Color? backgroundColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: backgroundColor,
      padding: const EdgeInsets.all(kSpacingSmall),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Flexible(
            flex: 5,
            child: Text(
              label,
              textAlign: TextAlign.left,
              style: context.tfbText.bodyRegularSmall,
            ),
          ),
          Flexible(
            flex: 4,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: values.map((String item) {
                return Text(
                  item,
                  textAlign: TextAlign.right,
                  style: context.tfbText.bodyRegularSmall,
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}
