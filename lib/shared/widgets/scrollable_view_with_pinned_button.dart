import 'package:flutter/material.dart';
import 'package:txfb_insurance_flutter/shared/shared.dart';

class ScrollableViewWithPinnedButton extends StatelessWidget {
  const ScrollableViewWithPinnedButton({
    required this.child,
    required this.button,
    super.key,
  });

  final Widget child;
  final Widget button;

  @override
  Widget build(BuildContext context) {
    return BottomPinnedContent(
      pinnedChild: Container(
        color: Theme.of(context).scaffoldBackgroundColor,
        padding: const EdgeInsets.symmetric(
          horizontal: kSpacingLarge,
          vertical: kSpacingSmall,
        ),
        width: double.infinity,
        child: SafeArea(
          top: false,
          child: button,
        ),
      ),
      child: child,
    );
  }
}
