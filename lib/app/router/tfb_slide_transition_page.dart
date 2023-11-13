// coverage:ignore-file

import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';

class TfbSlideTransitionPage extends CustomTransitionPage<void> {
  TfbSlideTransitionPage({
    required super.child,
    required super.key,
  }) : super(
          transitionsBuilder: (context, animation, secondaryAnimation, child) =>
              SlideTransition(
            position: animation.drive(
              Tween<Offset>(
                begin: const Offset(0, 1),
                end: Offset.zero,
              ).chain(CurveTween(curve: Curves.easeInOut)),
            ),
            child: child,
          ),
        );
}
