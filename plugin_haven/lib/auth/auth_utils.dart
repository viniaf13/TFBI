//  Copyright © 2022 Bottle Rocket Studios. All rights reserved.

import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:crypto/crypto.dart';
import 'package:plugin_haven/auth/auth.dart';

/// Used in OAuth with PKCE verification challenges
class AuthPkceCode {
  const AuthPkceCode(this.verifier, this.challenge);

  /// PKCE verifier sent in subsequent auth token exchange
  final String verifier;

  /// PKCE challenge code sent in open auth URL query param
  final String challenge;
}

/// Mixin of auth utility methods required by most OAuth [AuthRepository]
/// implementations.
///
/// Typical usage is:
/// ```
/// class AppAuthRepository extends AuthRepository with AuthExtensions {}
/// ```
mixin AuthExtensions {
  /// Generates a valid PKCE code challenge and verifier
  AuthPkceCode createPkceCode() {
    final verifier = createHash();
    final challenge =
        base64UrlEncode(sha256.convert(ascii.encode(verifier)).bytes)
            .replaceAll('=', '')
            .replaceAll('+', '-')
            .replaceAll('/', '_');
    return AuthPkceCode(verifier, challenge);
  }

  /// Creates a random [count] alphanumeric hash.
  /// [count] defaults to 43 for PKCE hash. Value can be configure to use
  /// for state hashes.
  String createHash({int count = 43}) {
    final random = Random.secure();
    const chars =
        'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
    final hash =
        List.generate(count, (index) => chars[random.nextInt(chars.length)])
            .join();
    return hash;
  }

  /// Constructs an OAuth OpenID from provided parameters.
  ///
  /// If a [challengeMethod] is specified without a [challenge] value,
  /// a PKCE challenge will be generated. If PKCE token exchange is needed,
  /// caller should provide the [challenge] value so it has access to the
  /// required verifier.
  ///
  /// If no [state] is provided, a random hash will be generated.
  ///
  /// Additional configuration options supported by an auth provider can be
  /// provided via [extraQueries].
  Uri authorizeEndpoint({
    required AuthConfig config,
    String? challengeMethod,
    String? challenge,
    String? state,
    String? responseType = 'code',
    Map<String, String>? extraQueries,
  }) {
    final stateHash = createHash(count: 12);
    final params = {
      'client_id': config.clientId,
      'response_type': responseType,
      'redirect_uri': config.redirectUri,
      'state': state ?? stateHash,
      'scope': config.scope,
    };
    if (challengeMethod != null) {
      final code = createPkceCode();
      params.addAll({
        'code_challenge_method': challengeMethod,
        'code_challenge': challenge ?? code.challenge
      });
    }
    if (extraQueries != null) {
      params.addAll(extraQueries);
    }
    final url = Uri.https(config.host, '${config.baseUrl}/authorize', params);
    return url;
  }

  /// Decodes an OAuth token
  Map<String, dynamic> decodeIdToken(String token) {
    final parts = token.split(r'.');
    final Map<String, dynamic> values = jsonDecode(
      utf8.decode(base64Url.decode(base64Url.normalize(parts[1]))),
    );
    return values;
  }

  /// Decodes a SAML response
  String? decodeSamlAssertion(String response) {
    final map = Uri.splitQueryString(response);
    final saml = map['SAMLResponse'];
    if (saml != null) {
      final base64Saml = Uri.decodeFull(saml);
      final samlXml = base64Decode(base64Saml);
      final samlString = utf8.decode(samlXml);
      return samlString;
    }
    return null;
  }

  /// Runs a local callback server for SAML based authentication flows.
  /// Allows localhost to be provided as a SAML redirect if required.
  ///
  /// Listens on server for loopback redirect and returns decoded SAML
  /// response.
  ///
  /// Be sure to call server.close() in Auth cancel
  Future<String?> samlSignIn(HttpServer server) async {
    String? result;
    await for (HttpRequest request in server) {
      final response = await request.toList();
      result = utf8.decode(response.first);
      request.response
        ..write('OK')
        ..close();
      break;
    }
    server.close();
    if (result != null) {
      final saml = decodeSamlAssertion(result);
      return saml;
    }
    return null;
  }
}
