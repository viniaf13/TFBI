import 'package:txfb_insurance_flutter/resources/theme/theme.dart';
import 'package:txfb_insurance_flutter/shared/shared.dart';
import 'package:txfb_insurance_flutter/shared/widgets/text_with_padding.dart';
import 'package:txfb_insurance_flutter/app/pages/claims_landing/widgets/claim_details_widgets.dart';

class ClaimDetailsPhotoSection extends StatelessWidget {
  const ClaimDetailsPhotoSection({
    required this.claimPhotos,
    super.key,
  });

  final List<String> claimPhotos;

  @override
  Widget build(BuildContext context) {
    // Get screen size to set size of images. This should keep image sizes roughly
    // the same size across devices with varying pixel density
    final imageSize = MediaQuery.of(context).size.width / 6;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextWithPadding(
          padding: const EdgeInsets.only(top: kSpacingLarge),
          style: context.tfbText.bodyMediumLarge.copyWith(
            color: LightColors.onSurfaceVariantFull,
          ),
          textData: context.getLocalizationOf.photosReferenced,
        ),
        Padding(
          padding: const EdgeInsets.only(
            left: kSpacingExtraSmall,
            top: kSpacingSmall,
          ),
          child: SizedBox(
            height: imageSize + kSpacingSmall,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: claimPhotos.length,
              itemBuilder: (context, index) {
                return ClaimDetailsImage(
                  claimImage: claimPhotos[index],
                  imageSize: imageSize,
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}
