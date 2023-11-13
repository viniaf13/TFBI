import 'package:flutter/material.dart';
import 'package:txfb_insurance_flutter/app/pages/roadside_assistance/widgets/roadside_assistance_services_provided.dart';
import 'package:txfb_insurance_flutter/resources/theme/colors/tfb_brand_colors.dart';
import 'package:txfb_insurance_flutter/shared/constants/spacing.dart';
import 'package:txfb_insurance_flutter/shared/extensions/extensions.dart';
import 'package:txfb_insurance_flutter/shared/widgets/separator_line.dart';

class RoadsideAssistanceDetails extends StatelessWidget {
  const RoadsideAssistanceDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(kSpacingMedium),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.only(
              top: kSpacingSmall,
            ),
          ),
          Text(
            context.getLocalizationOf.roadsideAssistanceTipsInfoDetails1,
            style: context.tfbText.bodyRegularSmall.copyWith(
              color: TfbBrandColors.grayHighest,
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(
              top: kSpacingMedium,
            ),
          ),
          const RoadsideAssistanceServicesProvided(),
          const Padding(
            padding: EdgeInsets.only(
              top: kSpacingLarge,
            ),
          ),
          RichText(
            text: TextSpan(
              text:
                  context.getLocalizationOf.roadsideAssistanceTipsInfoDetails2,
              style: context.tfbText.bodyRegularSmall.copyWith(
                color: TfbBrandColors.grayHighest,
              ),
              children: [
                TextSpan(
                  text: context
                      .getLocalizationOf.roadsideAssistanceTipsInfoDetails3,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                TextSpan(
                  text: context
                      .getLocalizationOf.roadsideAssistanceTipsInfoDetails4,
                ),
              ],
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(
              top: kSpacingMedium,
            ),
          ),
          Text(
            context.getLocalizationOf.roadsideAssistanceTipsInfoDetails5,
            style: context.tfbText.bodyRegularSmall.copyWith(
              color: TfbBrandColors.grayHighest,
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(
              top: kSpacingMedium,
            ),
          ),
          const SeparatorLine(),
          const Padding(
            padding: EdgeInsets.only(
              top: kSpacingMedium,
            ),
          ),
        ],
      ),
    );
  }
}
