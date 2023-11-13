import 'package:flutter/material.dart';

class TfbNeverPop extends StatelessWidget {
  /// Wrap a page in this widget to prevent that page from popping using the
  /// system Android back button, the iOS back swipe gesture, or any other means
  /// to pop.
  ///
  /// Does not prevent go_router.go calls, even if that call results in moving
  /// to a previous screen higher in the navigation stack.
  const TfbNeverPop({required this.child, super.key});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(child: child, onWillPop: () => Future.value(false));
  }
}
