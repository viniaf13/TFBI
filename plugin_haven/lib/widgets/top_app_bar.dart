import 'package:flutter/material.dart';

class TopAppBar extends StatelessWidget implements PreferredSizeWidget {
  const TopAppBar({
    Key? key,
    this.appBarAsset,
    this.appBarTitle = '',
    this.logoImage,
    this.tabText,
    this.bottom,
  }) : super(key: key);

  final String? appBarAsset;
  final String appBarTitle;
  final String? logoImage;
  final String? tabText;
  final PreferredSizeWidget? bottom;

  @override
  Widget build(BuildContext context) {
    BoxDecoration? decoration;
    if (appBarAsset != null) {
      decoration = const BoxDecoration(
        image: DecorationImage(
          alignment: Alignment.center,
          image: AssetImage('assets/app_bar_placeholder.png'),
          fit: BoxFit.fill,
        ),
      );
    }
    return AppBar(
      title: Text(
        appBarTitle,
        style: const TextStyle(color: Colors.white),
      ),
      centerTitle: false,
      flexibleSpace: Container(
        decoration: decoration,
        child: Stack(
          children: [
            _overlayGradient,
          ],
        ),
      ),
      bottom: TabBar(
        indicatorColor: Colors.red,
        labelColor: Colors.white,
        tabs: [
          Tab(
            text: tabText,
          ),
          Tab(
            text: tabText,
          ),
          Tab(
            text: tabText,
          ),
        ],
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.fromLTRB(0, 0, 24, 0),
          child: Image.asset('assets/placeholder.png'),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(100);

  Container get _overlayGradient => Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: FractionalOffset.topCenter,
            end: FractionalOffset.bottomCenter,
            colors: [
              Colors.black45.withOpacity(0.1),
              Colors.black45.withOpacity(0.7)
            ],
            stops: const [0.0, 0.8],
          ),
        ),
      );
}
