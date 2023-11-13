import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'dart:io' as io;

/// Responsible for setting all necessary cookie values to complete a request
/// to the /payments endpoint that eventually redirects to Fiserv for payment
class TfbAuthenticatedPaymentsCookieManager {
  TfbAuthenticatedPaymentsCookieManager({
    required this.setCookieString,
    required this.accessTokenValue,
    required this.uri,
    required this.cookieManager,
    required this.accessTokenKey,
  });

  /// The root uri where the auth cookies are saved
  final Uri uri;

  /// The set-cookie response from the server on login
  ///
  /// Should contain both the forms auth cookie and the session ID cookie
  final String setCookieString;

  /// The cookie manager that will be written to
  final CookieManager cookieManager;

  /// The key/name to use to set the user's access token cookie
  final String accessTokenKey;

  /// The currently signed in user's access token
  final String accessTokenValue;

  final String _cookieSeparator = ',';

  Future<void> clearAllCookies() => cookieManager.deleteAllCookies();

  Future<void> setAllAuthPaymentCookies() => Future.wait([
        _setAccessTokenCookie(),
        _setFormsAuthCookie(),
        _setSessionIdCookie(),
      ]);

  Future<void> _setAccessTokenCookie() {
    final stageTokenCookie = io.Cookie(
      accessTokenKey,
      accessTokenValue,
    )
      ..secure = true
      ..httpOnly = false;

    return _setCookie(cookieManager, stageTokenCookie, uri);
  }

  Future<void> _setFormsAuthCookie() {
    const formsAuthCookieName = 'TXFBFORMSAUTH';
    final formsAuthSetCookieString = setCookieString
        .split(_cookieSeparator)
        .firstWhere((e) => e.contains(formsAuthCookieName));

    final formsAuthCookie =
        io.Cookie.fromSetCookieValue(formsAuthSetCookieString)
          ..httpOnly = false;

    return _setCookie(cookieManager, formsAuthCookie, uri);
  }

  Future<void> _setSessionIdCookie() {
    const sessionIdCookieName = 'ASP.NET_SessionId';
    final sessionIdSetCookieString = setCookieString
        .split(_cookieSeparator)
        .firstWhere((e) => e.contains(sessionIdCookieName));

    final sessionIdCookie =
        io.Cookie.fromSetCookieValue(sessionIdSetCookieString)
          ..httpOnly = false;

    return _setCookie(cookieManager, sessionIdCookie, uri);
  }

  Future<void> _setCookie(
    CookieManager cookieManager,
    io.Cookie cookie,
    Uri uri,
  ) {
    return cookieManager.setCookie(
      url: uri,
      domain: cookie.domain,
      maxAge: cookie.maxAge,
      name: cookie.name,
      value: cookie.value,
      isHttpOnly: cookie.httpOnly,
      isSecure: cookie.secure,
      path: cookie.path ?? '/',
      sameSite: switch (cookie.sameSite) {
        io.SameSite.lax => HTTPCookieSameSitePolicy.LAX,
        io.SameSite.none => HTTPCookieSameSitePolicy.NONE,
        io.SameSite.strict => HTTPCookieSameSitePolicy.STRICT,
        _ => HTTPCookieSameSitePolicy.NONE
      },
    );
  }
}
