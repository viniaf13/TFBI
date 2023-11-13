import 'package:txfb_insurance_flutter/resources/theme/theme.dart';
import 'package:txfb_insurance_flutter/shared/shared.dart';

class ExpandCardIcon extends StatelessWidget {
  const ExpandCardIcon({
    required this.controller,
    this.onTap,
    this.color,
    super.key,
  });

  final AnimationController controller;
  final VoidCallback? onTap;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    final iconTurns = controller.drive(
      Tween<double>(begin: 0, end: 0.5).chain(
        CurveTween(curve: Curves.easeIn),
      ),
    );

    return Semantics(
      label: context.getLocalizationOf.expandIconLabel,
      value: context.getLocalizationOf.expandIconLabel,
      button: true,
      onTap: onTap,
      child: GestureDetector(
        onTap: onTap,
        child: RotationTransition(
          turns: iconTurns,
          child: Image.asset(
            TfbAssetStrings.chevronIcon,
            color: color,
            width: 24,
            height: 24,
            semanticLabel: context.getLocalizationOf.expandIconLabel,
          ),
        ),
      ),
    );
  }
}
