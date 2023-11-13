/// Class:IosWalletCard
/// Copyright © 2023 Bottle Rocket Studios. All rights reserved.
///
import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:archive/archive.dart';
import 'package:crypto/crypto.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:path_provider/path_provider.dart';
import 'package:uuid/uuid.dart';

import 'map_path_accessor.dart';
import 'wallet_card_platform_interface.dart';

// Concrete implementation of the WalletCardPlatform using the Apple pkpass
// library. For Apple wallet only.
//

class IosWalletCard extends WalletCardPlatform {
  final String iosJsonFile = 'pass.json';
  final String assetName =
      'packages/plugin_haven/assets/wallet/Apple_Wallet.svg';

  // Copy template pkpass directory from assets
  //
  Future<void> _copyAssetDirectory(
    String assetPath,
    String destinationPath,
    Map<String, dynamic> contentMap,
  ) async {
    final manifestJson = await rootBundle.loadString('AssetManifest.json');
    final Map<String, dynamic> manifestMap = json.decode(manifestJson);
    final filesToCopy =
        manifestMap.keys.where((file) => file.startsWith(assetPath)).toList();

    await Directory(destinationPath).create(recursive: true);

    for (final assetFile in filesToCopy) {
      List<int> bytes;
      final String assetFileName = assetFile.split('/').last;
      final String destinationFilePath = '$destinationPath/$assetFileName';

      if (assetFile.endsWith(iosJsonFile)) {
        final String jsonString = jsonEncode(contentMap);
        bytes = utf8.encode(jsonString);
      } else {
        final ByteData byteData = await rootBundle.load(assetFile);
        bytes = byteData.buffer.asUint8List();
      }
      File(destinationFilePath).writeAsBytesSync(bytes);
    }
  }

  // Create a manifest file of directory items with sha1 digest values.
  //
  Future<void> _createManifestFile(
    String directoryPath,
    String manifestFileName,
  ) async {
    final directory = Directory(directoryPath);

    if (!await directory.exists()) {
      debugPrint('Error: Directory not found at path: $directoryPath');
      return;
    }

    final List<FileSystemEntity> files =
        directory.listSync(recursive: false, followLinks: false);
    final manifestFilePath = '${directory.path}/$manifestFileName';
    final manifestFile = File(manifestFilePath);
    final Map<String, dynamic> manifestData = {};

    for (FileSystemEntity entity in files) {
      if (entity is File) {
        final fileContents = await entity.readAsBytes();
        final sha1Digest = sha1.convert(fileContents);
        final fileName = entity.path.split('/').last;

        manifestData[fileName] = sha1Digest.toString();
      }
    }
    final String manifestJsonString = jsonEncode(manifestData);
    manifestFile.writeAsStringSync(manifestJsonString);
    debugPrint('Manifest file: $manifestJsonString');
  }

  // Takes a directory and zips it up, with added manifest file.
  //
  Future<String> _createArchive(
    String destDir,
    String passDir,
    String pkpassFile,
  ) async {
    final directory = Directory(passDir);

    if (!await directory.exists()) {
      debugPrint('Error: Directory not found at path: $passDir');
      return '';
    }

    final encoder = ZipEncoder();
    final archive = Archive();

    await for (FileSystemEntity entity
        in directory.list(recursive: false, followLinks: false)) {
      if (entity is File) {
        final fileBytes = await entity.readAsBytes();
        final int size = fileBytes.length;
        final relativePath = entity.path.split('/').last;
        final archiveFile = ArchiveFile(relativePath, size, fileBytes);

        debugPrint("Archiving $relativePath, size: $size");

        archive.addFile(archiveFile);
      }
    }
    final String zipPath = '$destDir/$pkpassFile';
    final File zipFile = File(zipPath);
    final List<int>? fileData = encoder.encode(archive);

    if (fileData != null) {
      await zipFile.writeAsBytes(fileData);
      final int size = await zipFile.length();
      debugPrint('Zip file created at path: $zipFile, size: $size');
    } else {
      debugPrint('Unable to encode zip data');
      return '';
    }

    return zipPath;
  }

  // Create components for signing a wallet pass and then send it to CA service
  // for signature. Once signed, send signed .zip file to .pkpass library
  // which then handles submission of the generic pass to the wallet app.
  //
  Future<String> _iosAddWalletPass(
    Directory tempDir,
    String dirPath,
    Map<String, dynamic> passContent,
  ) async {
    final String tempPath = tempDir.path;
    final String passPath = '$tempPath/pass';
    final List<String> segments = dirPath.split('/');
    final String pkpassFile = '${segments.last}.pkpass';
    final String unsignedFile = '$pkpassFile.unsigned';
    String passId = '';

    if (passContent.containsKey('serialNumber')) {
      passId = passContent['serialNumber'] = const Uuid().v1();
      debugPrint(
        'Creating ios pass serialNumber: ${passContent['serialNumber']}',
      );
    }

    await _copyAssetDirectory(dirPath, passPath, passContent);
    await _createManifestFile(passPath, 'manifest.json');

    final String zipPath =
        await _createArchive(tempPath, passPath, unsignedFile);
    if (zipPath.isEmpty) {
      return '';
    }
    final String signedZipPath =
        await WalletCardPlatform.requestSignature(zipPath, pkpassFile);
    if (signedZipPath.isEmpty) {
      return '';
    }
    dynamic result = await WalletCardPlatform.channel
            .invokeMethod<bool>('addWalletPass', {'path': signedZipPath}) ??
        false;
    debugPrint('addWalletPass result: $result');

    return result ? passId : '';
  }

  // Implementation of WalletCardPlatform abstract functions for Apple Wallet.
  //
  @override
  Future<String> createPassFromTemplate({
    required String jsonTemplatePath,
    required Map<String, dynamic> templateValues,
  }) async {
    Directory? tempDir;
    try {
      final String jsonFileName = '$jsonTemplatePath/$iosJsonFile';
      final String jsonString = await rootBundle.loadString(jsonFileName);
      final Map<String, dynamic> jsonContent = json.decode(jsonString);

      templateValues.forEach((key, value) => jsonContent.putPath(key, value));

      tempDir = await getTemporaryDirectory();

      return await _iosAddWalletPass(tempDir, jsonTemplatePath, jsonContent);
    } catch (e) {
      debugPrint('Exception building signed Apple pass: $e');
      return '';
    } finally {
      tempDir?.deleteSync(recursive: true);
    }
  }

  @override
  Future<bool?> deletePass({String? deleteItem}) async {
    try {
      var result = await WalletCardPlatform.channel.invokeMethod<bool>(
            'deleteWalletPass',
            deleteItem == null ? {} : {'expiredOrBySerial': deleteItem},
          ) ??
          false;
      debugPrint('delete pass result: $result');
      return result;
    } catch (e) {
      debugPrint('Exception while deleting pass, ${deleteItem ?? "<ALL>"}: $e');
    }
    return false;
  }

  @override
  Future<List<Map<String, dynamic>>> getWalletPasses({String? id}) async {
    final dynamic passes = await WalletCardPlatform.channel
            .invokeMethod<dynamic>('getWalletPasses') ??
        {};
    final List<Map<String, dynamic>> listMap = passes
        .map<Map<String, dynamic>>(
          (map) => (map as Map<Object?, Object?>).map<String, dynamic>(
            (key, value) => MapEntry(key as String, value),
          ),
        )
        .toList();
    return Future.value(listMap);
  }

  @override
  Widget getWalletIcon({
    ImageType? imageType = ImageType.nativeButton,
    double? width = 140.0,
    double? height = 30.0,
  }) {
    if (imageType! == ImageType.svgImage) {
      return SvgPicture.asset(assetName, semanticsLabel: 'Apple Wallet Card');
    }
    return IosWalletNativeButton(width: width!, height: height!);
  }
}

class IosWalletNativeButton extends StatelessWidget {
  const IosWalletNativeButton({
    Key? key,
    required this.width,
    required this.height,
  }) : super(key: key);

  final double width;
  final double height;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        return SizedBox(
          width: width,
          height: height,
          child: const UiKitView(
            viewType: 'native_button',
            hitTestBehavior: PlatformViewHitTestBehavior.transparent,
          ),
        );
      },
    );
  }
}
