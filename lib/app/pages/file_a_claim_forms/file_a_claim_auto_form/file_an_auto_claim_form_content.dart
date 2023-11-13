import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:txfb_insurance_flutter/app/blocs/claims/submit_claim/submit_claim_bloc.dart';
import 'package:txfb_insurance_flutter/app/pages/file_a_claim_forms/widgets/claim_form_app_bar.dart';
import 'package:txfb_insurance_flutter/app/pages/file_a_claim_forms/widgets/claims_form_progress_indicator.dart';
import 'package:txfb_insurance_flutter/app/pages/file_a_claim_forms/widgets/drivers_and_vehicles_section/drivers_and_vehicles_section.dart';
import 'package:txfb_insurance_flutter/app/pages/file_a_claim_forms/widgets/file_a_claim_form_header.dart';
import 'package:txfb_insurance_flutter/app/pages/file_a_claim_forms/widgets/generic_fields/submit_claim_button.dart';
import 'package:txfb_insurance_flutter/app/pages/file_a_claim_forms/widgets/loss_and_damage_section/loss_and_damage_section.dart';
import 'package:txfb_insurance_flutter/app/pages/file_a_claim_forms/widgets/preferred_section/preferred_section.dart';
import 'package:txfb_insurance_flutter/app/pages/file_a_claim_forms/widgets/reporter_info_section/reporter_info_section.dart';
import 'package:txfb_insurance_flutter/app/router/router.dart';
import 'package:txfb_insurance_flutter/domain/models/claims/file_a_claim/policy_selection.dart';
import 'package:txfb_insurance_flutter/domain/domain.dart';
import 'package:txfb_insurance_flutter/domain/models/claims/file_a_claim/auto_claim/submit_claim_auto.dart';
import 'package:txfb_insurance_flutter/domain/models/claims/file_a_claim/auto_claim/submit_claim_auto_information.dart';
import 'package:txfb_insurance_flutter/domain/models/claims/file_a_claim/auto_claim/submit_claim_auto_primary_insured.dart';
import 'package:txfb_insurance_flutter/domain/models/claims/file_a_claim/shared/submit_claim_loss_info.dart';
import 'package:txfb_insurance_flutter/domain/models/claims/file_a_claim/auto_claim/submit_claim_vehicle.dart';
import 'package:txfb_insurance_flutter/domain/models/claims/file_a_claim/shared/policy_details/policy_details.dart';
import 'package:txfb_insurance_flutter/domain/models/claims/file_a_claim/shared/submit_claim_reporter_info.dart';
import 'package:txfb_insurance_flutter/domain/models/file_a_claim/claim_submission.dart';
import 'package:txfb_insurance_flutter/resources/theme/colors/tfb_brand_colors.dart';
import 'package:txfb_insurance_flutter/shared/enum/file_a_claim_destination.dart';
import 'package:txfb_insurance_flutter/shared/enum/file_a_claim_type.dart';
import 'package:txfb_insurance_flutter/shared/mixins/page_properties_mixin.dart';
import 'package:txfb_insurance_flutter/shared/shared.dart';
import 'package:txfb_insurance_flutter/shared/widgets/tfb_dropshadow_scroll_widget.dart';
import 'package:visibility_detector/visibility_detector.dart';

class FileAnAutoClaimFormContent extends StatefulWidget
    with PagePropertiesMixin {
  const FileAnAutoClaimFormContent({
    required this.policySelection,
    required this.dateOfLoss,
    super.key,
  });

  final PolicySelection policySelection;
  final String dateOfLoss;

  @override
  String get screenName => 'Auto claim form';

  @override
  State<FileAnAutoClaimFormContent> createState() =>
      _FileAnAutoClaimFormContentState();
}

class _FileAnAutoClaimFormContentState
    extends State<FileAnAutoClaimFormContent> {
  final isPreferredFormValid = ValueNotifier(false);
  final isReporterInfoFormValid = ValueNotifier(false);
  final isLossAndDamageFormValid = ValueNotifier(false);
  final isDriversAndVehiclesFormValid = ValueNotifier(false);
  final selectedDriver = ValueNotifier<Driver?>(null);
  final selectedVehicle = ValueNotifier<Vehicle?>(null);

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final preferedPhoneNumberController = TextEditingController();
  final preferedPhoneTypeNotifier = ValueNotifier<String?>(null);
  final reporterInformationNotifier = ValueNotifier<ReporterInformation>(
    const ReporterInformation(),
  );
  final lossInformationNotifier = ValueNotifier<LossInformation>(
    const LossInformation(),
  );
  final insuredDriverInformationNotifier = ValueNotifier<AutoPrimaryInsured>(
    const AutoPrimaryInsured(),
  );
  final insuredVehicleInformationNotifier = ValueNotifier<SubmitClaimVehicle>(
    const SubmitClaimVehicle(),
  );
  final thirdPartyDriverInformationNotifier =
      ValueNotifier<AutoPrimaryInsured?>(
    null,
  );
  final thirdPartyVehicleInformationNotifier =
      ValueNotifier<SubmitClaimVehicle?>(
    null,
  );
  final isNewDriverNotifier = ValueNotifier<bool>(false);
  final hasFormBeenSubmitedNotifier = ValueNotifier<bool>(false);

  final keyReporterSection = GlobalKey();
  final keyLossAndDamageSection = GlobalKey();
  final keyDriversAndVehiclesSection = GlobalKey();

  final reporterSectionStatus = ValueNotifier<ProgressIndicatorStatus>(
    ProgressIndicatorStatus.inProgress,
  );
  final lossAndDamageSectionStatus = ValueNotifier<ProgressIndicatorStatus>(
    ProgressIndicatorStatus.notStarted,
  );
  final driversAndVehiclesSectionStatus =
      ValueNotifier<ProgressIndicatorStatus>(
    ProgressIndicatorStatus.notStarted,
  );
  final keyVisibilityDetectorLossAndDamage = UniqueKey();
  final keyVisibilityDetectorDriversAndVehicles = UniqueKey();

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
    isDriversAndVehiclesFormValid.addListener(() {
      driversAndVehiclesSectionStatus.value =
          isDriversAndVehiclesFormValid.value
              ? ProgressIndicatorStatus.completed
              : ProgressIndicatorStatus.inProgress;
    });
    super.initState();
  }

  @override
  void dispose() {
    isPreferredFormValid.dispose();
    isReporterInfoFormValid.dispose();
    isLossAndDamageFormValid.dispose();
    isDriversAndVehiclesFormValid.dispose();
    super.dispose();
  }

  //It is necessary for unit test execution
  // ignore: avoid_init_to_null
  late PolicyDetails? policyDetails = null;

  AutoClaimSubmission _createSubmissionModel(
    PolicyDetails policyDetails,
  ) {
    final tbiOfficeTimeZone = tz.getLocation('America/Chicago');

    final DateTime dateTime =
        DateTime.parse(lossInformationNotifier.value.timeOfLoss!);

    final dateOfLossAsIso8601 =
        tz.TZDateTime.from(dateTime, tbiOfficeTimeZone).toIso8601String();

    return AutoClaimSubmission(
      claimDestination: FileAClaimDestination.claimStar.value,
      claimType: FileAClaimType.auto.value.toString(),
      policyNumber: policyDetails.policyNumber,
      policyType: policyDetails.policyType,
      policySubType: policyDetails.policySubType,
      policySymbol: policyDetails.policySymbol,
      effectiveDate: policyDetails.effectiveDate,
      expirationDate: policyDetails.expirationDate,
      memberNumber: policyDetails.memberNumber,
      externalIdValTxt: policyDetails.externalIdValTxt,
      companyName: policyDetails.companyName,
      corporationName: policyDetails.corporationName,
      primaryInsured: AutoPrimaryInsured(
        emailAddress: policyDetails.primaryInsured?.emailAddress,
        name: policyDetails.primaryInsured?.name,
        insuredType: policyDetails.primaryInsured?.insuredType,
        gender: policyDetails.primaryInsured?.gender,
        maritalStatus: policyDetails.primaryInsured?.maritalStatus,
        dateOfBirth: policyDetails.primaryInsured?.dateOfBirth,
        address: policyDetails.primaryInsured?.address,
        primaryInd: policyDetails.primaryInsured?.primaryInd,
        phone: preferedPhoneNumberController.text,
        phoneType: preferedPhoneTypeNotifier.value,
        licenseNumber: policyDetails.primaryInsured?.licenseNumber,
        licenseClass: policyDetails.primaryInsured?.licenseClass,
        licenseState: policyDetails.primaryInsured?.licenseState,
      ),
      insuredInformation: [
        AutoClaimInformation(
          driver: insuredDriverInformationNotifier.value,
          vehicle: insuredVehicleInformationNotifier.value,
        ),
      ],
      thirdPartyInformation: thirdPartyDriverInformationNotifier.value != null
          ? [
              AutoClaimInformation(
                driver: thirdPartyDriverInformationNotifier.value,
                vehicle: thirdPartyVehicleInformationNotifier.value,
              ),
            ]
          : [],
      lossInformation: lossInformationNotifier.value.copyWith(
        dateOfLoss: dateOfLossAsIso8601,
        timeOfLoss: dateOfLossAsIso8601,
      ),
      reporterInformation: reporterInformationNotifier.value,
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
                    keyDriversAndVehiclesSection: keyDriversAndVehiclesSection,
                    keyLossAndDamageSection: keyLossAndDamageSection,
                    keyReporterSection: keyReporterSection,
                    driversAndVehiclesSectionStatus:
                        driversAndVehiclesSectionStatus,
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
                    child: Text(
                      context.getLocalizationOf.loadingFormClaimError,
                      style: context.tfbText.caption.copyWith(
                        color: TfbBrandColors.redHigh,
                      ),
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
                                policyType: PolicyType.txPersonalAuto,
                                insuredName: widget.policySelection.insuredName,
                                policyNumber:
                                    widget.policySelection.policyNumber,
                                keyReporterSection: keyReporterSection,
                                keyLossAndDamageSection:
                                    keyLossAndDamageSection,
                                keyDriversAndVehiclesSection:
                                    keyDriversAndVehiclesSection,
                                reporterSectionStatus: reporterSectionStatus,
                                lossAndDamageSectionStatus:
                                    lossAndDamageSectionStatus,
                                driversAndVehiclesSectionStatus:
                                    driversAndVehiclesSectionStatus,
                              ),
                              const SizedBox(
                                height: kSpacingLarge,
                              ),
                              PreferredSection(
                                isFormValid: isPreferredFormValid,
                                preferredContactPhoneFieldController:
                                    preferedPhoneNumberController,
                                preferredContactType: preferedPhoneTypeNotifier,
                                key: keyReporterSection,
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
                                  key: keyLossAndDamageSection,
                                ),
                              ),
                              const SizedBox(
                                height: kSpacingLarge,
                              ),
                              VisibilityDetector(
                                key: keyVisibilityDetectorDriversAndVehicles,
                                onVisibilityChanged: (visibilityInfo) {
                                  if (visibilityInfo.visibleFraction > 0 &&
                                      driversAndVehiclesSectionStatus.value ==
                                          ProgressIndicatorStatus.notStarted) {
                                    driversAndVehiclesSectionStatus.value =
                                        ProgressIndicatorStatus.inProgress;
                                  }
                                },
                                child: DriversAndVehiclesSection(
                                  isFormValid: isDriversAndVehiclesFormValid,
                                  insuredDriverInfoNotifier:
                                      insuredDriverInformationNotifier,
                                  insuredVehicleInfoNotifier:
                                      insuredVehicleInformationNotifier,
                                  thirdPartyDriverInfoNotifier:
                                      thirdPartyDriverInformationNotifier,
                                  thirdPartyVehicleInfoNotifier:
                                      thirdPartyVehicleInformationNotifier,
                                  isNewDriverNotifier: isNewDriverNotifier,
                                  hasFormBeenSubmitedNotifier:
                                      hasFormBeenSubmitedNotifier,
                                  key: keyDriversAndVehiclesSection,
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
                      isDriversAndVehiclesFormValid,
                    ],
                    onPressed: () {
                      context.navigator.pushToAddPhotosAutoPage(
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
