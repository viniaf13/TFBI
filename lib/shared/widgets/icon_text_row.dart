import 'package:txfb_insurance_flutter/resources/theme/theme.dart';

class IconTextRow extends StatelessWidget {
  const IconTextRow({
    required this.imageAssetString,
    required this.rowPadding,
    required this.textPadding,
    required this.childWidget,
    super.key,
  });

  final String imageAssetString;
  final EdgeInsets rowPadding;
  final EdgeInsets textPadding;
  final Widget childWidget;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: rowPadding,
      child: Row(
        children: [
          Image.asset(
            imageAssetString,
            width: 16,
            height: 16,
          ),
          Padding(
            padding: textPadding,
            child: childWidget,
          ),
        ],
      ),
    );
  }
}
