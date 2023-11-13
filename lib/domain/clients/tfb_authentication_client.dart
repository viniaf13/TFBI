// coverage:ignore-file
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:txfb_insurance_flutter/data/network/clients/tfb_client.dart';
import 'package:txfb_insurance_flutter/data/network/constants/authentication_endpoints.dart';
import 'package:txfb_insurance_flutter/data/network/constants/tfb_network_constants.dart';
import 'package:txfb_insurance_flutter/domain/models/login/login_request.dart';
import 'package:txfb_insurance_flutter/domain/models/login/login_response.dart';

part 'tfb_authentication_client.g.dart';

@RestApi(baseUrl: kStageApiBaseUrl)
abstract class TfbAuthenticationClient extends TfbClient {
  factory TfbAuthenticationClient({
    required String baseUrl,
    required Dio dio,
  }) {
    return _TfbAuthenticationClient(
      dio,
      baseUrl: baseUrl,
    );
  }

  @POST(kLoginEndpoint)
  Future<HttpResponse<LoginResponse>> login(@Body() LoginRequest loginRequest);

  @POST(kLogoutEndpoint)
  Future<bool> logout();
}
