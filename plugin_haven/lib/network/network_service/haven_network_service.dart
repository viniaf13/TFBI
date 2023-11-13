import 'package:dio/dio.dart';
import 'package:plugin_haven/network/network_service/haven_network_interceptor.dart';
import 'package:plugin_haven/network/network_service/haven_proxy_service.dart';

// Network service base class, for the most part you will not need
// to override this class.
class HavenNetworkService {
  HavenNetworkService(this.baseUrl, String? proxy) {
    init(proxy);
  }

  late Dio dio;
  String baseUrl;
  bool fakeAll = false;

  // Called at construction, creates dio
  void init(String? proxy) {
    _createDio();

    // Set up the proxy if any
    HavenProxyService.setProxy(proxy ?? '');
    HavenProxyService.addProxyIfSet(dio);
  }

  // Create the dio instance
  void _createDio() {
    dio = Dio(
      BaseOptions(
        connectTimeout: const Duration(seconds: 5),
        receiveTimeout: const Duration(seconds: 5),
        baseUrl: baseUrl,
      ),
    );
  }

  // Adds a network interceptor to dio
  void addInterceptor(HavenNetworkServiceInterceptor interceptor) {
    dio.interceptors.add(interceptor);
  }

  // Instructs in the interceptors to use a fake for their next request
  void fakeNextRequest() {
    _setInterceptorFlags(true);
  }

  // Instructs in the interceptors to fake and use a json file that overrides the default fake
  void fakeNextRequestWith({required String jsonFile}) {
    _setInterceptorFlags(
      true,
      overrideJson: jsonFile,
    );
  }

  // Sets whether or not we should fake all calls
  void setFakeAll(bool flag) {
    fakeAll = flag;
    _setInterceptorFlags(false);
  }

  // Private utility method to set flags and json override on all interceptors
  void _setInterceptorFlags(bool fakeNext, {String? overrideJson}) {
    for (var element in dio.interceptors) {
      if (element is HavenNetworkServiceInterceptor) {
        element.fakeNextCount += fakeNext || fakeAll ? 1 : 0;
        element.fakeAll = fakeAll;
        element.fakeWithJson = overrideJson; // usually null.
      }
    }
  }
}
