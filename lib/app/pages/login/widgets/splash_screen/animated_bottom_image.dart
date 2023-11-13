import 'package:flutter/material.dart';
import 'package:txfb_insurance_flutter/shared/constants/tfb_asset_strings.dart';

class AnimatedBottomImage extends StatelessWidget {
  const AnimatedBottomImage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Padding(
        padding: const EdgeInsets.only(top: 14),
        child: Image.asset(
          TfbAssetStrings.splashBottom,
        ),
      ),
    );
  }
}
