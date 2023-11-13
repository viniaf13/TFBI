import 'package:flutter/material.dart';
import 'package:txfb_insurance_flutter/app/pages/add_photos/widgets/photos_description.dart';
import 'package:txfb_insurance_flutter/shared/extensions/context_extension.dart';

class PhotosDescriptionListHomeowner extends StatelessWidget {
  const PhotosDescriptionListHomeowner({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        PhotosDescription(
          text: context.getLocalizationOf.occurrenceOverviewProperty,
        ),
      ],
    );
  }
}
