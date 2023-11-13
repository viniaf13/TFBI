import 'dart:async';

import 'package:mocktail/mocktail.dart';
import 'package:txfb_insurance_flutter/data/data.dart';
import 'package:txfb_insurance_flutter/domain/clients/tfb_member_access_client.dart';

class MockTfbNetworkService extends Mock
    implements TfbNetworkService<TfbMemberAccessClient> {
  Future<T> fakeFunc<T>() => Future.value('fakeFuture' as FutureOr<T>?);

  @override
  Future<T> fetchTFBApiData<T>(Future<T> Function() clientMethod) =>
      clientMethod();

  @override
  late TfbMemberAccessClient client;

  @override
  void addCurrentClient(TfbMemberAccessClient tfbClient) => client = tfbClient;
}
