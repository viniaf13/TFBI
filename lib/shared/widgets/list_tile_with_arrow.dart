import 'package:txfb_insurance_flutter/resources/theme/theme.dart';
import 'package:txfb_insurance_flutter/shared/shared.dart';

class ListTileWithArrow extends StatelessWidget {
  ListTileWithArrow({
    required this.title,
    VoidCallback? onPress,
    this.showArrow = true,
    super.key,
  }) : onPress = onPress ?? (() {});

  final bool showArrow;
  final String title;
  final VoidCallback onPress;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Text(
        title,
        style: context.tfbText.bodyMediumSmall.copyWith(
          color: Theme.of(context).primaryColor,
        ),
      ),
      onTap: onPress,
      trailing: showArrow
          ? const Padding(
              padding: EdgeInsets.only(right: kSpacingExtraSmall),
              child: Icon(
                Icons.arrow_forward_ios_rounded,
                color: TfbBrandColors.blueHighest,
                size: 18,
              ),
            )
          : null,
      contentPadding: EdgeInsets.zero,
    );
  }
}
