import 'package:txfb_insurance_flutter/resources/theme/theme.dart';
import 'package:txfb_insurance_flutter/shared/constants/tfb_asset_strings.dart';

class TfbLoadingOverlay extends StatefulWidget {
  const TfbLoadingOverlay({
    this.backgroundColor = TfbBrandColors.semiTransparent,
    super.key,
    this.spinnerColor = TfbBrandColors.white,
  });

  final Color backgroundColor;
  final Color spinnerColor;

  @override
  State<TfbLoadingOverlay> createState() => _TfbLoadingOverlayState();
}

class _TfbLoadingOverlayState extends State<TfbLoadingOverlay>
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
    return Container(
      height: MediaQuery.sizeOf(context).height,
      width: MediaQuery.sizeOf(context).width,
      color: widget.backgroundColor,
      child: Center(
        child: Transform.rotate(
          angle: _animation.value,
          child: Image.asset(
            TfbAssetStrings.loadingIcon,
            color: widget.spinnerColor,
            height: 78,
            width: 78,
          ),
        ),
      ),
    );
  }
}
