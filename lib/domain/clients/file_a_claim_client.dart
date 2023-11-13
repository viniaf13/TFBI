// coverage:ignore-file

import 'package:txfb_insurance_flutter/data/data.dart';
import 'package:txfb_insurance_flutter/data/network/clients/tfb_client.dart';
import 'package:txfb_insurance_flutter/domain/models/claims/file_a_claim/auto_claim/submit_claim_auto.dart';
import 'package:txfb_insurance_flutter/domain/models/claims/file_a_claim/auto_claim/submit_claim_auto_loss_types.dart';
import 'package:txfb_insurance_flutter/domain/models/claims/file_a_claim/auto_claim/submit_claim_auto_response.dart';
import 'package:txfb_insurance_flutter/domain/models/claims/file_a_claim/auto_claim/submit_claim_vehicle_make.dart';
import 'package:txfb_insurance_flutter/domain/models/claims/file_a_claim/auto_claim/submit_claim_vehicle_model.dart';
import 'package:txfb_insurance_flutter/domain/models/claims/file_a_claim/auto_claim/submit_claim_vehicle_year.dart';
import 'package:txfb_insurance_flutter/domain/models/claims/file_a_claim/property_claim/submit_claim_property.dart';
import 'package:txfb_insurance_flutter/domain/models/claims/file_a_claim/property_claim/submit_claim_property_loss_types.dart';
import 'package:txfb_insurance_flutter/domain/models/claims/file_a_claim/property_claim/submit_claim_property_response.dart';
import 'package:txfb_insurance_flutter/domain/models/claims/file_a_claim/shared/policy_details/policy_details.dart';
import 'package:txfb_insurance_flutter/domain/models/claims/file_a_claim/shared/submit_claim_county.dart';
import 'package:txfb_insurance_flutter/domain/models/claims/file_a_claim/shared/submit_claim_phone_types.dart';
import 'package:txfb_insurance_flutter/domain/models/claims/file_a_claim/shared/submit_claim_reporter_types.dart';

part 'file_a_claim_client.g.dart';

@RestApi()
abstract class FileAClaimClient extends TfbClient {
  factory FileAClaimClient({
    required String baseUrl,
    required Dio dio,
  }) {
    dio.interceptors.add(
      LogInterceptor(
        requestHeader: false,
        responseHeader: false,
        responseBody: true,
      ),
    );

    return _FileAClaimClient(dio, baseUrl: baseUrl);
  }

  // Returns a list of Texas counties
  @GET('$kFileAClaimPath/$kSubmitClaimCounties')
  Future<List<SubmitClaimCounty>> fetchTexasCounties();

  // Returns preferred contact phone types list
  @GET('$kFileAClaimPath/$kSubmitClaimPhones')
  Future<List<SubmitClaimPhoneTypes>> fetchPhoneTypes();

  // Returns reporter types list
  @GET('$kFileAClaimPath/$kSubmitClaimReporters')
  Future<List<SubmitClaimReporterTypes>> fetchReporterTypes();

  // Returns auto loss types; claimType == 0
  @GET(
    '$kFileAClaimPath/$kSubmitClaimLossTypes/0',
  )
  Future<List<SubmitClaimAutoLossTypes>> fetchAutoLossTypes();

  // Returns property loss types; claimType == 1
  @GET('$kFileAClaimPath/$kSubmitClaimLossTypes/1')
  Future<List<SubmitClaimPropertyLossTypes>> fetchPropertyLossTypes();

  // Returns a list of years; needed to fetch makes and models
  @GET('$kFileAClaimPath/$kVehicleYears')
  Future<List<SubmitClaimVehicleYear?>> getVehicleYears();

  // Returns a list of makes; needed to fetch models
  @GET('$kFileAClaimPath/$kVehicleMakes')
  Future<List<SubmitClaimVehicleMake?>> getVehicleMakes(
    @Path(kVehicleYear) String kVehicleYear,
  );

  // Returns a list of model; body requires make and model
  @POST('$kFileAClaimPath/$kVehicleModels')
  Future<List<VehicleModelResponse>> getVehicleModels(
    @Body() VehicleModelRequest vehicleModelRequest,
  );

  @POST('$kFileAClaimAddPath/$kFileAutoClaim')
  Future<AutoClaimSubmissionResponse> fileAutoClaim(
    @Body() AutoClaimSubmission autoClaimSubmission,
  );

  @POST('$kFileAClaimAddPath/$kFilePropertyClaim')
  Future<PropertyClaimSubmissionResponse> filePropertyClaim(
    @Body() PropertyClaimSubmission propertyClaimSubmission,
  );

  // Returns details of the policy for submitting claim
  @GET('$kFileAClaimPath/$kPolicyDetails')
  Future<PolicyDetails> getPolicyDetails(
    @Path(kPolicyNumber) String kPolicyNumber,
    @Path(kPolicySymbol) String kPolicySymbol,
    @Path(kClaimDate) String kClaimDate,
  );

  @POST('$kFileAClaimAddPath/$kSubmitAutoPhoto')
  Future<void> submitPhotoForAutoClaim(
    @Body() FormData data,
    @Path(kClaimId) String kClaimId,
  );

  @POST('$kFileAClaimAddPath/$kSubmitPropertyPhoto')
  Future<void> submitPhotoForPropertyClaim(
    @Body() FormData data,
    @Path(kClaimId) String kClaimId,
  );
}
