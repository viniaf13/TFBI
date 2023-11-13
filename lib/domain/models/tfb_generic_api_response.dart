import 'package:json_annotation/json_annotation.dart';

part 'tfb_generic_api_response.g.dart';

@JsonSerializable()
class TfbGenericApiResponse {
  TfbGenericApiResponse({
    required this.errorMessage,
    required this.returnMessage,
  });

  factory TfbGenericApiResponse.fromJson(Map<String, dynamic> json) =>
      _$TfbGenericApiResponseFromJson(json);

  Map<String, dynamic> toJson() => _$TfbGenericApiResponseToJson(this);

  @JsonKey(name: 'ErrorMessage')
  final String? errorMessage;
  @JsonKey(name: 'ReturnMessage')
  final String? returnMessage;

  TfbGenericApiResponse copy() {
    return TfbGenericApiResponse(
      errorMessage: errorMessage,
      returnMessage: returnMessage,
    );
  }

  @override
  String toString() {
    String returnStr = '';
    returnStr += 'errorMessage: $errorMessage\n';
    returnStr += 'returnMessage: $returnMessage\n';
    return returnStr;
  }
}
