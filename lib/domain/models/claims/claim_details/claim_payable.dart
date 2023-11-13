// coverage:ignore-file
import 'package:txfb_insurance_flutter/domain/models/claims/claims.dart';

part 'claim_payable.g.dart';

@JsonSerializable()
class ClaimPayable {
  ClaimPayable({
    this.literalDescriptionMap,
    this.transactionAmount,
    this.clmCoverageCode,
  });

  factory ClaimPayable.fromJson(Map<String, dynamic> json) =>
      _$ClaimPayableFromJson(json);
  Map<String, dynamic> toJson() => _$ClaimPayableToJson(this);

  @JsonKey(name: 'literalDescriptionMap')
  final ClaimLiteralDescriptionMap? literalDescriptionMap;
  @JsonKey(name: 'transactionAmount')
  final String? transactionAmount;
  @JsonKey(name: 'clmCoverageCode')
  final String? clmCoverageCode;

  ClaimPayable copyWith({
    ClaimLiteralDescriptionMap? literalDescriptionMap,
    String? transactionAmount,
    String? clmCoverageCode,
  }) =>
      ClaimPayable(
        literalDescriptionMap:
            literalDescriptionMap ?? this.literalDescriptionMap,
        transactionAmount: transactionAmount ?? this.transactionAmount,
        clmCoverageCode: clmCoverageCode ?? this.clmCoverageCode,
      );
}
