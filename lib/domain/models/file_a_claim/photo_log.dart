import 'package:json_annotation/json_annotation.dart';

part 'photo_log.g.dart';

const String kResponseSuccessful = 'RESPONSE_SUCCESSFUL';
const String kExceededNumberOfRetries = 'EXCEEDED_NUMBER_OF_RETRIES';

@JsonSerializable()
class PhotoLog {
  PhotoLog({required this.logs});

  factory PhotoLog.fromJson(Map<String, dynamic> json) =>
      _$PhotoLogFromJson(json);

  @JsonKey(name: 'logs')
  List<PhotoRegister> logs;

  Map<String, dynamic> toJson() => _$PhotoLogToJson(this);
}

@JsonSerializable()
class PhotoRegister {
  PhotoRegister({
    required this.dateTime,
    required this.photoName,
    required this.response,
    required this.numberOfRetries,
  });

  factory PhotoRegister.fromJson(Map<String, dynamic> json) =>
      _$PhotoRegisterFromJson(json);

  Map<String, dynamic> toJson() => _$PhotoRegisterToJson(this);

  @JsonKey(name: 'dateTime')
  String dateTime;

  @JsonKey(name: 'photoName')
  String photoName;

  @JsonKey(name: 'response')
  String response;

  @JsonKey(name: 'numberOfRetries')
  int numberOfRetries;
}
