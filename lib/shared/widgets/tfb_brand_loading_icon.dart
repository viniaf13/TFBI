import 'package:flutter/material.dart';
import 'package:txfb_insurance_flutter/shared/constants/tfb_asset_strings.dart';

enum LoadingOverlayThickness {
  normal,
  thick,
}

class TfbBrandLoadingIcon extends StatefulWidget {
  const TfbBrandLoadingIcon({
    super.key,
    this.size,
    this.thickness = LoadingOverlayThickness.normal,
  });

  final Size? size;
  final LoadingOverlayThickness thickness;

  @override
  State<TfbBrandLoadingIcon> createState() => _TfbBrandLoadingIconState();
}

class _TfbBrandLoadingIconState extends State<TfbBrandLoadingIcon>
    with SingleTickerProviderStateMixin {
  late Animation<double> _animation;
  late AnimationController controller;

  void onChangeAnimationValue() {
    setState(() {});
  }

  @override
  void initState() {
    super.initState();

    controller = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    )..repeat();

    _animation =
        Tween<double>(begin: 0, end: 2 * 3.14159265).animate(controller);

    controller
      ..forward()
      ..repeat()
      ..addListener(onChangeAnimationValue);
  }

  @override
  void dispose() {
    controller
      ..removeListener(onChangeAnimationValue)
      ..dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Transform.rotate(
        angle: _animation.value,
        child: Image.asset(
          widget.thickness == LoadingOverlayThickness.normal
              ? TfbAssetStrings.blueLoadingIcon
              : TfbAssetStrings.blueLoadingIconThick,
          height: widget.size?.height ?? 78,
          width: widget.size?.height ?? 78,
        ),
      ),
    );
  }
}
