import 'package:mocktail/mocktail.dart';
import 'package:txfb_insurance_flutter/domain/models/login/login_member.dart';
import 'package:txfb_insurance_flutter/domain/models/login/tfb_user.dart';

class MockTfbUser extends Mock implements TfbUser {
  @override
  final String accessToken = 'testAccessToken';
  @override
  final String username = 'testUserName';
  @override
  String get getFirstName => 'testUserName';
  @override
  final String agentNumber = 'agentNumber';
  @override
  final String communicationPreferred = 'communicationPreferred';
  @override
  final bool emailVerified = true;
  @override
  final String errorMessage = 'errorMessage';
  @override
  final String memberName = 'memberName';
  @override
  final String memberSecondaryName = 'memberSecondaryName';
  @override
  final bool passwordResetFlag = false;
  @override
  final String sessionCookie = 'sessionCookie';
  @override
  final String memberEmailAddress = 'memberEmailAddress';

  @override
  final List<LoginMember> members = [
    LoginMember(
      lastLoginTimestamp: 'lastLoginTimestamp',
      memberIDNumber: 1234,
      memberNumber: '1234',
    ),
  ];

  //   agentNumber: 'agentNumber',
  // communicationPreferred: 'communicationPreferred',
  // emailVerified: true,
  // errorMessage: 'errorMessage',
  // memberName: 'memberName',
  // memberSecondaryName: 'memberSecondaryName',
  // passwordResetFlag: false,
  // sessionCookie: 'sessionCookie',
  // memberEmailAddress: 'memberEmailAddress',
  // members: [
  //   LoginMember(
  //     lastLoginTimestamp: 'lastLoginTimestamp',
  //     memberIDNumber: 1234,
  //     memberNumber: '1234',
  //   )
  // ],
}

class MockTfbUserWithoutName extends Mock implements TfbUser {
  @override
  final String accessToken = 'testAccessToken';
  @override
  String get getFirstName => '';
}
