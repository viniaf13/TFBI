import 'package:txfb_insurance_flutter/resources/theme/theme.dart';

class DualColorList extends StatelessWidget {
  const DualColorList({
    required this.items,
    super.key,
  });

  final List<StatelessWidget> items;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        for (int index = 0; index < items.length; index++)
          Container(
            color: index.isEven ? TfbBrandColors.white : null,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [items[index]],
            ),
          ),
      ],
    );
  }
}
