import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:txfb_insurance_flutter/data/data.dart';

import '../../mocks/mock_tfb_client.dart';
import '../../mocks/mock_tfb_network_service.dart';

class MockClientMethod extends Mock {
  Future<int> call();
}

void main() {
  // System Under Test
  late TfbNetworkService sut;

  setUp(() {
    sut = TfbNetworkService('', dio: Dio(), baseUrl: 'http://www.fake.com')
      ..addCurrentClient(MockTfbClient());
    WidgetsFlutterBinding.ensureInitialized();
  });

  test(
    'When network service class is initialize, then Dio member is not null',
    () {
      expect(sut.dio, isA<Dio>());
      expect(sut.dio, isNotNull);
    },
  );

  test(
    'When a Dio object is passed to provideDio, the class has a new Dio object',
    () {
      const fakeUrl = 'https://www.fakeUrl.com';
      final dio = Dio(BaseOptions(baseUrl: fakeUrl));
      sut.provideDio(dio);
      expect(sut.dio.options.baseUrl, equalsIgnoringCase(fakeUrl));
    },
  );

  test(
    'Given the AgentLookUpClient, when it is added to SUT, then the currentClient should be that specific type',
    () {
      sut.addCurrentClient(
        AgentLookUpClient(dio: Dio(BaseOptions()), baseUrl: ''),
      );
      expect(sut.client, isA<AgentLookUpClient>());
    },
  );

  /// Parent Class Testing
  test('Testing parent class addInterceptor', () {
    TfbNetworkInterceptor? result;
    final interceptor = TfbNetworkInterceptor(allowFaking: true);
    final service =
        TfbNetworkService('', dio: Dio(), baseUrl: 'http://www.fake.com')
          ..addCurrentClient(MockTfbClient())
          ..addInterceptor(interceptor);
    for (final interceptor in service.dio.interceptors) {
      if (interceptor is TfbNetworkInterceptor) {
        result = interceptor;
      }
    }
    expect(result, isA<Interceptor>());
  });

  test('Testing fakeNextRequest', () {
    TfbNetworkInterceptor interceptor =
        TfbNetworkInterceptor(allowFaking: true);
    sut.addInterceptor(interceptor);
    for (final tfbInterceptor in sut.dio.interceptors) {
      if (tfbInterceptor is TfbNetworkInterceptor) {
        interceptor = tfbInterceptor;
        sut.fakeNextRequest();
      }
    }
    expect(interceptor.fakeNextCount, equals(1));
  });

  test('Testing fetchTFBApiData to return fake future', () async {
    final mockService = MockTfbNetworkService();
    sut = mockService;
    final String result = await mockService
        .fetchTFBApiData<String>(mockService.fakeFunc)
        .then((value) => value);

    expect(result, 'fakeFuture');
  });

  test('fetchTFBApiData returns correct result', () async {
    final mockClientMethod = MockClientMethod();
    when(mockClientMethod.call).thenAnswer((_) async => 10);

    final result = await sut.fetchTFBApiData(mockClientMethod.call);

    expect(result, 10);
  });
}
