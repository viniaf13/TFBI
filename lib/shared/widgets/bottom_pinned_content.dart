import 'package:flutter/material.dart';

class BottomPinnedContent extends StatelessWidget {
  const BottomPinnedContent({
    required this.child,
    required this.pinnedChild,
    super.key,
  });

  final Widget child;
  final Widget pinnedChild;

  @override
  Widget build(BuildContext context) {
    // Positioned widgets must be a descendant of a Stack widget
    return Stack(
      children: [
        Positioned.fill(
          child: Column(
            children: [
              Expanded(
                child: child,
              ),
              pinnedChild,
            ],
          ),
        ),
      ],
    );
  }
}
