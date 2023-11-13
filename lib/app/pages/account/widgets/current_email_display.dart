import 'package:flutter/material.dart';
import 'package:txfb_insurance_flutter/resources/theme/colors/tfb_brand_colors.dart';
import 'package:txfb_insurance_flutter/texas_farm_bureau_insurance.dart';

const _defaultAnimationDuration = Duration(milliseconds: 300);

class CurrentEmailDisplay extends StatelessWidget {
  const CurrentEmailDisplay({
    required this.onTap,
    required this.isOpen,
    super.key,
  });

  final VoidCallback onTap;
  final bool isOpen;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              context.getLocalizationOf.currentEmailAddress,
              style: context.tfbText.caption,
            ),
            // TODO: Improve the layout responsiveness
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.75,
              child: Text(
                context.user?.memberEmailAddress ?? '',
                maxLines: 2,
                style: context.tfbText.subHeaderRegular.copyWith(
                  color: TfbBrandColors.blueHighest,
                ),
              ),
            ),
          ],
        ),
        Semantics(
          label: context.getLocalizationOf.updateEmailButtonSemanticLabel,
          child: SizedBox(
            width: 24,
            height: 24,
            child: InkWell(
              onTap: onTap,
              child: AnimatedSwitcher(
                duration: _defaultAnimationDuration,
                child: isOpen
                    ? const Icon(
                        Icons.close,
                        color: TfbBrandColors.blueHighest,
                      )
                    : Image.asset(
                        TfbAssetStrings.editButtonIcon,
                        width: 24,
                        height: 24,
                      ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
