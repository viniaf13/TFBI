import 'dart:math';

import 'package:txfb_insurance_flutter/resources/theme/theme.dart';
import 'package:txfb_insurance_flutter/shared/shared.dart';
import 'package:txfb_insurance_flutter/shared/widgets/size_reporting_widget.dart';

class ExpandablePageView extends StatefulWidget {
  const ExpandablePageView({
    required this.itemCount,
    required this.pageBuilder,
    required this.controller,
    this.useMaxHeight = false,
    this.minHeight = 0,
    this.padEnds = true,
    this.reverse = false,
    this.onPageChanged,
    this.borderRadius = BorderRadius.zero,
    super.key,
  });

  final int itemCount;
  final Widget Function(BuildContext, int) pageBuilder;
  final PageController controller;
  final bool reverse;
  final bool useMaxHeight;
  final double? minHeight;
  final bool padEnds;
  final void Function(int)? onPageChanged;
  final BorderRadiusGeometry borderRadius;

  @override
  State<ExpandablePageView> createState() => _ExpandablePageViewState();
}

class _ExpandablePageViewState extends State<ExpandablePageView> {
  late PageController _pageController;
  late List<double> _heights;
  int _currentPage = 0;

  double get _currentHeight => _heights[_currentPage];

  @override
  void initState() {
    super.initState();
    _heights = List.filled(widget.itemCount, 0, growable: true);
    _pageController = widget.controller;
    _pageController.addListener(_updatePage);
  }

  @override
  void dispose() {
    _pageController.removeListener(_updatePage);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<double>(
      tween: Tween<double>(
        begin: _heights.first,
        end: widget.useMaxHeight ? _heights.first : _currentHeight,
      ),
      duration: Duration(milliseconds: _currentHeight.round()),
      builder: (context, value, child) =>
          SizedBox(height: max(value, widget.minHeight ?? 0), child: child),
      child: PageView.builder(
        padEnds: widget.padEnds,
        controller: _pageController,
        itemCount: widget.itemCount,
        itemBuilder: _itemBuilder,
        reverse: widget.reverse,
        onPageChanged: widget.onPageChanged,
      ),
    );
  }

  Widget _itemBuilder(BuildContext context, int index) {
    final item = widget.pageBuilder(context, index);
    return Padding(
      padding: widget.borderRadius == BorderRadius.zero
          ? EdgeInsets.zero
          : const EdgeInsets.only(left: kSpacingSmall),
      child: ClipRRect(
        borderRadius: widget.borderRadius,
        child: OverflowBox(
          minHeight: 0,
          maxHeight: double.infinity,
          alignment: Alignment.topCenter,
          child: SizeReportingWidget(
            onSizeChange: (size) => setState(
              () => _heights[index] = size.height,
            ),
            child: item,
          ),
        ),
      ),
    );
  }

  void _updatePage() {
    final newPage = _pageController.page?.round() ?? 1;
    if (_currentPage != newPage) {
      setState(() {
        _currentPage = newPage;
      });
    }
  }
}
