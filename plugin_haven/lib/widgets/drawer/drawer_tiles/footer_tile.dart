import 'package:flutter/material.dart';

///Footer
/// basic footer with an optional icon and list of text
class Footer extends StatelessWidget {
  const Footer({
    Key? key,
    required this.footerTextList,
    this.spacing = 5,
    this.padding,
    this.icon,
  }) : super(key: key);

  ///List of text
  final List<String> footerTextList;
  //spacing between the lines of text
  final double spacing;
  //padding around the tile
  final EdgeInsetsGeometry? padding;
  //optional icon to display above text
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    var currIndex = 0;

    return Padding(
      padding: padding ?? const EdgeInsets.symmetric(vertical: 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          if (icon != null) ...[
            Icon(icon, color: Colors.grey.shade600),
            SizedBox(height: spacing)
          ],
          ...footerTextList.map(
            (text) {
              currIndex++;
              return Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    text,
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.grey.shade600, fontSize: 13),
                  ),
                  if (currIndex != footerTextList.length)
                    SizedBox(height: spacing)
                ],
              );
            },
          ).toList(),
        ],
      ),
    );
  }
}
