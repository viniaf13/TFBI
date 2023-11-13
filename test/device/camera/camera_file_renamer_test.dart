import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:txfb_insurance_flutter/device/camera/camera_file_renamer.dart';

void main() {
  Future<void> resetFileNames() async {
    final sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.setInt(CameraFileRenamer.preferencesKey, 0);
  }

  setUp(() => resetFileNames);

  group(
    'Testing Camera file renamer',
    () {
      test(
        'Given a file that is not named according to convention, name it properly and change its state to `selected`',
        () async {},
      );
      test(
        'Given a file in the `selected` state, rename it to `queued`',
        () async {},
      );
      test(
        'given a file in the `queued` state, rename it to `processing`',
        () async {},
      );
      test(
        'given a file in the `processing` state, rename it to `complete`',
        () async {},
      );
    },
  );
}
