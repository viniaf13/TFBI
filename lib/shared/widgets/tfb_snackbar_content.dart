import 'package:txfb_insurance_flutter/resources/theme/theme.dart';

class TfbSnackbarContent extends StatelessWidget {
  const TfbSnackbarContent({
    required this.text,
    this.icon,
    this.iconTapAreaHeight = 24,
    this.iconTapAreaWidth = 24,
    super.key,
  });

  final Widget text;
  final Widget? icon;
  final double iconTapAreaHeight;
  final double iconTapAreaWidth;

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(
        minHeight: 32,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: text,
          ),
          if (icon != null)
            SizedBox(
              height: iconTapAreaHeight,
              width: iconTapAreaWidth,
              child: icon,
            ),
        ],
      ),
    );
  }
}
