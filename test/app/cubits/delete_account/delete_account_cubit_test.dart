import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:txfb_insurance_flutter/app/cubits/delete_account/delete_account_cubit.dart';
import 'package:txfb_insurance_flutter/domain/models/member_access/delete_account_request.dart';
import 'package:txfb_insurance_flutter/domain/models/tfb_generic_api_response.dart';

import '../../../mocks/mock_member_access_client.dart';

void main() {
  final mockMemberAccessClient = MockMemberAccessClient();

  testWidgets(
      'Delete account cubit should start in the DeleteAccountInitial state',
      (tester) async {
    final mockMemberAccessClient = MockMemberAccessClient();

    expect(
      DeleteAccountCubit(memberAccessClient: mockMemberAccessClient).state
          is DeleteAccountInitial,
      isTrue,
    );
  });

  blocTest<DeleteAccountCubit, DeleteAccountState>(
    'A successful delete account call should move to DeleteAccountSuccess state',
    setUp: () {
      registerFallbackValue(
        DeleteAccountRequest(
          memberId: 1234,
          memberInitials: 'memberInitials',
          memberNumber: 'memberNumber',
        ),
      );
      when(() => mockMemberAccessClient.deleteAccount(any())).thenAnswer(
        (invocation) => Future.value(
          TfbGenericApiResponse(errorMessage: '', returnMessage: ''),
        ),
      );
    },
    build: () => DeleteAccountCubit(memberAccessClient: mockMemberAccessClient),
    act: (bloc) => bloc.deleteAccount(
      DeleteAccountRequest(
        memberId: 1234,
        memberInitials: 'memberInitials',
        memberNumber: 'memberNumber',
      ),
    ),
    expect: () => [
      isA<DeleteAccountProcessing>(),
      isA<DeleteAccountSuccess>(),
    ],
  );

  blocTest<DeleteAccountCubit, DeleteAccountState>(
    'A successful delete account call with an error message property should move to DeleteAccountFailed state',
    setUp: () {
      registerFallbackValue(
        DeleteAccountRequest(
          memberId: 1234,
          memberInitials: 'memberInitials',
          memberNumber: 'memberNumber',
        ),
      );
      when(() => mockMemberAccessClient.deleteAccount(any())).thenAnswer(
        (invocation) => Future.value(
          TfbGenericApiResponse(
            errorMessage: 'ERROR_MESSAGE',
            returnMessage: '',
          ),
        ),
      );
    },
    build: () => DeleteAccountCubit(memberAccessClient: mockMemberAccessClient),
    act: (bloc) => bloc.deleteAccount(
      DeleteAccountRequest(
        memberId: 1234,
        memberInitials: 'memberInitials',
        memberNumber: 'memberNumber',
      ),
    ),
    expect: () => [
      isA<DeleteAccountProcessing>(),
      isA<DeleteAccountFailed>(),
    ],
  );

  blocTest<DeleteAccountCubit, DeleteAccountState>(
    'An unsuccessful delete account call should move to DeleteAccountFailed state',
    setUp: () {
      registerFallbackValue(
        DeleteAccountRequest(
          memberId: 1234,
          memberInitials: 'memberInitials',
          memberNumber: 'memberNumber',
        ),
      );
      when(() => mockMemberAccessClient.deleteAccount(any()))
          .thenThrow(Exception('ERROR!'));
    },
    build: () => DeleteAccountCubit(memberAccessClient: mockMemberAccessClient),
    act: (bloc) => bloc.deleteAccount(
      DeleteAccountRequest(
        memberId: 1234,
        memberInitials: 'memberInitials',
        memberNumber: 'memberNumber',
      ),
    ),
    expect: () => [
      isA<DeleteAccountProcessing>(),
      isA<DeleteAccountFailed>(),
    ],
  );
}
