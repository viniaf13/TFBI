import 'package:txfb_insurance_flutter/resources/theme/theme.dart';

class TextWithPadding extends StatelessWidget {
  const TextWithPadding({
    required this.style,
    required this.textData,
    required this.padding,
    this.onTap,
    super.key,
  });

  final EdgeInsets padding;
  final TextStyle? style;
  final String textData;
  final Function? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onTap,
      child: Padding(
        padding: padding,
        child: Text(textData, style: style),
      ),
    );
  }
}
