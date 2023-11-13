import 'package:txfb_insurance_flutter/data/data.dart';
import 'package:txfb_insurance_flutter/domain/clients/document_information_client.dart';
import 'package:txfb_insurance_flutter/domain/clients/file_a_claim_client.dart';
import 'package:txfb_insurance_flutter/domain/models/claims/file_a_claim/auto_claim/submit_claim_auto.dart';
import 'package:txfb_insurance_flutter/domain/models/claims/file_a_claim/auto_claim/submit_claim_auto_loss_types.dart';
import 'package:txfb_insurance_flutter/domain/models/claims/file_a_claim/auto_claim/submit_claim_vehicle_make.dart';
import 'package:txfb_insurance_flutter/domain/models/claims/file_a_claim/auto_claim/submit_claim_vehicle_model.dart';
import 'package:txfb_insurance_flutter/domain/models/claims/file_a_claim/auto_claim/submit_claim_vehicle_year.dart';
import 'package:txfb_insurance_flutter/domain/models/claims/file_a_claim/enum/submit_claim_us_states.dart';
import 'package:txfb_insurance_flutter/domain/models/claims/file_a_claim/policy_selection.dart';
import 'package:txfb_insurance_flutter/domain/models/claims/file_a_claim/auto_claim/submit_claim_auto_response.dart';
import 'package:txfb_insurance_flutter/domain/models/claims/file_a_claim/property_claim/submit_claim_property.dart';
import 'package:txfb_insurance_flutter/domain/models/claims/file_a_claim/property_claim/submit_claim_property_loss_types.dart';
import 'package:txfb_insurance_flutter/domain/models/claims/file_a_claim/property_claim/submit_claim_property_response.dart';
import 'package:txfb_insurance_flutter/domain/models/claims/file_a_claim/shared/claim_form_data.dart';
import 'package:txfb_insurance_flutter/domain/models/claims/file_a_claim/shared/policy_details/policy_details.dart';
import 'package:txfb_insurance_flutter/domain/models/claims/file_a_claim/shared/submit_claim_county.dart';
import 'package:txfb_insurance_flutter/domain/models/claims/file_a_claim/shared/submit_claim_phone_types.dart';
import 'package:txfb_insurance_flutter/domain/models/claims/file_a_claim/shared/submit_claim_reporter_types.dart';
import 'package:txfb_insurance_flutter/domain/models/policy/auto_policy_detail.dart';
import 'package:txfb_insurance_flutter/domain/repositories/tfb_policy_lookup_repository.dart';

class TfbFileClaimRepository {
  TfbFileClaimRepository({
    required FileAClaimClient fileClaimClient,
    required TfbDocumentInformationClient documentClient,
    required TfbPolicyLookupRepository policyLookUp,
  })  : _fileClaimClient = fileClaimClient,
        _documentClient = documentClient,
        _policyLookUp = policyLookUp;

  final FileAClaimClient _fileClaimClient;
  final TfbDocumentInformationClient _documentClient;
  final TfbPolicyLookupRepository _policyLookUp;

  /// FileAClaimClient Calls ///
  Future<List<SubmitClaimCounty>> fetchTexasCounties() async =>
      _fileClaimClient.fetchTexasCounties();

  Future<List<SubmitClaimPhoneTypes>> fetchPhoneTypes() async =>
      _fileClaimClient.fetchPhoneTypes();

  Future<List<SubmitClaimReporterTypes>> fetchReporterTypes() async =>
      _fileClaimClient.fetchReporterTypes();

  Future<List<SubmitClaimAutoLossTypes>> fetchAutoLossTypes() async =>
      _fileClaimClient.fetchAutoLossTypes();

  Future<List<SubmitClaimPropertyLossTypes>> fetchPropertyLossTypes() async =>
      _fileClaimClient.fetchPropertyLossTypes();

  // Return list of vehicle years needed to file a claim
  Future<List<SubmitClaimVehicleYear?>> getVehicleYears() async =>
      _fileClaimClient.getVehicleYears();

  Future<List<SubmitClaimVehicleMake?>> getVehicleMakes(String year) async =>
      _fileClaimClient.getVehicleMakes(year);

  // Returns a list of model; @Post requires body with year and make
  Future<List<VehicleModelResponse?>> getVehicleModels(
    VehicleModelRequest request,
  ) async =>
      _fileClaimClient.getVehicleModels(request);

  Future<AutoClaimSubmissionResponse> fileAutoClaim(
    AutoClaimSubmission autoClaimSubmission,
  ) async =>
      _fileClaimClient.fileAutoClaim(autoClaimSubmission);

  Future<PropertyClaimSubmissionResponse> filePropertyClaim(
    PropertyClaimSubmission propertyClaimSubmission,
  ) async =>
      _fileClaimClient.filePropertyClaim(propertyClaimSubmission);

  /// TfbDocumentInformationClient ///
  Future<AutoPolicyDetail> getPersonalSixMonthAutoPolicyAbbreviated(
    String policyNumber,
  ) =>
      _documentClient.getPersonalSixMonthAutoPolicyAbbreviated(policyNumber);

  /// Fetches selection of active policies for dropdown selector to file a claim
  Future<List<PolicySelection?>> getPolicySelections() async {
    final summary = await _policyLookUp.getMemberSummary();
    return summary.policiesForClaims();
  }

  Future<PolicyDetails> getPolicyDetails(
    String policyNumber,
    String policySymbol,
    String claimDate,
  ) {
    return _fileClaimClient.getPolicyDetails(
      policyNumber,
      policySymbol,
      claimDate,
    );
  }

  /// Fetches data needed for dropdown menus on Claim Form
  Future<ClaimFormData> getFormData(
    String policyNumber, {
    String policySymbol = '',
    String claimDate = '',
    bool isAutoClaim = false,
  }) async {
    final autoPolicyDetail = isAutoClaim
        ? await getPersonalSixMonthAutoPolicyAbbreviated(policyNumber)
        : null;

    return ClaimFormData(
      contactType: await fetchPhoneTypes(),
      reporterType: await fetchReporterTypes(),
      typeOfLoss: isAutoClaim
          ? (await fetchAutoLossTypes())
              .where((lossType) => lossType.lob == 'pa')
              .toList()
          : await fetchPropertyLossTypes(),
      county: await fetchTexasCounties()
        ..add(
          const SubmitClaimCounty(countyCode: 'other', countyName: 'Other'),
        ),
      state: SubmitClaimUsStates.values,
      // No api end-point; hard-coded
      insuredDrivers: autoPolicyDetail?.coveredDrivers ?? [],
      insuredVehicles: autoPolicyDetail?.vehicles ?? [],
      vehicleYears: isAutoClaim ? await getVehicleYears() : [],
      policyDetails:
          await getPolicyDetails(policyNumber, policySymbol, claimDate),
    );
  }
}
