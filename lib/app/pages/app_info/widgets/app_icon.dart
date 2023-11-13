import 'package:flutter/material.dart';
import 'package:txfb_insurance_flutter/resources/theme/theme.dart';
import 'package:txfb_insurance_flutter/shared/shared.dart';

class AppIcon extends StatelessWidget {
  const AppIcon({super.key});

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        borderRadius: context.radii.defaultRadius,
        boxShadow: [
          BoxShadow(
            offset: const Offset(0, 2),
            color: Colors.black.withAlpha(38),
            blurRadius: 6,
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: context.radii.defaultRadius,
        child: Image.asset(TfbAssetStrings.appIcon, height: 80, width: 80),
      ),
    );
  }
}
