import 'package:flutter/material.dart';
import 'package:txfb_insurance_flutter/shared/widgets/decorated_container.dart';
import 'package:txfb_insurance_flutter/shared/widgets/tfb_brand_loading_icon.dart';

class DecoratedContainerWithLoading extends StatelessWidget {
  const DecoratedContainerWithLoading({
    required this.containerHeight,
    this.spinnerHeight,
    this.containerColor,
    super.key,
  });

  final double containerHeight;
  final double? spinnerHeight;
  final Color? containerColor;

  @override
  Widget build(BuildContext context) {
    return DecoratedContainer(
      height: containerHeight,
      color: containerColor,
      child: Center(
        child: SizedBox(
          height: spinnerHeight ?? 48,
          child: const TfbBrandLoadingIcon(),
        ),
      ),
    );
  }
}
