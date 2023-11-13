import 'package:cross_file/cross_file.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:txfb_insurance_flutter/app/blocs/claims/submit_claim/submit_claim_bloc.dart';
import 'package:txfb_insurance_flutter/domain/models/claims/file_a_claim/auto_claim/submit_claim_auto.dart';
import 'package:txfb_insurance_flutter/domain/models/claims/file_a_claim/property_claim/submit_claim_property.dart';
import 'package:txfb_insurance_flutter/domain/models/file_a_claim/claim_submission.dart';
import 'package:txfb_insurance_flutter/domain/models/policy/policy_summary.dart';
import 'package:txfb_insurance_flutter/resources/theme/theme.dart';
import 'package:txfb_insurance_flutter/shared/constants/spacing.dart';
import 'package:txfb_insurance_flutter/shared/extensions/extensions.dart';
import 'package:txfb_insurance_flutter/shared/widgets/tfb_filled_button.dart';

const kMaxPhotosAllowed = 10;

class SubmitPhotosCta extends StatelessWidget {
  const SubmitPhotosCta({
    required this.photos,
    required this.policyType,
    required this.userAccessToken,
    required this.apiUrl,
    required this.claim,
    super.key,
  });

  final List<XFile> photos;
  final PolicyType policyType;
  final ClaimSubmission claim;

  final String userAccessToken;
  final String apiUrl;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        bottom: kSpacingExtraLarge,
        top: kSpacingMedium,
        left: kSpacingLarge,
        right: kSpacingLarge,
      ),
      child: SizedBox(
        height: 50,
        child: TfbFilledButton.primaryTextButton(
          title: photos.isEmpty
              ? context.getLocalizationOf.submitClaimWithoutPhotos
              : context.getLocalizationOf.submitClaimAndPhotos,
          onPressed: () {
            context.dismissSnackbar();
            final hasPhotos = photos.isNotEmpty ? 'Y' : 'N';
            switch (policyType) {
              case PolicyType.txPersonalAuto:
                BlocProvider.of<SubmitClaimBloc>(context).add(
                  SubmitAutoClaimEvent(
                    autoClaimSubmission:
                        (claim.claimFormAnswers as AutoClaimSubmission)
                            .copyWith(
                      hasPhotos: hasPhotos,
                    ),
                  ),
                );
                break;
              case PolicyType.homeowners:
                BlocProvider.of<SubmitClaimBloc>(context).add(
                  SubmitPropertyClaimEvent(
                    propertyClaimSubmission:
                        (claim.claimFormAnswers as PropertyClaimSubmission)
                            .copyWith(
                      hasPhotos: hasPhotos,
                    ),
                  ),
                );
                break;
              default:
                {
                  context.showErrorSnackBar(
                    text: 'Policy Type not supported.',
                  );
                }
            }
          },
        ),
      ),
    );
  }
}
