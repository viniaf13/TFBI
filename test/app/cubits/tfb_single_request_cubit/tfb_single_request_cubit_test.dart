import 'dart:math';

import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:txfb_insurance_flutter/app/cubits/tfb_single_request_cubit/tfb_single_request_cubit.dart';

void main() {
  test('TfbSingleRequestCubit should start in the initial state', () {
    expect(
      TfbSingleRequestCubit<String>(requestFunction: () => Future.value(''))
          .state is TfbSingleRequestInitial,
      isTrue,
    );
  });

  blocTest<TfbSingleRequestCubit, TfbSingleRequestState>(
    'While the request is processing, TfbSingleRequestCubit should emit the TfbSingleRequestProcessing state',
    build: () => TfbSingleRequestCubit(
      requestFunction: () async {
        await Future<void>.delayed(const Duration(milliseconds: 10));

        return '';
      },
    ),
    act: (bloc) => bloc.request(),
    expect: () =>
        [isA<TfbSingleRequestProcessing>(), isA<TfbSingleRequestSuccess>()],
  );

  blocTest<TfbSingleRequestCubit, TfbSingleRequestState>(
    'Should emit the TfbSingleRequestProcessing state & isPullToRefresh is False',
    build: () => TfbSingleRequestCubit(
      requestFunction: () async {
        await Future<void>.delayed(const Duration(milliseconds: 10));

        return '';
      },
    ),
    act: (bloc) => bloc.request(),
    expect: () => [
      isA<TfbSingleRequestProcessing>()
          .having((state) => state.isPullToRefresh, 'isPullToRefresh', false),
      isA<TfbSingleRequestSuccess>(),
    ],
  );

  blocTest<TfbSingleRequestCubit, TfbSingleRequestState>(
    'Should emit the TfbSingleRequestProcessing state & isPullToRefresh is True',
    build: () => TfbSingleRequestCubit(
      requestFunction: () async {
        await Future<void>.delayed(const Duration(milliseconds: 10));

        return '';
      },
    ),
    act: (bloc) => bloc.request(pullToRefresh: true),
    expect: () => [
      isA<TfbSingleRequestProcessing>()
          .having((state) => state.isPullToRefresh, 'isPullToRefresh', true),
      isA<TfbSingleRequestSuccess>(),
    ],
  );

  blocTest<TfbSingleRequestCubit, TfbSingleRequestState>(
    'If the request fails, TfbSingleRequestCubit should emit the TfbSingleRequestFailed state',
    build: () => TfbSingleRequestCubit(
      requestFunction: () async {
        throw Exception('EXCEPTION');
      },
    ),
    act: (bloc) => bloc.request(),
    expect: () =>
        [isA<TfbSingleRequestProcessing>(), isA<TfbSingleRequestFailed>()],
  );

  int counter = 0;

  blocTest<TfbSingleRequestCubit, TfbSingleRequestState>(
    'If the request method is called multiple times, it should only process when the previous request has finished',
    build: () => TfbSingleRequestCubit(
      requestFunction: () async {
        await Future<void>.delayed(const Duration(milliseconds: 100));

        counter++;

        return Random().nextDouble();
      },
    ),
    act: (bloc) => bloc
      ..request()
      ..request()
      ..request(),
    expect: () =>
        [isA<TfbSingleRequestProcessing>(), isA<TfbSingleRequestSuccess>()],
    verify: (bloc) {
      expect(counter, 1);
    },
    wait: const Duration(milliseconds: 100),
  );
}
