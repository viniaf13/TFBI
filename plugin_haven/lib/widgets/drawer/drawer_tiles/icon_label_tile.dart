import 'package:flutter/material.dart';

///Icon Label Tile
/// a button consiting of an icon and text widget
/// can be styled as desired
/// has select indicators resembling that of the gmail app
class IconLabelTile extends StatelessWidget {
  const IconLabelTile({
    Key? key,
    //can be used for navigation as well as updating current selected
    required this.onPressed,
    required this.icon,
    required this.labelText,
    this.backgroundColor,
    //selectedColor specifically for this design
    this.selectedColor,
    this.isSelected = false,
  }) : super(key: key);

  final Function() onPressed;
  final IconData icon;
  final String labelText;
  final Color? backgroundColor;
  final Color? selectedColor;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: backgroundColor,
      alignment: Alignment.centerLeft,
      padding: const EdgeInsets.symmetric(vertical: 0.0),
      child: Container(
        alignment: Alignment.centerLeft,
        padding: const EdgeInsets.symmetric(vertical: 5.0).copyWith(left: 3),
        decoration: BoxDecoration(
          color: isSelected ? (selectedColor ?? Colors.red.shade100) : null,
          borderRadius: isSelected
              ? const BorderRadius.only(
                  topRight: Radius.circular(40),
                  bottomRight: Radius.circular(40),
                )
              : BorderRadius.zero,
        ),
        child: TextButton.icon(
          onPressed: onPressed,
          icon: Icon(
            icon,
            size: 16,
            color: const Color.fromARGB(255, 0, 0, 0),
          ),
          label: Text(
            labelText,
            style: const TextStyle(fontSize: 15),
          ),
        ),
      ),
    );
  }
}
