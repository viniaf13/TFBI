import 'package:flutter/material.dart';

///Radio Button and Text Tile
class RadioTile extends StatelessWidget {
  const RadioTile({
    Key? key,
    required this.fontSize,
    required this.tileValue,
    required this.currentValue,
    required this.onChanged,
    bool? dontScaleButton,
  })  : _dontScaleButton = dontScaleButton ?? false,
        super(key: key);

  final double fontSize;
  final String tileValue;
  final String currentValue;
  final Function(String? updatedValue) onChanged;
  final bool _dontScaleButton;

  @override
  Widget build(BuildContext context) {
    //hardcoded scale factor based on font size
    final radioSize = fontSize * 1.5;

    return Row(
      children: [
        SizedBox(
          height: _dontScaleButton ? null : radioSize,
          child: FittedBox(
            fit: _dontScaleButton ? BoxFit.none : BoxFit.fill,
            child: Radio<String>(
              visualDensity: VisualDensity.compact,
              value: tileValue,
              groupValue: currentValue,
              onChanged: onChanged,
            ),
          ),
        ),
        const SizedBox(width: 10),
        Flexible(
          child: Text(
            tileValue,
            style: TextStyle(fontSize: fontSize),
          ),
        )
      ],
    );
  }
}
