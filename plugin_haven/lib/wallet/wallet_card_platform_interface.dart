/// Module: Wallet Card Platform Interface
/// Copyright © 2023 Bottle Rocket Studios. All rights reserved.
///
// Summary: This module defines an abstract interface, `WalletCardPlatform`,
// for interacting with wallet card functionalities across different platforms
// (Android, iOS, etc.). It provides a common set of methods and properties for
// creating, managing, and accessing wallet passes. Note that example usage
// of this API is provided in the Haven example app.
//
// The primary functions are:
//
// 1) Create a new wallet card from a json template updated with specific
//    information for that card (generic pass), get the card 'certified'
//    using an external CA authority (for security reasons) and finally
//    linking to the wallet app to view/mamange the newly created card.
// 2) Get a list of cards in wallet created by the mobile app.
// 3) Delete a specific card we created by using the creation ID.
// 4) Retrieve the platform specific image provided by Apple/Google to display
//    in UI (a button) that the user selects to 'add' the card to the wallet.
//
// Usage example:
// Before making a wallet card, use the static method to set the service
// environment. This should be set for the specific platform as determined by
// Platform class, otherwise localhost is assumed which is only to be used for
// testing.
//
// WalletCardPlatform.setService(url); // URL of CA service which is typically
//                                     // the same, but when using localhost,
//                                     // must be specific to platform.
// To create a pass and pass it onto the platform wallet application, both a
// platform specific json file asset path and a Map of json paths to set is
// required. To set a json terminal object in the json template, the path in
// the template values looks like 'generic/secondaryFields/0/value': '2023'
// The template config is a simple Map<String, String> with the keys being the
// json path and the values are new data for the object at that path.
//
// WalletCardPlatform.instance.createPassFromTemplate(
//     path: Platform.isIOS ? iosPathToJsonTemplate : androidPathToJsonTemplate,
//     templateValues: Platform.isIOS ? iosConfig : androidConfig);
//
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:plugin_haven/wallet/wallet_card_google.dart';
import 'package:plugin_haven/wallet/wallet_card_ios.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

// This class represents the default implementation of the WalletCardPlatform
// interface when neither android/ios specific platforms are detected.

class NoWalletCard extends WalletCardPlatform {}

enum ImageType { svgImage, nativeButton }

// This class represents the abstract interface for WalletCardPlatform.

abstract class WalletCardPlatform extends PlatformInterface {
  /// Constructs a WalletCardPlatform.
  WalletCardPlatform() : super(token: _token);

  static final Object _token = Object();

  // MethodChannel for communicating with the native platform.
  static const MethodChannel channel = MethodChannel('plugin_haven');

  static WalletCardPlatform _instance = Platform.isIOS
      ? IosWalletCard()
      : Platform.isAndroid
          ? GoogleWalletCard()
          : NoWalletCard();

  /// The platform derived instance of [WalletCardPlatform] to use.
  ///
  static WalletCardPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [WalletCardPlatform] when
  /// they register themselves.
  static set instance(WalletCardPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  // The base URL for the service. Default is for testing ONLY.
  static String caUrl = 'http://localhost:8000';

  static String serviceUrl({String? newUrl}) {
    if (newUrl != null) {
      caUrl = newUrl;
    }
    return caUrl;
  }

  // Method for constructing the service URL with the platform information.
  static String getServiceUrl() =>
      '$caUrl?platform=${Platform.isAndroid ? 'android' : 'ios'}';

  // Helper method for requesting signature for a CA. SourcePath is data
  // used to create signed response. The result is placed in output file in
  // same location as sourcePath with the name of destFileName. This is used
  // by the concrete implementations.
  static Future<String> requestSignature(
    String sourcePath,
    String destFileName,
  ) async {
    final Dio dio = Dio();
    final int lastIndex = sourcePath.lastIndexOf('/');
    final String signedPath =
        '${sourcePath.substring(0, lastIndex + 1)}$destFileName';
    final File inputFile = File(sourcePath);
    final File outputFile = File(signedPath);
    final formData = FormData.fromMap({
      'file': await MultipartFile.fromFile(
        inputFile.path,
        filename: inputFile.path.split('/').last,
      ),
    });
    final String url = getServiceUrl();

    try {
      final response = await dio.post(
        url,
        data: formData,
        options: Options(
          headers: {
            'Content-Type': 'multipart/form-data',
          },
          responseType: ResponseType.bytes,
        ),
      );

      if (response.statusCode == 200) {
        final List<int> byteData = response.data;
        await outputFile.writeAsBytes(byteData);
        final size = await outputFile.length();
        debugPrint(
          'Signed output file with signature saved to $outputFile, size: $size',
        );
        return signedPath;
      } else {
        debugPrint(
          'Failed to process signed file. Status code: ${response.statusCode}',
        );
      }
    } on Exception catch (ex) {
      // TODO: Using Exception to be safe for now as other than DioError occurs?
      debugPrint('Http Exception: ${ex.toString()}');
    }
    return '';
  }

  Future<String?> get platformVersion async {
    final String? version = await WalletCardPlatform.channel
        .invokeMethod<String?>('getPlatformVersion');
    return version;
  }

  // Abstract method for creating a pass from na asset template json file with
  // specific wallet card values specified by the json paths in templateValues.
  Future<String> createPassFromTemplate({
    required String jsonTemplatePath,
    required Map<String, dynamic> templateValues,
  }) {
    throw UnimplementedError(
      'createPassFromTemplate() has not been implemented.',
    );
  }

  // Abstract method for deleting (ios) or expiring a pass (android)
  Future<bool?> deletePass({String? deleteItem}) {
    throw UnimplementedError(
      'deletePass() has not been implemented.',
    );
  }

  // Abstract method for getting wallet passes.
  Future<List<Map<String, dynamic>>> getWalletPasses({String? id}) {
    throw UnimplementedError(
      'walletPasses() has not been implemented.',
    );
  }

  // Abstract method for getting the platform specific :0
  // wallet icon.
  Widget getWalletIcon({
    ImageType? imageType,
    double? width,
    double? height,
  }) {
    throw UnimplementedError('getWalletIcon() has not been implemented.');
  }
}
