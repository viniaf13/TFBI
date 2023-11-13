import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// Network interceptor base class
abstract class HavenNetworkServiceInterceptor extends Interceptor {
  HavenNetworkServiceInterceptor({required this.allowFaking});

  bool allowFaking = true;
  int fakeNextCount = 0;
  bool fakeAll = false;
  String? fakeWithJson;

  // A url sanitization utility function. This one composites
  // the sanitized query parameters onto the base url.
  String getNormalizedUrl(String baseUrl, String queryParams) {
    if (baseUrl.contains('?')) {
      return '$baseUrl&$queryParams';
    } else if (queryParams.isNotEmpty) {
      return '$baseUrl?$queryParams';
    } else {
      return baseUrl;
    }
  }

  // A url sanitization utility function.  This one builds the
  // query parameters string properly.
  String getQueryParams(Map<String, dynamic> map) {
    var result = '';
    map.forEach((key, value) {
      if (value is String) {
        result += '$key=${Uri.encodeComponent(value)}&';
      } else {
        result += '$key=$value&';
      }
    });
    if (result.isNotEmpty && result[result.length - 1] == '&') {
      return result.substring(0, result.length - 1);
    }
    return result;
  }

  // This is the main onRequest function where all the faking happens.
  // It is basically responsible for the decision to either fake the response or
  // go out to the network to do the real request. If we fake the response we do not
  // hit the real network, which allows us to do unit testing on methods that would otherwise
  // hit the network.
  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    final queryParams = getQueryParams(options.queryParameters);
    final sanitizedOptions = options.copyWith(
      path: getNormalizedUrl(options.path, queryParams),
      queryParameters: Map.from({}),
    );

    // If not faking is allowed, just early out.
    // Also we don't try fake call types other than GET
    if (!allowFaking) {
      handler.next(sanitizedOptions);
      return;
    }

    // Do the real call if we aren't set to fake anything
    if (fakeNextCount == 0 && !fakeAll && options.path.isNotEmpty) {
      handler.next(sanitizedOptions);
      return;
    }

    // Decrement the fake next flag
    fakeNextCount--;

    // If we get here we, we are dealing with a fake api call, we load the json
    // and craft a Response object out of it, and use that.
    try {
      // If we are faking with an overriden json file we clear the flag immediately
      // after we obtain the name from it.
      final jsonName = fakeWithJson ?? options.extra['fake'];
      fakeWithJson = null;

      Response responseObj;
      String? resourcePath;
      resourcePath = jsonName != null ? 'assets/fake_api/$jsonName.json' : null;
      responseObj = await getFakeJsonResponse(options, resourcePath);
      debugPrint(
        'NetworkLog::Faking call with ${resourcePath ?? 'Empty Json'}',
      );
      handler.resolve(responseObj);
    } catch (e) {
      // We failed to get the fake API data, just reject this
      // api request with an error.
      debugPrint(
        'NetworkLog::Fake API request for ${options.path} was not found! (Missing JSON file?)',
      );
      handler.reject(DioException(requestOptions: options));
    }
  }

  // Utililty method to load a fake json reponse from a file
  // Provide json full file path, 'assets/fake_api/data_object.json'
  Future<Response> getFakeJsonResponse(
    RequestOptions options,
    String? jsonFilePath,
  ) async {
    // It is possible to have a no fake json file, this would represent an api
    // call that has no parameters or return value (probably a POST) that would return
    // a 204 upon success.  We just need to catch the failure of parsing an empty
    // or unspecified json file here, and consider that a 204 response.
    // For faking, we will just assume this condition means it was a successful call.
    if (jsonFilePath == null) {
      return Response(
        requestOptions: options,
        data: null,
        statusCode: 204,
      );
    }

    // Load and decode the json file
    final resourcePath = jsonFilePath;
    final data = await rootBundle.load(resourcePath);
    dynamic jsonResult;
    try {
      jsonResult = json.decode(
        utf8.decode(
          data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes),
        ),
      );
    } catch (e) {
      jsonResult = null;
    }

    // Craft the Response object using the json and return it
    // as our faked response
    final responseObj = Response(
      requestOptions: options,
      data: jsonResult,
      statusCode: jsonResult != null ? 200 : 204,
    );

    return responseObj;
  }
}

@override
void onResponse(Response response, ResponseInterceptorHandler handler) {
  handler.next(response);
}

@override
void onError(DioException err, ErrorInterceptorHandler handler) {
  handler.next(err);
}
