import 'package:flutter/material.dart';
import 'package:txfb_insurance_flutter/app/pages/policies_list/policy_image.dart';
import 'package:txfb_insurance_flutter/device/camera/camera_file_storage.dart';
import 'package:txfb_insurance_flutter/domain/models/claims/file_a_claim/policy_selection.dart';
import 'package:txfb_insurance_flutter/domain/models/policy/policy_summary.dart';
import 'package:txfb_insurance_flutter/resources/theme/colors/tfb_brand_colors.dart';
import 'package:txfb_insurance_flutter/shared/constants/spacing.dart';
import 'package:txfb_insurance_flutter/shared/extensions/extensions.dart';
import 'package:txfb_insurance_flutter/shared/widgets/photo_carousel/photo_carousel.dart';
import 'package:txfb_insurance_flutter/shared/widgets/separator_line.dart';

class ClaimInformationCard extends StatelessWidget {
  const ClaimInformationCard({
    required this.confirmationNumber,
    required this.policy,
    required this.dateOfLoss,
    super.key,
  });

  final String confirmationNumber;
  final PolicySelection policy;
  final String dateOfLoss;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(kSpacingMedium),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      context.getLocalizationOf.confirmationNumber,
                      style: context.tfbText.bodyMediumSmall.copyWith(
                        color: TfbBrandColors.blueHighest,
                      ),
                    ),
                    Text(
                      '#$confirmationNumber',
                      style: context.tfbText.subHeaderLight.copyWith(
                        color: TfbBrandColors.blueHighest,
                      ),
                    ),
                  ],
                ),
                const PolicyImage(
                  PolicyType.homeowners,
                  height: 42,
                ),
              ],
            ),
            const SeparatorLine(),
            Text(
              context.getLocalizationOf.claimInformation,
              style: context.tfbText.bodyMediumLarge,
            ),
            const SizedBox(height: kSpacingSmall),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: kSpacingSmall,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    context.getLocalizationOf.policy,
                    style: context.tfbText.caption,
                  ),
                  Text(
                    '${policy.policyType.name(
                      context,
                    )} # ${policy.policyNumber}',
                    style: context.tfbText.bodyRegularSmall,
                  ),
                  const SizedBox(height: kSpacingSmall),
                  Text(
                    context.getLocalizationOf.dateOfLoss,
                    style: context.tfbText.caption,
                  ),
                  Text(
                    dateOfLoss,
                    style: context.tfbText.bodyRegularSmall,
                  ),
                ],
              ),
            ),
            FutureBuilder(
              future: CameraFileStorage.getImageFilesForClaim(
                confirmationNumber,
              ),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done &&
                    snapshot.hasData &&
                    snapshot.data!.isNotEmpty) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                          top: kSpacingMedium,
                          bottom: kSpacingSmall,
                        ),
                        child: Text(
                          context.getLocalizationOf.photosReferenced,
                          style: context.tfbText.bodyMediumLarge,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: kSpacingSmall,
                        ),
                        child: PhotoCarousel(images: snapshot.data!),
                      ),
                    ],
                  );
                }
                return const SizedBox(
                  height: 0,
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
