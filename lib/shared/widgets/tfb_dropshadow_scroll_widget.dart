import 'package:flutter/material.dart';

/// Adds a drop shadow to a scrollable widget when scrolled
class TfbDropShadowScrollWidget extends StatefulWidget {
  const TfbDropShadowScrollWidget({
    required this.child,
    this.showFooterShadow = false,
    super.key,
  });
  final Widget child;
  final bool showFooterShadow;
  @override
  State<TfbDropShadowScrollWidget> createState() =>
      _TfbDropShadowScrollWidgetState();
}

class _TfbDropShadowScrollWidgetState extends State<TfbDropShadowScrollWidget> {
  ScrollController? _scrollController;
  ValueNotifier<bool> shouldShowHeaderShadowNotifier = ValueNotifier(false);
  ValueNotifier<bool> shouldShowFooterShadowNotifier = ValueNotifier(false);
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _updateShadow());
  }

  @override
  Widget build(BuildContext context) {
    // Fetch the current scroll controller for the child widget
    _scrollController = PrimaryScrollController.of(context);
    // Add the updateShadow listener
    _scrollController!.addListener(_updateShadow);

    return Stack(
      children: [
        Positioned.fill(
          child: widget.child,
        ),
        ValueListenableBuilder<bool>(
          valueListenable: shouldShowHeaderShadowNotifier,
          builder: (context, shouldShow, child) {
            return Positioned(
              top: -3,
              child: AnimatedOpacity(
                duration: const Duration(milliseconds: 100),
                opacity: shouldShow ? 1 : 0,
                child: Container(
                  height: 4,
                  alignment: Alignment.topCenter,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withAlpha(70),
                        blurRadius: 10,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
        if (widget.showFooterShadow)
          ValueListenableBuilder<bool>(
            valueListenable: shouldShowFooterShadowNotifier,
            builder: (context, shouldShow, child) {
              return Positioned(
                bottom: 3,
                child: AnimatedOpacity(
                  duration: const Duration(milliseconds: 100),
                  opacity: shouldShow ? 1 : 0,
                  child: Container(
                    height: 4,
                    alignment: Alignment.bottomCenter,
                    width: MediaQuery.of(context).size.width,
                    decoration: const BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Color(0x26000000),
                          blurRadius: 10,
                          offset: Offset(0, -2),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
      ],
    );
  }

  void _updateShadow() {
    if (_scrollController != null) {
      bool showHeaderShadow = false;
      bool showFooterShadow = false;

      if (_scrollController!.hasClients) {
        showHeaderShadow =
            _scrollController!.position.pixels > 0 && !showHeaderShadow;
        showFooterShadow = _scrollController!.position.pixels == 0 ||
            !_scrollController!.position.atEdge;
      }
      if (shouldShowHeaderShadowNotifier.value != showHeaderShadow) {
        shouldShowHeaderShadowNotifier.value = showHeaderShadow;
      }
      if (shouldShowFooterShadowNotifier.value != showFooterShadow) {
        shouldShowFooterShadowNotifier.value = showFooterShadow;
      }
    }
  }

  @override
  void dispose() {
    _scrollController?.removeListener(_updateShadow);
    super.dispose();
  }
}
