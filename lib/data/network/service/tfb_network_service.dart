import 'package:txfb_insurance_flutter/data/data.dart';
import 'package:txfb_insurance_flutter/data/network/clients/tfb_client.dart';

class TfbNetworkService<E extends TfbClient> extends HavenNetworkService {
  TfbNetworkService(String? proxy, {required Dio dio, required String baseUrl})
      : super(baseUrl, '') {
    init(proxy);
  }

  late E client;
  bool allowFaking = false;

  /// Gives the ability to change the current instance of dio by providing a new instance.
  void provideDio(Dio newDio) => dio = newDio;

  /// All clients should extend the universal abstract class TFBClient. This abstraction
  /// gives us the ability to separate and organize API Clients according to the end-points,
  /// but still use the same functions across all clients.
  void addCurrentClient(E tfbClient) => client = tfbClient;

  /// Use this method for all api calls. Provide the required client using the
  /// [addCurrentClient] method, then call the corresponding client method.
  /// example: networkService.client.method(successMethod);
  Future<T> fetchTFBApiData<T>(Future<T> Function() clientMethod) async =>
      clientMethod();
}
