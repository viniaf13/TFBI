// coverage:ignore-file
import 'package:txfb_insurance_flutter/data/data.dart';
import 'package:txfb_insurance_flutter/resources/theme/theme.dart';
import 'package:txfb_insurance_flutter/shared/extensions/context_extension.dart';

part 'update_email_request.g.dart';

@JsonSerializable()
class UpdateEmailRequest {
  UpdateEmailRequest({
    required this.memberNumber,
    required this.newUserName,
    required this.oldUserName,
  });

  factory UpdateEmailRequest.fromContext(
    BuildContext context,
    String newEmail,
  ) =>
      UpdateEmailRequest(
        memberNumber: context.getUserMemberNumber!,
        newUserName: newEmail,
        oldUserName: context.user!.memberEmailAddress!,
      );

  factory UpdateEmailRequest.fromJson(Map<String, dynamic> json) =>
      _$UpdateEmailRequestFromJson(json);

  Map<String, dynamic> toJson() => _$UpdateEmailRequestToJson(this);

  @JsonKey(name: 'MemberNumber')
  String memberNumber;
  @JsonKey(name: 'NewUserName')
  String newUserName;
  @JsonKey(name: 'OldUserName')
  String oldUserName;
}
