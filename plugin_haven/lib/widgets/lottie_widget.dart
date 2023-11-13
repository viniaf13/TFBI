//  Copyright © 2020 Bottle Rocket Studios. All rights reserved.

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

// Dec 2020: For web, many lottie files only work with below run option
// flutter run -d Chrome --dart-define=FLUTTER_WEB_USE_SKIA=true --release

class LottieWidget extends StatefulWidget {
  const LottieWidget({
    Key? key,
    this.lottieAsset,
    this.lottieComposition,
    this.repeatSplashWhile,
    this.onComplete,
    this.onLoaded,
  }) : super(key: key);

  final String? lottieAsset;
  final LottieComposition? lottieComposition;
  final Function? repeatSplashWhile;
  final Function? onComplete;
  final Function? onLoaded;

  @override
  State<StatefulWidget> createState() => _LottieWidgetState();
}

class _LottieWidgetState extends State<LottieWidget>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  late Function _repeatSplashWhile;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
    _repeatSplashWhile = widget.repeatSplashWhile ?? () => false;
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _runAnimation() {
    _controller.forward(from: 0.0).whenComplete(() {
      if (_repeatSplashWhile()) {
        _runAnimation();
      } else {
        widget.onComplete?.call();
      }
    });
  }

  void _onLoad(LottieComposition composition) {
    //be careful if using this to update parent state
    // before this widget is built
    widget.onLoaded?.call();
    _controller.duration = composition.duration;
    _runAnimation();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.lottieComposition != null) {
      //composition should be loaded
      _onLoad(widget.lottieComposition!);
      return Lottie(
        composition: widget.lottieComposition!,
        alignment: Alignment.center,
        fit: BoxFit.contain,
        controller: _controller,
      );
    }
    return Lottie.asset(
      widget.lottieAsset!,
      alignment: Alignment.center,
      fit: BoxFit.contain,
      controller: _controller,
      onLoaded: _onLoad,
    );
  }
}
