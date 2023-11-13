// coverage:ignore-file

import 'package:txfb_insurance_flutter/domain/domain.dart';
import 'package:txfb_insurance_flutter/domain/models/claims/file_a_claim/property_claim/submit_claim_property_primary_insured.dart';
import 'package:txfb_insurance_flutter/domain/models/claims/file_a_claim/shared/submit_claim_base.dart';
import 'package:txfb_insurance_flutter/domain/models/claims/file_a_claim/shared/submit_claim_loss_info.dart';
import 'package:txfb_insurance_flutter/domain/models/claims/file_a_claim/shared/submit_claim_reporter_info.dart';

part 'generated/submit_claim_property.g.dart';

@JsonSerializable()
class PropertyClaimSubmission extends SubmitClaimBase {
  const PropertyClaimSubmission({
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
    this.primaryInsured,
  });

  factory PropertyClaimSubmission.fromJson(Map<String, dynamic> json) =>
      _$PropertyClaimSubmissionFromJson(json);
  Map<String, dynamic> toJson() => _$PropertyClaimSubmissionToJson(this);

  @JsonKey(name: 'primaryInsured')
  final PropertyPrimaryInsured? primaryInsured;

  PropertyClaimSubmission copyWith({
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
    PropertyPrimaryInsured? primaryInsured,
    ReporterInformation? reporterInformation,
    LossInformation? lossInformation,
  }) =>
      PropertyClaimSubmission(
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
