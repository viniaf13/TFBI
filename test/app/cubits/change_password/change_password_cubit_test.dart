import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:txfb_insurance_flutter/app/cubits/change_password/change_password_cubit.dart';
import 'package:txfb_insurance_flutter/domain/clients/tfb_member_access_client.dart';
import 'package:txfb_insurance_flutter/domain/models/forgot_password/update_member_secure_password_request.dart';
import 'package:txfb_insurance_flutter/domain/models/tfb_generic_api_response.dart';

class MockTfbMemberAccessClient extends Mock implements TfbMemberAccessClient {}

void main() {
  late TfbMemberAccessClient mockMemberAccessClient;
  late ChangePasswordCubit cubit;

  setUp(() {
    mockMemberAccessClient = MockTfbMemberAccessClient();
    cubit = ChangePasswordCubit(memberAccessClient: mockMemberAccessClient);
    registerFallbackValue(
      UpdateMemberSecurePasswordRequest(
        memberId: 1111,
        membershipArray: [],
        newPassword: '',
        userName: '',
      ),
    );
  });

  tearDown(() {
    cubit.close();
  });

  blocTest<ChangePasswordCubit, ChangePasswordState>(
    'emits [ChangePasswordProcessing, ChangePasswordSuccess] when password change succeeds',
    build: () {
      when(() => mockMemberAccessClient.updateMemberSecurePassword(any()))
          .thenAnswer(
        (_) async => TfbGenericApiResponse(
          errorMessage: null,
          returnMessage: 'returnMessage',
        ),
      );
      return cubit;
    },
    act: (cubit) => cubit.submitChangedPassword(
      ChangePasswordSubmission(
        membershipArray: [],
        emailAddress: '',
        password: '',
      ),
    ),
    expect: () => [ChangePasswordProcessing(), ChangePasswordSuccess()],
  );

  blocTest<ChangePasswordCubit, ChangePasswordState>(
    'emits [ChangePasswordProcessing, ChangePasswordFailure] when password change fails',
    build: () {
      when(() => mockMemberAccessClient.updateMemberSecurePassword(any()))
          .thenThrow(Exception());
      return cubit;
    },
    act: (cubit) => cubit.submitChangedPassword(
      ChangePasswordSubmission(
        membershipArray: [],
        emailAddress: '',
        password: '',
      ),
    ),
    expect: () => [
      ChangePasswordProcessing(),
      isA<ChangePasswordFailure>(),
    ],
  );
}
