import 'package:flutter/material.dart';
import 'package:txfb_insurance_flutter/app/pages/add_photos/widgets/photos_description.dart';
import 'package:txfb_insurance_flutter/shared/extensions/extensions.dart';

class PhotosDescriptionListAuto extends StatelessWidget {
  const PhotosDescriptionListAuto({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        PhotosDescription(
          text: context.getLocalizationOf.frontVehiclePlate,
        ),
        PhotosDescription(
          text: context.getLocalizationOf.vehicleIdNumber,
        ),
        PhotosDescription(
          text: context.getLocalizationOf.anyDamages,
        ),
      ],
    );
  }
}
