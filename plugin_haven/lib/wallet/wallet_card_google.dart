/// Class:GoogleWalletCard
/// Copyright © 2023 Bottle Rocket Studios. All rights reserved.

import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:path_provider/path_provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:uuid/uuid.dart';

import 'map_path_accessor.dart';
import 'wallet_card_platform_interface.dart';

// Concrete implementation of WalletCardPlatform for Google Wallet.
// The google wallet pass uses http requests to the google APIs and does not
// have native binding components (whereas ios has a native library interface).
//
class GoogleWalletCard extends WalletCardPlatform {
  final String googlePassUrl = 'https://pay.google.com/gp/v/save';
  final String assetName =
      'packages/plugin_haven/assets/wallet/enUS_add_to_google_wallet_wallet-button.svg';

  // Routine to access google APIs through our CA service in order to get
  // authorized access.
  //
  Future<Response?> _doRequest(Map<String, String> queryParameters) async {
    try {
      final String url = WalletCardPlatform.getServiceUrl();
      final Dio dio = Dio();
      return dio.get(url, queryParameters: queryParameters);
    } on Exception catch (ex) {
      debugPrint('Http request exception: ${ex.toString()}');
    }
    return null;
  }

  // Takes the updated google template json, signs the file using CA service,
  // and then launches the resulting url with token to invoke the google wallet
  // app.
  Future<String> _googleAddWalletPass(
    Directory tempDir,
    String sourcePath,
    Map<String, dynamic> passContent,
  ) async {
    final String tempPath = tempDir.path;
    final String unsignedPath = '$tempPath/${sourcePath.split("/").last}';
    final File outputFile = File(unsignedPath);
    String passId = '';

    if (passContent.containsKey('id')) {
      final List<String> segments = passContent['id'].split('.');
      passId = passContent['id'] = '${segments.first}.${const Uuid().v1()}';
      debugPrint('Creating google pass id: ${passContent["id"]}');
    }

    final String jsonContent = json.encode(passContent);

    outputFile.writeAsStringSync(jsonContent);

    final String signedTokenFile =
        await WalletCardPlatform.requestSignature(unsignedPath, 'token');
    if (signedTokenFile.isEmpty) {
      return '';
    }
    final File tokenFile = File(signedTokenFile);
    final String token = tokenFile.readAsStringSync();
    final String url = '$googlePassUrl/$token';

    debugPrint('Google Url: $url');

    return await launchUrl(Uri.parse(url)) ? passId : '';
  }

  // Implementation of WalletCardPlatform interfaces for Google Wallet
  //
  @override
  Future<String> createPassFromTemplate({
    required String jsonTemplatePath,
    required Map<String, dynamic> templateValues,
  }) async {
    Directory? tempDir;

    try {
      final String jsonString = await rootBundle.loadString(jsonTemplatePath);
      final Map<String, dynamic> jsonContent = json.decode(jsonString);

      templateValues.forEach((key, value) => jsonContent.putPath(key, value));

      tempDir = await getTemporaryDirectory();

      return await _googleAddWalletPass(tempDir, jsonTemplatePath, jsonContent);
    } catch (e) {
      debugPrint('Exception building Google signed pass: $e');
      return '';
    } finally {
      tempDir?.deleteSync(recursive: true);
    }
  }

  @override
  Future<bool?> deletePass({String? deleteItem}) async {
    if (deleteItem != null) {
      final response = await _doRequest({'id': deleteItem, 'expired': 'true'});

      if (response != null) {
        return (response.statusCode == 200 || response.statusCode == 204);
      }
    }
    return false;
  }

  @override
  Future<List<Map<String, dynamic>>> getWalletPasses({String? id}) async {
    if (id != null) {
      final response = await _doRequest({'id': id});

      if (response != null) {
        if (response.statusCode == 200 || response.statusCode == 204) {
          return [response as Map<String, dynamic>];
        }
      }
    }
    return [];
  }

  @override
  Widget getWalletIcon({ImageType? imageType, double? width, double? height}) {
    return SvgPicture.asset(assetName, semanticsLabel: 'Google Wallet Card');
  }
}
