import 'package:flutter/material.dart';

///Check Box and Text Tile
class CheckBoxTile extends StatelessWidget {
  const CheckBoxTile({
    Key? key,
    required this.index,
    required this.fontSize,
    required this.currentValue,
    required this.onChanged,
    required this.text,
    bool? dontScaleButton,
  })  : _dontScaleButton = dontScaleButton ?? false,
        super(key: key);

  final double fontSize;
  final int index;
  final String text;
  final bool currentValue;
  final Function(bool? updatedValue, int index) onChanged;
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
            child: Checkbox(
              visualDensity: VisualDensity.compact,
              value: currentValue,
              onChanged: (bool? value) => onChanged(value, index),
            ),
          ),
        ),
        const SizedBox(width: 10),
        Flexible(child: Text(text, style: TextStyle(fontSize: fontSize)))
      ],
    );
  }
}
