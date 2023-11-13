import 'package:txfb_insurance_flutter/device/camera/camera_file_storage.dart';
import 'package:txfb_insurance_flutter/domain/models/claims/domain_models/claims_extensions.dart';
import 'package:txfb_insurance_flutter/domain/models/claims/domain_models/full_claim.dart';
import 'package:txfb_insurance_flutter/resources/theme/theme.dart';
import 'package:txfb_insurance_flutter/shared/enum/claim_status_enum.dart';
import 'package:txfb_insurance_flutter/shared/shared.dart';
import 'package:txfb_insurance_flutter/shared/widgets/photo_carousel/photo_carousel.dart';
import 'package:txfb_insurance_flutter/shared/widgets/text_with_padding.dart';
import 'package:txfb_insurance_flutter/app/pages/claims_landing/widgets/claim_details_widgets.dart';

class ClaimDetailsContent extends StatelessWidget {
  const ClaimDetailsContent({
    required this.claim,
    required this.photosList,
    super.key,
  });

  final FullClaim claim;

  /// TODO: Set as a list of string until TFBI-257 for photo work
  final List<String> photosList;

  @override
  Widget build(BuildContext context) {
    final assignments =
        claim.claimDetails?.claimAssignments?.importAssignmentDTO?.firstOrNull;
    return Padding(
      padding: const EdgeInsets.only(
        top: kSpacingSmall,
        bottom: kSpacingLarge,
        right: kSpacingMedium,
        left: kSpacingMedium,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// Claim Information Header
          Text(
            context.getLocalizationOf.claimInfo,
            style: context.tfbText.bodyMediumLarge.copyWith(
              color: LightColors.onSurfaceVariantFull,
            ),
          ),

          /// Claim Information
          Padding(
            padding: const EdgeInsets.only(left: kSpacingSmall),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /// Representative information
                TextWithPadding(
                  padding: const EdgeInsets.only(top: kSpacingSmall),
                  style: context.tfbText.caption.copyWith(
                    color: LightColors.onSurfaceVariantFull,
                  ),
                  textData: context.getLocalizationOf.claimRep,
                ),
                Text(
                  claim.formatRepresentativeName(),
                  style: context.tfbText.bodyRegularLarge.copyWith(
                    color: LightColors.onSurfaceVariantFull,
                  ),
                ),

                /// Tappable phone and email contact information
                ClaimDetailsContactSection(
                  claimNumber: claim.claimNumber,
                  phoneNumber: assignments?.userPhoneNumber,
                  emailAddress: assignments?.userEmail,
                ),

                /// Claim policy information
                TextWithPadding(
                  padding: const EdgeInsets.only(top: kSpacingMedium),
                  style: context.tfbText.caption.copyWith(
                    color: LightColors.onSurfaceVariantFull,
                  ),
                  textData: context.getLocalizationOf.policy,
                ),
                Text(
                  '${claim.policyType?.name(context)} #${claim.claimNumber}',
                  style: context.tfbText.bodyRegularSmall.copyWith(
                    color: LightColors.onSurfaceVariantFull,
                  ),
                ),

                /// Date of loss
                TextWithPadding(
                  padding: const EdgeInsets.only(top: kSpacingSmall),
                  style: context.tfbText.caption.copyWith(
                    color: LightColors.onSurfaceVariantFull,
                  ),
                  textData: context.getLocalizationOf.dateOfLoss,
                ),
                Text(
                  claim.dateOfLoss ?? '',
                  style: context.tfbText.bodyRegularSmall.copyWith(
                    color: LightColors.onSurfaceVariantFull,
                  ),
                ),
              ],
            ),
          ),

          FutureBuilder(
            future: CameraFileStorage.getImageFilesForClaim(
              claim.claimNumber ?? '',
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
              return const SizedBox.shrink();
            },
          ),

          /// Disclosure for cancelling an active claim
          if (claim.statusEnum != ClaimStatusEnum.inactive)
            TextWithPadding(
              textData: context.getLocalizationOf.claimDetailNote,
              padding: const EdgeInsets.only(top: kSpacingLarge),
              style: context.tfbText.bodyMediumSmall.copyWith(
                color: LightColors.primary,
              ),
            ),
        ],
      ),
    );
  }
}
