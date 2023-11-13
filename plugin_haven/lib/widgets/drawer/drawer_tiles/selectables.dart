import 'package:flutter/material.dart';
import 'package:plugin_haven/widgets/drawer/drawer_tiles/group.dart';
import 'package:plugin_haven/widgets/drawer/drawer_tiles/icon_label_tile.dart';

///Selectable Group Example
///
/// An example of how to prepare tiles for selecting indications
class SelectableGroupExample extends StatefulWidget {
  const SelectableGroupExample({Key? key}) : super(key: key);

  @override
  State<SelectableGroupExample> createState() => _SelectableGroupExampleState();
}

class _SelectableGroupExampleState extends State<SelectableGroupExample> {
  int currSelected = 0;

  @override
  Widget build(BuildContext context) {
    return GroupTiles(
      groupHeaderText: 'Icon Labels',
      backgroundColor: Colors.white,
      listOfTiles: [
        IconLabelTile(
          onPressed: () => setNewSelected(0),
          isSelected: currSelected == 0,
          icon: Icons.close_fullscreen,
          labelText: 'IconLabelTile',
          selectedColor: const Color(0xFFFFE7E7),
        ),
        IconLabelTile(
          onPressed: () => setNewSelected(1),
          isSelected: currSelected == 1,
          icon: Icons.slideshow,
          labelText: 'Selected IconLabelTile',
          selectedColor: const Color(0xFFFFE7E7),
        ),
      ],
    );
  }

  void setNewSelected(int newSelected) {
    setState(() {
      currSelected = newSelected;
    });
  }
}
