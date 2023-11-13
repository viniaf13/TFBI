import 'package:flutter/material.dart';

///Group Tiles
/// This tile handles the grouping of children and offers the ability to
/// present a text header at the top for categorizing
class GroupTiles extends StatelessWidget {
  const GroupTiles({
    Key? key,
    required this.listOfTiles,
    this.groupHeaderText,
    this.padding,
    this.backgroundColor,
    this.tileSpacing = 3,
  }) : super(key: key);

  //children widgets
  final List<Widget> listOfTiles;
  //background color of the entire tile
  final Color? backgroundColor;
  //header text for categorizing
  final String? groupHeaderText;
  //vertical padding for entire tile
  final EdgeInsetsGeometry? padding;
  //vertical spacing between child widgets
  final double tileSpacing;

  @override
  Widget build(BuildContext context) {
    var currIndex = 0;
    return Container(
      color: backgroundColor,
      padding: padding ?? const EdgeInsets.only(top: 15, bottom: 12),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (groupHeaderText != null)
            Padding(
              padding: const EdgeInsets.only(left: 12.0),
              child: Text(
                groupHeaderText!,
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                ),
              ),
            ),
          const SizedBox(height: 10),
          ...listOfTiles.map(
            (listTile) {
              currIndex++;
              return Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  listTile,
                  if (currIndex != listOfTiles.length)
                    SizedBox(height: tileSpacing)
                ],
              );
            },
          ).toList()
        ],
      ),
    );
  }
}
