import 'package:flutter/material.dart';

class HasScrolledListener extends StatelessWidget {
  const HasScrolledListener({
    required this.valueNotifier,
    required this.child,
    super.key,
  });

  final ValueNotifier<bool> valueNotifier;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return NotificationListener(
      onNotification: (notification) {
        bool newHasScrolled;

        if (notification is ScrollNotification) {
          if (notification.metrics.pixels <= 0) {
            newHasScrolled = false;
          } else {
            newHasScrolled = true;
          }

          if (newHasScrolled != valueNotifier.value) {
            valueNotifier.value = newHasScrolled;
          }
        }

        return false;
      },
      child: child,
    );
  }
}
