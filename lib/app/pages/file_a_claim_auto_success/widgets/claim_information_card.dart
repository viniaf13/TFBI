import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:txfb_insurance_flutter/shared/shared.dart';
import 'package:txfb_insurance_flutter/app/blocs/claims/claim_details/claim_details_bloc.dart';
import 'package:txfb_insurance_flutter/app/pages/policies_list/policy_image.dart';
import 'package:txfb_insurance_flutter/device/camera/camera_file_storage.dart';
import 'package:txfb_insurance_flutter/domain/models/claims/claim_details/claim_details.dart';
import 'package:txfb_insurance_flutter/domain/models/claims/file_a_claim/policy_selection.dart';
import 'package:txfb_insurance_flutter/domain/models/policy/policy_summary.dart';
import 'package:txfb_insurance_flutter/resources/theme/colors/light_colors.dart';
import 'package:txfb_insurance_flutter/resources/theme/colors/tfb_brand_colors.dart';
import 'package:txfb_insurance_flutter/shared/widgets/photo_carousel/photo_carousel.dart';
import 'package:txfb_insurance_flutter/shared/widgets/text_with_email.dart';
import 'package:txfb_insurance_flutter/shared/widgets/text_with_phone.dart';

class ClaimInformationCard extends StatelessWidget {
  const ClaimInformationCard({
    required this.policySelection,
    required this.claimNumber,
    required this.dateOfLoss,
    super.key,
  });

  final PolicySelection policySelection;
  final String claimNumber;
  final String dateOfLoss;

  String formatRepresentativeName(ClaimDetails claimDetails) {
    final assignments =
        claimDetails.claimAssignments?.importAssignmentDTO?.firstOrNull;
    final firstName = assignments?.userFirstName?.trim().toCapitalized();
    final lastName = assignments?.userLastName?.trim().toCapitalized();

    return '$firstName $lastName';
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(kSpacingMedium),
        child: BlocBuilder<ClaimDetailsBloc, ClaimDetailsState>(
          builder: (context, state) {
            if (state is ClaimDetailsInitState) {
              BlocProvider.of<ClaimDetailsBloc>(context).add(
                GetClaimDetailsEvent(
                  policyNumber: policySelection.policyNumber,
                  claimNumber: claimNumber,
                ),
              );
            }
            if (state is FetchClaimDetailsProcessingState) {
              return const SizedBox(
                height: 120,
                child: TfbLoadingOverlay(
                  backgroundColor: Colors.transparent,
                  spinnerColor: TfbBrandColors.blueHigh,
                ),
              );
            }
            if (state is FetchClaimDetailsFailure) {
              return SizedBox(
                height: 150,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: kSpacingMedium,
                    vertical: kSpacingMedium,
                  ),
                  child: Text(
                    context.getLocalizationOf.somethingWentWrong,
                    style: context.tfbText.bodyMediumSmall.copyWith(
                      color: TfbBrandColors.redHigh,
                    ),
                  ),
                ),
              );
            }
            if (state is FetchClaimDetailsSuccess && state.claim != null) {
              // Flag for whether the phone number is null or empty string.
              // We want to hide the number if we don't have one.
              final bool hasPhoneNumber = (state.claim?.claimAssignments
                          ?.importAssignmentDTO?[0].userPhoneNumber ??
                      '') !=
                  '';
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            context.getLocalizationOf.claimNumber,
                            style: context.tfbText.bodyMediumSmall.copyWith(
                              color: TfbBrandColors.blueHighest,
                            ),
                          ),
                          Text(
                            '#$claimNumber',
                            style: context.tfbText.subHeaderLight.copyWith(
                              color: TfbBrandColors.blueHighest,
                            ),
                          ),
                        ],
                      ),
                      const PolicyImage(
                        PolicyType.txPersonalAuto,
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
                          context.getLocalizationOf.claimRep,
                          style: context.tfbText.caption,
                        ),
                        Text(
                          formatRepresentativeName(state.claim!),
                          style: context.tfbText.bodyRegularLarge,
                        ),
                        if (hasPhoneNumber)
                          Padding(
                            padding: const EdgeInsets.only(top: kSpacingSmall),
                            child: Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(
                                    right: kSpacingSmall,
                                  ),
                                  child: Image.asset(
                                    TfbAssetStrings.phoneIcon,
                                    height: 16,
                                    width: 16,
                                  ),
                                ),
                                TextWithPhone(
                                  phoneNumberForDisplay: state
                                      .claim
                                      ?.claimAssignments
                                      ?.importAssignmentDTO?[0]
                                      .userPhoneNumber
                                      ?.formatPhoneNumber(),
                                  phoneNumberForDialing: state
                                      .claim
                                      ?.claimAssignments
                                      ?.importAssignmentDTO?[0]
                                      .userPhoneNumber,
                                  styleForPhoneNumber:
                                      context.tfbText.bodyMediumLarge.copyWith(
                                    color: TfbBrandColors.blueHigh,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        const SizedBox(height: kSpacingSmall),
                        Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(
                                right: kSpacingSmall,
                              ),
                              child: Image.asset(
                                TfbAssetStrings.mailIcon,
                                height: 16,
                                width: 16,
                              ),
                            ),
                            TextWithEmail(
                              emailAddress: state.claim?.claimAssignments
                                  ?.importAssignmentDTO?[0].userEmail,
                              styleForEmailAddress:
                                  context.tfbText.bodyMediumLarge.copyWith(
                                color: LightColors.primaryContainer,
                              ),
                              displayEmailAddress:
                                  context.getLocalizationOf.emailClaimsRep,
                            ),
                          ],
                        ),
                        const SizedBox(height: kSpacingMedium),
                        Text(
                          context.getLocalizationOf.policy,
                          style: context.tfbText.caption,
                        ),
                        Text(
                          '${policySelection.policyType.name(
                            context,
                          )} # ${policySelection.policyNumber}',
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
                      claimNumber,
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
              );
            }
            return const SizedBox(
              height: 150,
            );
          },
        ),
      ),
    );
  }
}
