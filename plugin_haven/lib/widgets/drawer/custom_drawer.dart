import 'package:flutter/material.dart';
import 'package:flutter_slider_drawer/flutter_slider_drawer.dart';
import 'package:plugin_haven/widgets/drawer/drawer_tiles/header_tile.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({
    Key? key,
    required this.drawerItems,
    this.backgroundColor,
    this.header,
    this.footer,
    this.closeDrawerExtra,
    this.sliderKey,
  }) : super(key: key);

  //list of items underneath header
  final List<Widget> drawerItems;
  //background color of the drawer
  final Color? backgroundColor;
  //Displayed at the top of the list
  final Widget? header;
  //Will place at the bottom of the list
  final Widget? footer;
  //Extra functionality on close with IconButton (only Normal)
  final Function? closeDrawerExtra;
  //If this drawer is inside of a flutter_slider_drawer
  final GlobalKey<SliderDrawerState>? sliderKey;

  void closeDrawer(BuildContext context) {
    if (closeDrawerExtra != null) {
      closeDrawerExtra!.call(context);
    }
    Navigator.of(context).pop();
  }

  Stack getHeader(BuildContext context) {
    return Stack(
      children: [
        (header == null) ? const BasicHeader() : header!,
        if (sliderKey == null)
          Align(
            alignment: Alignment.topRight,
            child: IconButton(
              onPressed: () => closeDrawer(context),
              icon: const Icon(Icons.close, color: Colors.white, size: 25),
            ),
          ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final itemCount = drawerItems.length + ((footer != null) ? 2 : 1);

    return Drawer(
      backgroundColor: backgroundColor,
      child: ListView.separated(
        physics: const ClampingScrollPhysics(), //avoid overscroll
        itemBuilder: (_, index) => (index == 0)
            ? getHeader(context)
            : (index == itemCount - 1 && footer != null)
                ? footer!
                : drawerItems[index - 1],
        separatorBuilder: (_, index) => (index == 0)
            ? const SizedBox()
            : Container(color: Colors.grey.shade300, height: 1),
        itemCount: itemCount,
      ),
    );
  }
}
