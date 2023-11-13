//  Copyright © 2020 Bottle Rocket Studios. All rights reserved.

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:plugin_haven/widgets/lottie_widget.dart';

class LottieView extends StatelessWidget {
  const LottieView({
    Key? key,
    required this.onComplete,
    this.backgroundScreen,
    this.backgroundColor = Colors.transparent,
    this.repeatSplashWhile,
    this.lottieAsset,
    this.lottieComposition,
  }) : super(key: key);

  final String? lottieAsset;
  final LottieComposition? lottieComposition;
  final Function? repeatSplashWhile;
  final Function onComplete;
  final Widget? backgroundScreen;
  final Color? backgroundColor;

  @override
  Widget build(BuildContext context) {
    final ValueNotifier<bool> endNotifier = ValueNotifier(false);

    return Scaffold(
      backgroundColor: backgroundColor,
      body: ValueListenableBuilder<bool>(
        valueListenable: endNotifier,
        builder: (context, value, _) {
          return Stack(
            fit: StackFit.expand,
            alignment: Alignment.center,
            children: [
              if (backgroundScreen != null) backgroundScreen!,
              if (!value)
                LottieWidget(
                  lottieAsset: lottieAsset,
                  lottieComposition: lottieComposition,
                  repeatSplashWhile: repeatSplashWhile,
                  onComplete: () {
                    endNotifier.value = backgroundScreen != null;
                    onComplete();
                  },
                ),
            ],
          );
        },
      ),
    );
  }
}
