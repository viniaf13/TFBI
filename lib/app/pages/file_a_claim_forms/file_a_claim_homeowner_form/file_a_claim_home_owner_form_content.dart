import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:txfb_insurance_flutter/app/analytics/analytics.dart';
import 'package:txfb_insurance_flutter/app/blocs/claims/submit_claim/submit_claim_bloc.dart';
import 'package:txfb_insurance_flutter/app/pages/file_a_claim_forms/widgets/claim_form_app_bar.dart';
import 'package:txfb_insurance_flutter/app/pages/file_a_claim_forms/widgets/claims_form_progress_indicator.dart';
import 'package:txfb_insurance_flutter/app/pages/file_a_claim_forms/widgets/file_a_claim_form_header.dart';
import 'package:txfb_insurance_flutter/app/pages/file_a_claim_forms/widgets/generic_fields/submit_claim_button.dart';
import 'package:txfb_insurance_flutter/app/pages/file_a_claim_forms/widgets/loss_and_damage_section/loss_and_damage_section.dart';
import 'package:txfb_insurance_flutter/app/pages/file_a_claim_forms/widgets/preferred_section/preferred_section.dart';
import 'package:txfb_insurance_flutter/app/pages/file_a_claim_forms/widgets/reporter_info_section/reporter_info_section.dart';
import 'package:txfb_insurance_flutter/app/router/tfb_navigator.dart';
import 'package:txfb_insurance_flutter/domain/models/claims/file_a_claim/policy_selection.dart';
import 'package:txfb_insurance_flutter/domain/models/claims/file_a_claim/property_claim/submit_claim_property.dart';
import 'package:txfb_insurance_flutter/domain/models/claims/file_a_claim/property_claim/submit_claim_property_primary_insured.dart';
import 'package:txfb_insurance_flutter/domain/models/claims/file_a_claim/shared/policy_details/policy_details.dart';
import 'package:txfb_insurance_flutter/domain/models/claims/file_a_claim/shared/submit_claim_loss_info.dart';
import 'package:txfb_insurance_flutter/domain/models/claims/file_a_claim/shared/submit_claim_reporter_info.dart';
import 'package:txfb_insurance_flutter/domain/models/file_a_claim/claim_submission.dart';
import 'package:txfb_insurance_flutter/domain/models/policy/policy_summary.dart';
import 'package:txfb_insurance_flutter/resources/theme/colors/tfb_brand_colors.dart';
import 'package:txfb_insurance_flutter/shared/constants/spacing.dart';
import 'package:txfb_insurance_flutter/shared/enum/file_a_claim_destination.dart';
import 'package:txfb_insurance_flutter/shared/enum/file_a_claim_type.dart';
import 'package:txfb_insurance_flutter/shared/extensions/extensions.dart';
import 'package:txfb_insurance_flutter/shared/mixins/page_properties_mixin.dart';
import 'package:txfb_insurance_flutter/shared/widgets/tfb_dropshadow_scroll_widget.dart';
import 'package:txfb_insurance_flutter/shared/widgets/tfb_loading_overlay.dart';
import 'package:visibility_detector/visibility_detector.dart';

class FileAClaimHomeOwnerContent extends StatefulWidget
    with PagePropertiesMixin {
  const FileAClaimHomeOwnerContent({
    required this.dateOfLoss,
    required this.policySelection,
    super.key,
  });

  final String dateOfLoss;
  final PolicySelection policySelection;

  @override
  String get screenName => 'Property claim form';

  @override
  State<FileAClaimHomeOwnerContent> createState() =>
      _FileAClaimHomeOwnerContentState();
}

class _FileAClaimHomeOwnerContentState
    extends State<FileAClaimHomeOwnerContent> {
  final isPreferredFormValid = ValueNotifier(false);
  final isReporterInfoFormValid = ValueNotifier(false);
  final isLossAndDamageFormValid = ValueNotifier(false);
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController preferredContactPhoneFieldController =
      TextEditingController();
  final preferredContactType = ValueNotifier<String?>(null);

  final reporterInformationNotifier = ValueNotifier<ReporterInformation>(
    const ReporterInformation(),
  );
  final lossInformationNotifier = ValueNotifier<LossInformation>(
    const LossInformation(),
  );

  final keyReporterSection = GlobalKey();
  final keyLossAndDamageSection = GlobalKey();

  final reporterSectionStatus = ValueNotifier<ProgressIndicatorStatus>(
    ProgressIndicatorStatus.inProgress,
  );
  final lossAndDamageSectionStatus = ValueNotifier<ProgressIndicatorStatus>(
    ProgressIndicatorStatus.notStarted,
  );
  final keyVisibilityDetectorLossAndDamage = UniqueKey();

  @override
  void initState() {
    isReporterInfoFormValid.addListener(() {
      reporterSectionStatus.value =
          isPreferredFormValid.value && isReporterInfoFormValid.value
              ? ProgressIndicatorStatus.completed
              : ProgressIndicatorStatus.inProgress;
    });
    isPreferredFormValid.addListener(() {
      reporterSectionStatus.value =
          isPreferredFormValid.value && isReporterInfoFormValid.value
              ? ProgressIndicatorStatus.completed
              : ProgressIndicatorStatus.inProgress;
    });
    isLossAndDamageFormValid.addListener(() {
      lossAndDamageSectionStatus.value = isLossAndDamageFormValid.value
          ? ProgressIndicatorStatus.completed
          : ProgressIndicatorStatus.inProgress;
    });

    TfbAnalytics.instance.track(
      const PropertyClaimFormViewEvent(),
    );

    super.initState();
  }

  //It is necessary for unit test execution
  // ignore: avoid_init_to_null
  late PolicyDetails? policyDetails = null;

  PropertyClaimSubmission _createSubmissionModel(
    PolicyDetails policyDetails,
  ) {
    final tbiOfficeTimeZone = tz.getLocation('America/Chicago');

    final DateTime dateTime =
        DateTime.parse(lossInformationNotifier.value.timeOfLoss!);

    final dateOfLossAsIso8601 =
        tz.TZDateTime.from(dateTime, tbiOfficeTimeZone).toIso8601String();

    return PropertyClaimSubmission(
      claimDestination: FileAClaimDestination.legacy.value,
      claimType: FileAClaimType.lossDamage.value.toString(),
      policyNumber: policyDetails.policyNumber,
      policyType: policyDetails.policyType,
      policySubType: policyDetails.policySubType,
      policySymbol: policyDetails.policySymbol,
      hasPhotos: 'Y',
      effectiveDate: policyDetails.effectiveDate,
      expirationDate: policyDetails.expirationDate,
      memberNumber: policyDetails.memberNumber,
      externalIdValTxt: policyDetails.externalIdValTxt,
      companyName: policyDetails.companyName,
      corporationName: policyDetails.corporationName,
      primaryInsured: PropertyPrimaryInsured(
        emailAddress: policyDetails.primaryInsured?.emailAddress,
        name: policyDetails.primaryInsured?.name,
        insuredType: policyDetails.primaryInsured?.insuredType,
        gender: policyDetails.primaryInsured?.gender,
        maritalStatus: policyDetails.primaryInsured?.maritalStatus,
        dateOfBirth: policyDetails.primaryInsured?.dateOfBirth,
        address: policyDetails.primaryInsured?.address,
        primaryInd: policyDetails.primaryInsured?.primaryInd,
        phone: preferredContactPhoneFieldController.text,
        phoneType: preferredContactType.value,
        licenseNumber: policyDetails.primaryInsured?.licenseNumber,
        licenseClass: policyDetails.primaryInsured?.licenseClass,
        licenseState: policyDetails.primaryInsured?.licenseState,
      ),
      reporterInformation: reporterInformationNotifier.value,
      lossInformation: lossInformationNotifier.value.copyWith(
        dateOfLoss: dateOfLossAsIso8601,
        timeOfLoss: dateOfLossAsIso8601,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SubmitClaimBloc, SubmitClaimState>(
      builder: (context, state) {
        return WillPopScope(
          onWillPop: () async {
            context.navigator.pushCancelClaimsDialog(widget.policySelection);
            return false;
          },
          child: Scaffold(
            appBar: state is SubmitClaimProcessingState
                ? null
                : ClaimsFormAppBar(
                    policy: widget.policySelection,
                    keyLossAndDamageSection: keyLossAndDamageSection,
                    keyReporterSection: keyReporterSection,
                    lossAndDamageSectionStatus: lossAndDamageSectionStatus,
                    reporterSectionStatus: reporterSectionStatus,
                  ),
            body: BlocConsumer<SubmitClaimBloc, SubmitClaimState>(
              listener: (context, state) {
                if (state is SubmitClaimFormInitSuccess) {
                  policyDetails = state.claimFormData.policyDetails!;
                }
                if (state is SubmitClaimFormInitFailure) {
                  context.showErrorSnackBar(
                    text: context.getLocalizationOf.somethingWentWrong,
                  );
                }
              },
              builder: (context, state) {
                if (state is SubmitClaimProcessingState) {
                  return const TfbLoadingOverlay(
                    backgroundColor: TfbBrandColors.grayLowest,
                    spinnerColor: TfbBrandColors.blueHigh,
                  );
                }
                if (state is SubmitClaimPolicyListSuccessState ||
                    state is SubmitClaimInitState) {
                  final dateOfLossSplit = widget.dateOfLoss.split('/');
                  BlocProvider.of<SubmitClaimBloc>(context).add(
                    ClaimFormInitEvent(
                      selectedPolicy: widget.policySelection,
                      dateOfLoss:
                          '${dateOfLossSplit[2]}-${dateOfLossSplit[0]}-${dateOfLossSplit[1]}',
                    ),
                  );
                }

                if (state is SubmitClaimFormInitFailure) {
                  return Padding(
                    padding: const EdgeInsets.only(left: kSpacingLarge),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding:
                              const EdgeInsets.only(bottom: kSpacingMedium),
                          child: Text(
                            context
                                .getLocalizationOf.claimsFileAClaimAppBarTitle,
                            style: context.tfbText.header3
                                .copyWith(color: TfbBrandColors.blueHighest),
                          ),
                        ),
                        Text(
                          context.getLocalizationOf.loadingFormClaimError,
                          style: context.tfbText.caption.copyWith(
                            color: TfbBrandColors.redHigh,
                          ),
                        ),
                      ],
                    ),
                  );
                }

                return TfbDropShadowScrollWidget(
                  showFooterShadow: true,
                  child: Form(
                    key: _formKey,
                    child: ListView(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: kSpacingLarge,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              FileAClaimFormHeader(
                                policyType: PolicyType.homeowners,
                                insuredName: widget.policySelection.insuredName,
                                policyNumber:
                                    widget.policySelection.policyNumber,
                                keyReporterSection: keyReporterSection,
                                keyLossAndDamageSection:
                                    keyLossAndDamageSection,
                                reporterSectionStatus: reporterSectionStatus,
                                lossAndDamageSectionStatus:
                                    lossAndDamageSectionStatus,
                              ),
                              const SizedBox(
                                height: kSpacingLarge,
                              ),
                              PreferredSection(
                                isFormValid: isPreferredFormValid,
                                preferredContactPhoneFieldController:
                                    preferredContactPhoneFieldController,
                                preferredContactType: preferredContactType,
                              ),
                              const SizedBox(
                                height: kSpacingLarge,
                              ),
                              ReporterInfoSection(
                                isFormValid: isReporterInfoFormValid,
                                insuredName: widget.policySelection.insuredName,
                                reporterInfoNotifier:
                                    reporterInformationNotifier,
                              ),
                              const SizedBox(
                                height: kSpacingLarge,
                              ),
                              VisibilityDetector(
                                key: keyVisibilityDetectorLossAndDamage,
                                onVisibilityChanged: (visibilityInfo) {
                                  if (visibilityInfo.visibleFraction > 0 &&
                                      lossAndDamageSectionStatus.value ==
                                          ProgressIndicatorStatus.notStarted) {
                                    lossAndDamageSectionStatus.value =
                                        ProgressIndicatorStatus.inProgress;
                                  }
                                },
                                child: LossAndDamageSection(
                                  isFormValid: isLossAndDamageFormValid,
                                  dateOfLoss: widget.dateOfLoss,
                                  lossInfoNotifier: lossInformationNotifier,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
            bottomNavigationBar: state is SubmitClaimProcessingState
                ? null
                : SubmitClaimButton(
                    listanableList: [
                      isPreferredFormValid,
                      isReporterInfoFormValid,
                      isLossAndDamageFormValid,
                    ],
                    onPressed: () {
                      context.navigator.pushToAddPhotosHomeOwnerPage(
                        ClaimSubmission(
                          policyType: widget.policySelection.policyType,
                          claimFormAnswers:
                              _createSubmissionModel(policyDetails!),
                          policySelection: widget.policySelection,
                          dateOfLoss: widget.dateOfLoss,
                        ),
                      );
                    },
                  ),
          ),
        );
      },
    );
  }
}
