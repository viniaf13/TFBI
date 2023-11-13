import 'package:txfb_insurance_flutter/resources/theme/theme.dart';
import 'package:txfb_insurance_flutter/shared/shared.dart';

// Should typically be used as first widget in all standard Policy Detail Cards
class PolicyDetailCardTitle extends StatelessWidget {
  const PolicyDetailCardTitle({required this.title, super.key});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: context.tfbText.header3
              .copyWith(color: TfbBrandColors.blueHighest),
        ),
        const SeparatorLine(),
      ],
    );
  }
}
