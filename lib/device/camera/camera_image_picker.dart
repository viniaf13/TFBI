import 'dart:io';

import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

class CameraImagePicker {
  static final ImagePicker picker = ImagePicker();

  static Future<PermissionStatus> checkGalleryPermissions() async {
    final PermissionStatus status = await Permission.photos.status;
    return status;
  }

  static Future<PermissionStatus> checkCameraPermissions() async {
    final PermissionStatus status = await Permission.camera.status;
    return status;
  }

  static Future<PermissionStatus> checkMicrophonePermissions() async {
    final PermissionStatus status = await Permission.microphone.status;
    return status;
  }

  static Future<bool> askForCameraPermissions() async {
    final cameraRequest = await Permission.camera.request();
    final microphoneRequest = await Permission.microphone.request();
    if (Platform.isAndroid &&
        (cameraRequest.isPermanentlyDenied ||
            microphoneRequest.isPermanentlyDenied)) {
      return false;
    }
    return cameraRequest == PermissionStatus.granted &&
        microphoneRequest == PermissionStatus.granted;
  }

  static Future<bool> askForGalleryPermission() async {
    final galleryRequest = await Permission.photos.request();
    return galleryRequest == PermissionStatus.granted;
  }

  /// opens native selector for photos on the users phone photo library
  /// saves the selected images into phone memory
  /// and returns a list of XFiles
  static Future<List<XFile?>> selectPhotos() async {
    final List<XFile?> selectedImages =
        await picker.pickMultiImage(requestFullMetadata: false);
    return selectedImages;
  }

  /// opens camera
  static Future<XFile?> takeNewPhoto() async {
    final XFile? newImage = await picker.pickImage(
      source: ImageSource.camera,
      requestFullMetadata: false,
    );
    return newImage;
  }
}
