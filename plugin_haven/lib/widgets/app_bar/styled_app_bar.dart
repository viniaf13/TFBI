import 'package:flutter/material.dart';

///StyledAppBar
/// A custom styled app bar with background image,
/// title, optional logo, and optional tabs
class StyledAppBar extends StatefulWidget implements PreferredSizeWidget {
  const StyledAppBar({
    super.key,
    required this.title,
    required this.background,
    this.logo,
    this.tabs,
    this.onTabChanged,
    this.imageShadow = true,
  });

  const StyledAppBar.withTabs({
    super.key,
    required this.title,
    required this.background,
    this.logo,
    required this.tabs,
    required this.onTabChanged,
    this.imageShadow = true,
  });

  ///app bar title
  final String title;

  ///app bar background
  ///MUST BE COLOR OR AN IMAGEPROVIDER
  final dynamic background;

  ///if shadow gradient (above the background, below text) is visible
  final bool imageShadow;

  ///optional logo located on the right of the app bar
  final ImageProvider? logo;

  ///tabs for the optional tab bar
  final List<Tab>? tabs;

  ///what happens when a new tab has been chosen
  final Function(int)? onTabChanged;

  @override
  State<StyledAppBar> createState() => _StyledAppBarState();

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _StyledAppBarState extends State<StyledAppBar>
    with TickerProviderStateMixin {
  //for proper disposing
  TabController? _tabController;

  @override
  Widget build(BuildContext context) {
    return Container(
      key: const Key('haven_styled_app_bar'),
      height: (widget.tabs == null) ? 100 : 160, //height of bar
      width: double.infinity,
      decoration: (widget.background is! Color) // COLOR OR IMAGE BACKGROUND
          ? BoxDecoration(
              image: DecorationImage(
                image: widget.background as ImageProvider<Object>,
                fit: BoxFit.fitWidth,
              ),
              boxShadow: const [BoxShadow(color: Colors.black, blurRadius: 5)],
            )
          : BoxDecoration(
              color: widget.background as Color,
              boxShadow: const [BoxShadow(color: Colors.black, blurRadius: 5)],
            ),
      child: Stack(
        children: [
          if (widget.imageShadow == true) // GRADIENT OVER IMAGE
            Container(
              height: double.infinity,
              width: double.infinity,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Colors.transparent,
                    Colors.black26,
                    Colors.black,
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
            ),
          Center(
            child: Container(
              padding: EdgeInsets.only(
                left: 20,
                top: (widget.tabs == null) ? 30 : 0,
              ),
              constraints: const BoxConstraints(maxWidth: 500),
              alignment: Alignment.centerLeft,
              child: Text(
                widget.title,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          if (widget.logo != null) // LOGO TO RIGHT OF BAR
            Center(
              child: Container(
                padding: EdgeInsets.only(
                  right: 20,
                  top: (widget.tabs == null) ? 30 : 0,
                ),
                constraints: const BoxConstraints(maxWidth: 500),
                alignment: Alignment.centerRight,
                child: SizedBox(
                  height: 40,
                  width: 40,
                  child: Image(
                    key: const Key('haven_styled_app_bar_logo'),
                    image: widget.logo!,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          if (widget.tabs != null && _tabController != null) // TABS
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                constraints: const BoxConstraints(maxWidth: 500),
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: TabBar(
                  indicatorColor: Colors.red,
                  indicatorWeight: 5,
                  controller: _tabController!,
                  onTap: widget.onTabChanged!,
                  tabs: widget.tabs!,
                ),
              ),
            ),
        ],
      ),
    );
  }

  @override
  void initState() {
    if (widget.tabs != null &&
        widget.onTabChanged != null &&
        _tabController == null) {
      _tabController = TabController(vsync: this, length: widget.tabs!.length);
    }
    super.initState();
  }

  @override
  void dispose() {
    if (_tabController != null) {
      _tabController!.dispose();
    }
    super.dispose();
  }
}
