import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:txfb_insurance_flutter/app/cubits/app_update/app_update_cubit.dart';
import 'package:txfb_insurance_flutter/app/cubits/tfb_single_request_cubit/tfb_single_request_cubit.dart';
import 'package:txfb_insurance_flutter/domain/clients/tfb_member_access_client.dart';
import 'package:txfb_insurance_flutter/domain/models/app_update/app_update_response.dart';

class MockTfbMemberAccessClient extends Mock implements TfbMemberAccessClient {}

class MockAppUpdateResponse extends Mock implements AppUpdateResponse {}

void main() {
  group('AppUpdateCubit', () {
    late TfbMemberAccessClient client;
    late AppUpdateResponse response;

    setUp(() {
      client = MockTfbMemberAccessClient();
      response = MockAppUpdateResponse();
    });

    blocTest<AppUpdateCubit, TfbSingleRequestState>(
      'emits [] when nothing is added',
      build: AppUpdateCubit.new,
      expect: () => <AppUpdateResponse>[],
    );

    blocTest<AppUpdateCubit, TfbSingleRequestState>(
      'emits [loading, success] when AppUpdateResponse is successful',
      build: () {
        when(() => client.checkAppVersion()).thenAnswer((_) async => response);
        return AppUpdateCubit();
      },
      act: (cubit) => cubit.request(
        fallbackRequest: () => AppUpdateCubit.checkAppVersion(client),
      ),
      expect: () =>
          [isA<TfbSingleRequestProcessing>(), isA<TfbSingleRequestSuccess>()],
    );

    blocTest<AppUpdateCubit, TfbSingleRequestState>(
      'emits [loading, failure] when AppUpdateResponse fails',
      build: () {
        when(() => client.checkAppVersion()).thenThrow(Exception.new);
        return AppUpdateCubit();
      },
      act: (cubit) => cubit.request(
        fallbackRequest: () => AppUpdateCubit.checkAppVersion(client),
      ),
      expect: () =>
          [isA<TfbSingleRequestProcessing>(), isA<TfbSingleRequestFailed>()],
    );
  });
}
