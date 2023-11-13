import 'dart:convert';
import 'dart:io';

import 'package:crypto/crypto.dart';
import 'package:http/http.dart' as http;
import 'package:plugin_haven/plugin_haven.dart';
import 'package:plugin_haven_example/remote_config/azure/azure_app_configuration_key_value_request.dart';

class AzureAppConfigurationClient {
  final ObfuscatedKey credential;
  final ObfuscatedKey secret;
  final Uri baseUri;

  AzureAppConfigurationClient({
    required this.credential,
    required this.secret,
    required this.baseUri,
  });

  Future<AzureAppConfigurationKeyValueRequest> getAzureAppConfigurationValue(
    String key,
  ) async {
    var requestUri = Uri.parse("$baseUri/kv/$key");

    const signedHeaders = 'x-ms-date;host;x-ms-content-sha256';

    const method = 'GET';
    final utc = HttpDate.format(DateTime.now());
    final host = requestUri.host;
    final contentHash = hashBody('');
    final pathAndParams = requestUri.path;
    final message = '$method\n$pathAndParams\n$utc;$host;$contentHash';
    final signedMessage = signature(message, secret.value);

    var response = await http.get(
      requestUri,
      headers: {
        "x-ms-date": HttpDate.format(DateTime.now()),
        "x-ms-content-sha256": contentHash,
        "Authorization": generateAuthorizationHeader(
          signedHeaders,
          signedMessage,
          credential.value,
        )
      },
    );

    return AzureAppConfigurationKeyValueRequest.fromJson(
      json.decode(response.body),
    );
  }
}

String generateAuthorizationHeader(
  String signedHeaders,
  String signedMessage,
  String credential,
) =>
    'HMAC-SHA256 Credential=$credential&SignedHeaders=$signedHeaders&Signature=$signedMessage';

String hashBody(String body) =>
    base64.encode(sha256.convert(utf8.encode(body)).bytes);

String signature(String msg, String secret) {
  final hmac = Hmac(sha256, base64.decode(secret));
  final digest = hmac.convert(utf8.encode(msg));

  return base64.encode(digest.bytes);
}
