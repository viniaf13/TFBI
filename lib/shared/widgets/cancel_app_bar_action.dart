import 'package:txfb_insurance_flutter/app/router/tfb_navigator.dart';
import 'package:txfb_insurance_flutter/resources/theme/theme.dart';
import 'package:txfb_insurance_flutter/shared/shared.dart';

class CancelAppBarAction extends StatelessWidget {
  const CancelAppBarAction({this.onPress, super.key});

  final void Function()? onPress;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: kSpacingMedium),
      child: TextButton(
        onPressed: onPress ?? context.navigator.goToLoginPage,
        style: TextButtonTheme.of(context).style?.copyWith(
              splashFactory: NoSplash.splashFactory,
              overlayColor: MaterialStateProperty.all(Colors.transparent),
            ),
        child: Text(
          context.getLocalizationOf.cancelButtonTitle,
          style: context.tfbText.bodyMediumSmall.copyWith(
            color: TfbBrandColors.blueHighest,
          ),
        ),
      ),
    );
  }
}
