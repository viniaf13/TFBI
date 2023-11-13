import 'package:dio/dio.dart';
import 'package:plugin_haven/network/network_service/haven_network_service.dart';

// Repository base class your app is required to override.  This base class
// provides an initialized dio instance and the ability to configure it
// with a method override (configureDio)
abstract class HavenRepository {
  HavenRepository();

  late HavenNetworkService networkService;
  late String baseUrl;

  void initialize(String baseUrl, {String? proxy, bool allowFaking = true}) {
    this.baseUrl = baseUrl;
    networkService = HavenNetworkService(baseUrl, proxy);
    configureDio(networkService.dio);
  }

  // Faking the very next request recieved by the interceptor.  You usually place
  // This line just prior to the actual API call.
  void fakeNextRequest() => networkService.fakeNextRequest();

  // Tells the Repository to fake ALL the request that come through.  Primarly
  // used for unit testing; but also handy in the case of major network problems or "the whole api is down"
  void fakeAll(bool flag) => networkService.setFakeAll(flag);

  // By default the system uses the data specified in the 'fake' field on the 'extras' parameter
  // as the json file name to load for the fake.   However you can override which json file it loads
  // for the next faked action.  Just specify the name (no .json at the end).
  void fakeNextRequestWith({required String jsonFile}) =>
      networkService.fakeNextRequestWith(jsonFile: jsonFile);

  // Override this to add custom dio config for your app
  void configureDio(Dio dio) {
    // **** HEADER MODIFICATION EXAMPLES ****
    // dio.options.headers['X-API-Key'] = 'af8c0b9a-03a2-4d4f-8865-de02cfd8b043';
    // dio.options.headers['Authorization'] = 'Basic QmFzaWNMUFNUZXN0OkxQU1RFc3QxMjMh';
    // dio.options.headers['Accept'] = '*/*';
    // dio.options.headers['Host'] = environment.host;
  }
}

// *************** EXAMPLE USAGE *******************
//
// Here's an example of an API call that's wrapped by our derived repository.
// You can also special-case handle other codes response codes
// at this point, like 422s, 404s, 204s, etc. if desired.

// Future<ProductDetails> fetchProductDetails(String productId) async {
//   _configApiCall();
//   return await api.getProductDetails(productId).then((value) {
//     return value;
//   }).catchError((Object obj) {
//     throw ApiException(_apiFailureError(obj));
//   });

// And the error handler that would occur in case the call fails:

// String _apiFailureError(Object obj) {
//   String errorStr = 'Unknown Network Error';
//   if (obj is DioError) {
//     final res = obj.response;
//     errorStr = res == null ? obj.message : 'Got error : ${res.statusCode} -> ${res.statusMessage}';
//   } else if (obj is Error) {
//     obj.toString();
//   } else if (obj is ApiException) {
//     obj.toString();
//   }
//   return errorStr;
// }

// Any errors would propagate up to the front end caller (usually a bloc) and handled however it wants:

// try {
//   productDetails = await OurRepository().fetchProductDetails(event.productId);
// } catch (e) {
//   String msg = (e as ApiException).message;
//   emit(ApiErrorState(errorMessage: msg));
//   return;
// }

// In the example above the api.getProductDetails call comes from a Retrofit defined class,
// Note the @Extra part, the value there is the actual name of the json file that will be used
// in case this call is requested to be faked. In this case, product_details.json
// The path is currently hardcoded and assumed to be assets/fake_api/product_details.json

// @GET('/products/{productId}')
// @Extra({'fake': 'product_details'})
// Future<ProductDetails> getProductDetails(
//   @Path('productId') String productId,
// );

// Side Note:  If a call is deisgned to have no reponse (a 204)  you can leave
// the @Extra line out and the fake system will just "assume it was a succesful call"
