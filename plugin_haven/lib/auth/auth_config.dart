//  Copyright © 2022 Bottle Rocket Studios. All rights reserved.

/// Stores standard OAuth configuration values. Implementations will
/// typically have a derived version of this for each environment.
/// (e.g. AuthConfigStaging, AuthConfigProd)
///
/// Used to construct the authorization endpoint.
/// See [AuthUtils.authorizeEndpoint] for details on usage.
class AuthConfig {
  const AuthConfig({
    required this.host,
    required this.baseUrl,
    required this.clientId,
    required this.redirectUri,
    required this.scope,
    this.clientSecret,
  });

  /// Authorization host
  final String host;

  /// OAuth authorize base URL and path
  final String baseUrl;

  /// Client ID from auth provider
  final String clientId;

  /// Client secret from auth provider
  final String? clientSecret;

  /// Redirect URI configured with auth provider
  final String redirectUri;

  /// OpenID scope values, space delimited
  /// (e.g. 'offline_access email openid profile')
  final String scope;
}
