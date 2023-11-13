// coverage:ignore-file

import 'package:json_annotation/json_annotation.dart';
import 'package:txfb_insurance_flutter/domain/models/claims/claims.dart';
import 'package:txfb_insurance_flutter/domain/models/claims/file_a_claim/auto_claim/submit_claim_auto_information.dart';
import 'package:txfb_insurance_flutter/domain/models/claims/file_a_claim/auto_claim/submit_claim_auto_primary_insured.dart';
import 'package:txfb_insurance_flutter/domain/models/claims/file_a_claim/shared/submit_claim_base.dart';
import 'package:txfb_insurance_flutter/domain/models/claims/file_a_claim/shared/submit_claim_loss_info.dart';
import 'package:txfb_insurance_flutter/domain/models/claims/file_a_claim/shared/submit_claim_reporter_info.dart';

part 'generated/submit_claim_auto.g.dart';

@JsonSerializable()
class AutoClaimSubmission extends SubmitClaimBase {
  const AutoClaimSubmission({
    super.claimDestination,
    super.claimType,
    super.effectiveDate,
    super.expirationDate,
    super.memberNumber,
    super.policyNumber,
    super.policySymbol,
    super.policyType,
    super.policySubType,
    super.externalIdValTxt,
    super.companyName,
    super.corporationName,
    super.hasPhotos,
    super.reporterInformation,
    super.lossInformation,
    this.insuredInformation,
    this.thirdPartyInformation,
    this.primaryInsured,
  });

  factory AutoClaimSubmission.fromJson(Map<String, dynamic> json) =>
      _$AutoClaimSubmissionFromJson(json);
  Map<String, dynamic> toJson() => _$AutoClaimSubmissionToJson(this);

  @JsonKey(name: 'insuredInformation')
  final List<AutoClaimInformation>? insuredInformation;
  @JsonKey(name: 'thirdPartyInformation')
  final List<AutoClaimInformation>? thirdPartyInformation;
  @JsonKey(name: 'primaryInsured')
  final AutoPrimaryInsured? primaryInsured;

  AutoClaimSubmission copyWith({
    List<AutoClaimInformation>? insuredInformation,
    List<AutoClaimInformation>? thirdPartyInformation,
    int? claimDestination,
    String? claimType,
    String? effectiveDate,
    String? expirationDate,
    String? memberNumber,
    String? policyNumber,
    String? policySymbol,
    String? policyType,
    String? policySubType,
    String? externalIdValTxt,
    String? companyName,
    String? corporationName,
    String? hasPhotos,
    AutoPrimaryInsured? primaryInsured,
    ReporterInformation? reporterInformation,
    LossInformation? lossInformation,
  }) =>
      AutoClaimSubmission(
        insuredInformation: insuredInformation ?? this.insuredInformation,
        thirdPartyInformation:
            thirdPartyInformation ?? this.thirdPartyInformation,
        claimDestination: claimDestination ?? this.claimDestination,
        claimType: claimType ?? this.claimType,
        effectiveDate: effectiveDate ?? this.effectiveDate,
        expirationDate: expirationDate ?? this.expirationDate,
        memberNumber: memberNumber ?? this.memberNumber,
        policyNumber: policyNumber ?? this.policyNumber,
        policySymbol: policySymbol ?? this.policySymbol,
        policyType: policyType ?? this.policyType,
        policySubType: policySubType ?? this.policySubType,
        externalIdValTxt: externalIdValTxt ?? this.externalIdValTxt,
        companyName: companyName ?? this.companyName,
        corporationName: corporationName ?? this.corporationName,
        hasPhotos: hasPhotos ?? this.hasPhotos,
        primaryInsured: primaryInsured ?? this.primaryInsured,
        reporterInformation: reporterInformation ?? this.reporterInformation,
        lossInformation: lossInformation ?? this.lossInformation,
      );
}
