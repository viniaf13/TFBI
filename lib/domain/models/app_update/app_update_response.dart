import 'package:json_annotation/json_annotation.dart';
part 'app_update_response.g.dart';

@JsonSerializable()
class AppUpdateResponse {
  AppUpdateResponse({
    required this.alertMessage,
    required this.androidStoreLink,
    required this.forceMessage,
    required this.iosStoreLink,
    required this.minSupportVersion,
    required this.recommendedVersion,
  });

  factory AppUpdateResponse.fromJson(Map<String, dynamic> json) =>
      _$AppUpdateResponseFromJson(json);
  Map<String, dynamic> toJson() => _$AppUpdateResponseToJson(this);

  @JsonKey(name: 'alertMessage')
  final String alertMessage;
  @JsonKey(name: 'androidStoreLink')
  final String androidStoreLink;
  @JsonKey(name: 'forceMessage')
  final String forceMessage;
  @JsonKey(name: 'iosStoreLink')
  final String iosStoreLink;
  @JsonKey(name: 'minimumSupportedVersion')
  final String minSupportVersion;
  @JsonKey(name: 'recommendedVersion')
  final String recommendedVersion;

  @override
  String toString() {
    String returnStr = '';
    returnStr += 'alertMessage: $alertMessage\n';
    returnStr += 'androidStoreLink: $androidStoreLink\n';
    returnStr += 'forceMessage: $forceMessage\n';
    returnStr += 'iosStoreLink: $iosStoreLink\n';
    returnStr += 'minimumSupportedVersion: $minSupportVersion\n';
    returnStr += 'recommendedVersion: $recommendedVersion\n';
    return returnStr;
  }
}
