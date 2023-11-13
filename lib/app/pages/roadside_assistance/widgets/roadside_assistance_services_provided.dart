import 'package:flutter/material.dart';
import 'package:txfb_insurance_flutter/resources/theme/colors/tfb_brand_colors.dart';
import 'package:txfb_insurance_flutter/shared/shared.dart';

class RoadsideAssistanceServicesProvided extends StatelessWidget {
  const RoadsideAssistanceServicesProvided({super.key});

  @override
  Widget build(BuildContext context) {
    final style = context.tfbText.bodyRegularSmall.copyWith(
      color: TfbBrandColors.grayHighest,
    );
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          context.getLocalizationOf.roadsideAssistanceTipsInfoServicesProvided,
          style: context.tfbText.bodyRegularSmall.copyWith(
            color: TfbBrandColors.grayHighest,
          ),
        ),
        const Padding(
          padding: EdgeInsets.only(
            top: kSpacingSmall,
          ),
        ),
        _serviceProvided(
          context.getLocalizationOf
              .roadsideAssistanceTipsInfoServicesProvidedGarageService,
          style,
        ),
        _serviceProvided(
          context.getLocalizationOf
              .roadsideAssistanceTipsInfoServicesProvidedFlatTire,
          style,
        ),
        _serviceProvided(
          context
              .getLocalizationOf.roadsideAssistanceTipsInfoServicesProvidedFuel,
          style,
        ),
        _serviceProvided(
          context.getLocalizationOf
              .roadsideAssistanceTipsInfoServicesProvidedLocksmith,
          style,
        ),
        _serviceProvided(
          context.getLocalizationOf
              .roadsideAssistanceTipsInfoServicesProvidedStuckVehicle,
          style,
        ),
      ],
    );
  }

  Widget _serviceProvided(String text, TextStyle style) {
    return Padding(
      padding: const EdgeInsets.only(
        left: kSpacingExtraSmall,
        bottom: kSpacingSmall,
      ),
      child: Text(
        '  \u2022  $text',
        style: style,
      ),
    );
  }
}
