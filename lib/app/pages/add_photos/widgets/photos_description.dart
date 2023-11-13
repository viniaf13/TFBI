import 'package:flutter/material.dart';
import 'package:txfb_insurance_flutter/resources/theme/colors/tfb_brand_colors.dart';
import 'package:txfb_insurance_flutter/shared/constants/spacing.dart';
import 'package:txfb_insurance_flutter/shared/extensions/extensions.dart';

class PhotosDescription extends StatelessWidget {
  const PhotosDescription({
    required this.text,
    super.key,
  });

  final String text;

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.only(
            left: kSpacingExtraSmall,
            bottom: kSpacingSmall,
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('\u2022'),
              const SizedBox(
                width: kSpacingExtraSmall,
              ),
              Expanded(
                child: Text(
                  text,
                  softWrap: true,
                  style: context.tfbText.bodyRegularSmall.copyWith(
                    color: TfbBrandColors.grayHighest,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
