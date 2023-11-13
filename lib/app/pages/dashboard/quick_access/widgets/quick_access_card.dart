import 'package:txfb_insurance_flutter/resources/theme/theme.dart';
import 'package:txfb_insurance_flutter/shared/shared.dart';

class QuickAccessCard extends StatelessWidget {
  const QuickAccessCard({
    required this.title,
    this.onTapped,
    super.key,
  });

  final String title;
  final void Function()? onTapped;

  @override
  Widget build(BuildContext context) {
    return TfbFilledButton.secondaryTextButton(
      onPressed: onTapped,
      title: title,
      style: context.tfbText.bodyMediumSmall,
    );
  }
}
