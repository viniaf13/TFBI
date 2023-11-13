import 'package:txfb_insurance_flutter/shared/shared.dart';
import 'package:txfb_insurance_flutter/resources/theme/theme.dart';
import 'package:txfb_insurance_flutter/app/pages/file_a_claim_forms/widgets/generic_fields/yesno_button.dart';

// This general-purpose widget header enforces that the user _must_
// choose between the options. There is no default selection by design.
// If 'yes' is selected, the child will be displayed.

class YesNoCardHeader extends StatelessWidget {
  const YesNoCardHeader({
    required this.child,
    required this.title,
    required this.onSelect,
    required this.selectionValue,
    required this.validationMessage,
    required this.displayChildrenWhenSelected,
    super.key,
  });

  final Widget child;
  final String title;
  final String? validationMessage;
  final ValueChanged<YesNoButtonKind> onSelect;
  final ValueGetter<YesNoButtonKind?> selectionValue;
  final YesNoButtonKind displayChildrenWhenSelected;

  void _tapYesNo(YesNoButtonKind kind) {
    onSelect(kind);
  }

  String? validate() {
    // if neither has been selected, show the validation message. If either
    // has been selected, then the header's validation has been fulfilled.
    // (the children are NOT validated as part of this method, as there
    // can be multiple fields involved)
    return selectionValue() == null ? validationMessage : null;
  }

  @override
  Widget build(BuildContext context) {
    final bool showChild = selectionValue() == displayChildrenWhenSelected;
    final yesSelection = (selectionValue() == YesNoButtonKind.yes);
    final noSelection = (selectionValue() == YesNoButtonKind.no);
    const animationDuration = Duration(milliseconds: 250);

    return Column(
      children: [
        Semantics(
          container: true,
          label: title,
          child: Row(
            children: [
              Text(
                title,
                style: context.tfbText.bodyRegularLarge.copyWith(
                  color: TfbBrandColors.grayHighest,
                ),
              ),
              Text(
                '*',
                style: context.tfbText.bodyRegularLarge.copyWith(
                  color: TfbBrandColors.redHigh,
                ),
              ),
            ],
          ),
        ),
        Row(
          children: [
            YesNoButton(
              value: yesSelection,
              kind: YesNoButtonKind.yes,
              onTap: () {
                _tapYesNo(
                  YesNoButtonKind.yes,
                );
              },
            ),
            const SizedBox(
              width: kSpacingXxl,
            ),
            YesNoButton(
              value: noSelection,
              kind: YesNoButtonKind.no,
              onTap: () {
                _tapYesNo(
                  YesNoButtonKind.no,
                );
              },
            ),
          ],
        ),
        Text(
          validationMessage ?? '',
          style: context.tfbText.caption.copyWith(
            color: TfbBrandColors.redHigh,
          ),
        ),
        AnimatedSize(
          duration: animationDuration,
          reverseDuration: animationDuration,
          curve: Curves.easeInOut,
          child: showChild
              ? child
              : const SizedBox(
                  height: kSpacingMedium,
                  width: double.infinity,
                ),
        ),
      ],
    );
  }
}
