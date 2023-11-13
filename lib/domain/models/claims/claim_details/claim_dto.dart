// coverage:ignore-file
import 'package:txfb_insurance_flutter/domain/models/claims/claims.dart';

part 'claim_dto.g.dart';

@JsonSerializable()
class ClaimDto {
  ClaimDto({
    this.literalDescriptionMap,
    this.recordId,
    this.version,
    this.updated,
    this.childUpdated,
    this.dtoUtilsSynchronized,
    this.userIdCreated,
    this.createdDateTime,
    this.userIdUpdated,
    this.updatedDateTime,
    this.delInd,
    this.claimTypeCode,
    this.jurisdictionId,
    this.notificationPhoneTypeCode,
    this.notificationPhoneNumber,
    this.notificationSourceCode,
    this.notificationMethodCode,
    this.lossDateTimeZoneCode,
    this.notificationDateTimeZoneCode,
    this.claimNumber,
    this.callerName,
    this.lossDescription,
    this.dateOfLossDate,
    this.notificationDate,
    this.lossDateTime,
    this.notificationTime,
    this.catManualFlag,
    this.claimSourceCode,
    this.companyLobId,
    this.lobCode,
    this.unverifiedPolicy,
    this.occurrenceDateVerifyIndicator,
    this.claimPolicyNumber,
    this.causeOfLossCode,
    this.coverages,
    this.calClaimReportDate,
    this.claimAliasNumbers,
    this.reinsuranceRetentionDetail,
    this.claimJurisdictionProfiles,
    this.claimLossProfiles,
    this.claimLossIndicatorProfiles,
    this.claimPolicyIndicatorProfiles,
    this.clmAddress,
    this.claimStatus,
    this.claimIndicators,
  });

  factory ClaimDto.fromJson(Map<String, dynamic> json) =>
      _$ClaimDtoFromJson(json);
  Map<String, dynamic> toJson() => _$ClaimDtoToJson(this);

  @JsonKey(name: 'literalDescriptionMap')
  final ClaimLiteralDescriptionMap? literalDescriptionMap;
  @JsonKey(name: 'recordId')
  final String? recordId;
  @JsonKey(name: 'version')
  final String? version;
  @JsonKey(name: 'updated')
  final String? updated;
  @JsonKey(name: 'childUpdated')
  final String? childUpdated;
  @JsonKey(name: 'dtoUtilsSynchronized')
  final String? dtoUtilsSynchronized;
  @JsonKey(name: 'userIdCreated')
  final String? userIdCreated;
  @JsonKey(name: 'createdDateTime')
  final String? createdDateTime;
  @JsonKey(name: 'userIdUpdated')
  final String? userIdUpdated;
  @JsonKey(name: 'updatedDateTime')
  final String? updatedDateTime;
  @JsonKey(name: 'delInd')
  final String? delInd;
  @JsonKey(name: 'claimTypeCode')
  final String? claimTypeCode;
  @JsonKey(name: 'jurisdictionId')
  final String? jurisdictionId;
  @JsonKey(name: 'notificationPhoneTypeCode')
  final String? notificationPhoneTypeCode;
  @JsonKey(name: 'notificationPhoneNumber')
  final String? notificationPhoneNumber;
  @JsonKey(name: 'notificationSourceCode')
  final String? notificationSourceCode;
  @JsonKey(name: 'notificationMethodCode')
  final String? notificationMethodCode;
  @JsonKey(name: 'lossDateTimeZoneCode')
  final String? lossDateTimeZoneCode;
  @JsonKey(name: 'notificationDateTimeZoneCode')
  final String? notificationDateTimeZoneCode;
  @JsonKey(name: 'claimNumber')
  final String? claimNumber;
  @JsonKey(name: 'callerName')
  final String? callerName;
  @JsonKey(name: 'lossDescription')
  final String? lossDescription;
  @JsonKey(name: 'dateOfLossDate')
  final String? dateOfLossDate;
  @JsonKey(name: 'notificationDate')
  final String? notificationDate;
  @JsonKey(name: 'lossDateTime')
  final String? lossDateTime;
  @JsonKey(name: 'notificationTime')
  final String? notificationTime;
  @JsonKey(name: 'catManualFlag')
  final String? catManualFlag;
  @JsonKey(name: 'claimSourceCode')
  final String? claimSourceCode;
  @JsonKey(name: 'companyLobId')
  final String? companyLobId;
  @JsonKey(name: 'lobCode')
  final String? lobCode;
  @JsonKey(name: 'unverifiedPolicy')
  final String? unverifiedPolicy;
  @JsonKey(name: 'occurrenceDateVerifyIndicator')
  final String? occurrenceDateVerifyIndicator;
  @JsonKey(name: 'claimPolicyNumber')
  final String? claimPolicyNumber;
  @JsonKey(name: 'causeOfLossCode')
  final String? causeOfLossCode;
  @JsonKey(name: 'coverages')
  final String? coverages;
  @JsonKey(name: 'calClaimReportDate')
  final String? calClaimReportDate;
  @JsonKey(name: 'claimAliasNumbers')
  final String? claimAliasNumbers;
  @JsonKey(name: 'reinsuranceRetentionDetail')
  final String? reinsuranceRetentionDetail;
  @JsonKey(name: 'claimJurisdictionProfiles')
  final String? claimJurisdictionProfiles;
  @JsonKey(name: 'claimLossProfiles')
  final String? claimLossProfiles;
  @JsonKey(name: 'claimLossIndicatorProfiles')
  final String? claimLossIndicatorProfiles;
  @JsonKey(name: 'claimPolicyIndicatorProfiles')
  final String? claimPolicyIndicatorProfiles;
  @JsonKey(name: 'clmAddress')
  final List<ClaimAddress>? clmAddress;
  @JsonKey(name: 'claimStatus')
  final List<ClaimStatus>? claimStatus;
  @JsonKey(name: 'claimIndicators')
  final List<ClaimIndicator>? claimIndicators;

  ClaimDto copyWith({
    ClaimLiteralDescriptionMap? literalDescriptionMap,
    String? recordId,
    String? version,
    String? updated,
    String? childUpdated,
    String? dtoUtilsSynchronized,
    String? userIdCreated,
    String? createdDateTime,
    String? userIdUpdated,
    String? updatedDateTime,
    String? delInd,
    String? claimTypeCode,
    String? jurisdictionId,
    String? notificationPhoneTypeCode,
    String? notificationPhoneNumber,
    String? notificationSourceCode,
    String? notificationMethodCode,
    String? lossDateTimeZoneCode,
    String? notificationDateTimeZoneCode,
    String? claimNumber,
    String? callerName,
    String? lossDescription,
    String? dateOfLossDate,
    String? notificationDate,
    String? lossDateTime,
    String? notificationTime,
    String? catManualFlag,
    String? claimSourceCode,
    String? companyLobId,
    String? lobCode,
    String? unverifiedPolicy,
    String? occurrenceDateVerifyIndicator,
    String? claimPolicyNumber,
    String? causeOfLossCode,
    String? coverages,
    String? calClaimReportDate,
    String? claimAliasNumbers,
    String? reinsuranceRetentionDetail,
    String? claimJurisdictionProfiles,
    String? claimLossProfiles,
    String? claimLossIndicatorProfiles,
    String? claimPolicyIndicatorProfiles,
    List<ClaimAddress>? clmAddress,
    List<ClaimStatus>? claimStatus,
    List<ClaimIndicator>? claimIndicators,
  }) =>
      ClaimDto(
        literalDescriptionMap:
            literalDescriptionMap ?? this.literalDescriptionMap,
        recordId: recordId ?? this.recordId,
        version: version ?? this.version,
        updated: updated ?? this.updated,
        childUpdated: childUpdated ?? this.childUpdated,
        dtoUtilsSynchronized: dtoUtilsSynchronized ?? this.dtoUtilsSynchronized,
        userIdCreated: userIdCreated ?? this.userIdCreated,
        createdDateTime: createdDateTime ?? this.createdDateTime,
        userIdUpdated: userIdUpdated ?? this.userIdUpdated,
        updatedDateTime: updatedDateTime ?? this.updatedDateTime,
        delInd: delInd ?? this.delInd,
        claimTypeCode: claimTypeCode ?? this.claimTypeCode,
        jurisdictionId: jurisdictionId ?? this.jurisdictionId,
        notificationPhoneTypeCode:
            notificationPhoneTypeCode ?? this.notificationPhoneTypeCode,
        notificationPhoneNumber:
            notificationPhoneNumber ?? this.notificationPhoneNumber,
        notificationSourceCode:
            notificationSourceCode ?? this.notificationSourceCode,
        notificationMethodCode:
            notificationMethodCode ?? this.notificationMethodCode,
        lossDateTimeZoneCode: lossDateTimeZoneCode ?? this.lossDateTimeZoneCode,
        notificationDateTimeZoneCode:
            notificationDateTimeZoneCode ?? this.notificationDateTimeZoneCode,
        claimNumber: claimNumber ?? this.claimNumber,
        callerName: callerName ?? this.callerName,
        lossDescription: lossDescription ?? this.lossDescription,
        dateOfLossDate: dateOfLossDate ?? this.dateOfLossDate,
        notificationDate: notificationDate ?? this.notificationDate,
        lossDateTime: lossDateTime ?? this.lossDateTime,
        notificationTime: notificationTime ?? this.notificationTime,
        catManualFlag: catManualFlag ?? this.catManualFlag,
        claimSourceCode: claimSourceCode ?? this.claimSourceCode,
        companyLobId: companyLobId ?? this.companyLobId,
        lobCode: lobCode ?? this.lobCode,
        unverifiedPolicy: unverifiedPolicy ?? this.unverifiedPolicy,
        occurrenceDateVerifyIndicator:
            occurrenceDateVerifyIndicator ?? this.occurrenceDateVerifyIndicator,
        claimPolicyNumber: claimPolicyNumber ?? this.claimPolicyNumber,
        causeOfLossCode: causeOfLossCode ?? this.causeOfLossCode,
        coverages: coverages ?? this.coverages,
        calClaimReportDate: calClaimReportDate ?? this.calClaimReportDate,
        claimAliasNumbers: claimAliasNumbers ?? this.claimAliasNumbers,
        reinsuranceRetentionDetail:
            reinsuranceRetentionDetail ?? this.reinsuranceRetentionDetail,
        claimJurisdictionProfiles:
            claimJurisdictionProfiles ?? this.claimJurisdictionProfiles,
        claimLossProfiles: claimLossProfiles ?? this.claimLossProfiles,
        claimLossIndicatorProfiles:
            claimLossIndicatorProfiles ?? this.claimLossIndicatorProfiles,
        claimPolicyIndicatorProfiles:
            claimPolicyIndicatorProfiles ?? this.claimPolicyIndicatorProfiles,
        clmAddress: clmAddress ?? this.clmAddress,
        claimStatus: claimStatus ?? this.claimStatus,
        claimIndicators: claimIndicators ?? this.claimIndicators,
      );

  @override
  String toString() {
    return 'ClaimDto {\n'
        '  literalDescriptionMap: $literalDescriptionMap\n'
        '  recordId: $recordId\n'
        '  version: $version\n'
        '  updated: $updated\n'
        '  childUpdated: $childUpdated\n'
        '  dtoUtilsSynchronized: $dtoUtilsSynchronized\n'
        '  userIdCreated: $userIdCreated\n'
        '  createdDateTime: $createdDateTime\n'
        '  userIdUpdated: $userIdUpdated\n'
        '  updatedDateTime: $updatedDateTime\n'
        '  delInd: $delInd\n'
        '  claimTypeCode: $claimTypeCode\n'
        '  jurisdictionId: $jurisdictionId\n'
        '  notificationPhoneTypeCode: $notificationPhoneTypeCode\n'
        '  notificationPhoneNumber: $notificationPhoneNumber\n'
        '  notificationSourceCode: $notificationSourceCode\n'
        '  notificationMethodCode: $notificationMethodCode\n'
        '  lossDateTimeZoneCode: $lossDateTimeZoneCode\n'
        '  notificationDateTimeZoneCode: $notificationDateTimeZoneCode\n'
        '  claimNumber: $claimNumber\n'
        '  callerName: $callerName\n'
        '  lossDescription: $lossDescription\n'
        '  dateOfLossDate: $dateOfLossDate\n'
        '  notificationDate: $notificationDate\n'
        '  lossDateTime: $lossDateTime\n'
        '  notificationTime: $notificationTime\n'
        '  catManualFlag: $catManualFlag\n'
        '  claimSourceCode: $claimSourceCode\n'
        '  companyLobId: $companyLobId\n'
        '  lobCode: $lobCode\n'
        '  unverifiedPolicy: $unverifiedPolicy\n'
        '  occurrenceDateVerifyIndicator: $occurrenceDateVerifyIndicator\n'
        '  claimPolicyNumber: $claimPolicyNumber\n'
        '  causeOfLossCode: $causeOfLossCode\n'
        '  coverages: $coverages\n'
        '  calClaimReportDate: $calClaimReportDate\n'
        '  claimAliasNumbers: $claimAliasNumbers\n'
        '  reinsuranceRetentionDetail: $reinsuranceRetentionDetail\n'
        '  claimJurisdictionProfiles: $claimJurisdictionProfiles\n'
        '  claimLossProfiles: $claimLossProfiles\n'
        '  claimLossIndicatorProfiles: $claimLossIndicatorProfiles\n'
        '  claimPolicyIndicatorProfiles: $claimPolicyIndicatorProfiles\n'
        '  clmAddress: $clmAddress\n'
        '  claimStatus: $claimStatus\n'
        '  claimIndicators: $claimIndicators\n'
        '}';
  }
}
