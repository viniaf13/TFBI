import 'package:txfb_insurance_flutter/domain/models/claims/file_a_claim/shared/submit_claim_loss_info.dart';
import 'package:txfb_insurance_flutter/domain/models/claims/file_a_claim/shared/submit_claim_reporter_info.dart';
import 'package:txfb_insurance_flutter/texas_farm_bureau_insurance.dart';

class SubmitClaimBase {
  const SubmitClaimBase({
    this.claimDestination,
    this.claimType,
    this.effectiveDate,
    this.expirationDate,
    this.memberNumber,
    this.policyNumber,
    this.policySymbol,
    this.policyType,
    this.policySubType,
    this.externalIdValTxt,
    this.companyName,
    this.corporationName,
    this.hasPhotos,
    this.reporterInformation,
    this.lossInformation,
  });

  @JsonKey(name: 'claimDestination')
  final int? claimDestination;
  @JsonKey(name: 'claimType')
  final String? claimType;
  @JsonKey(name: 'effectiveDate')
  final String? effectiveDate;
  @JsonKey(name: 'expirationDate')
  final String? expirationDate;
  @JsonKey(name: 'memberNumber')
  final String? memberNumber;
  @JsonKey(name: 'policyNumber')
  final String? policyNumber;
  @JsonKey(name: 'policySymbol')
  final String? policySymbol;
  @JsonKey(name: 'policyType')
  final String? policyType;
  @JsonKey(name: 'policySubType')
  final String? policySubType;
  @JsonKey(name: 'externalIdValTxt')
  final String? externalIdValTxt;
  @JsonKey(name: 'companyName')
  final String? companyName;
  @JsonKey(name: 'corporationName')
  final String? corporationName;
  @JsonKey(name: 'hasPhotos')
  final String? hasPhotos;
  @JsonKey(name: 'reporterInformation')
  final ReporterInformation? reporterInformation;
  @JsonKey(name: 'lossInformation')
  final LossInformation? lossInformation;
}
