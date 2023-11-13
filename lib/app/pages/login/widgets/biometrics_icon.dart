import 'dart:io';

import 'package:flutter/material.dart';
import 'package:txfb_insurance_flutter/shared/constants/tfb_asset_strings.dart';
import 'package:txfb_insurance_flutter/shared/extensions/context_extension.dart';

class BiometricsIcon extends StatelessWidget {
  const BiometricsIcon({super.key});

  @override
  Widget build(BuildContext context) {
    if (Platform.isIOS) {
      return Semantics(
        label: context.getLocalizationOf.bioIconLabel,
        child: Image.asset(TfbAssetStrings.faceIdIcon),
      );
    } else if (Platform.isAndroid) {
      return Semantics(
        label: context.getLocalizationOf.bioIconLabel,
        child: Image.asset(TfbAssetStrings.faceUnlockIcon),
      );
    }

    return const SizedBox.shrink();
  }
}
