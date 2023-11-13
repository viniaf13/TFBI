//  Copyright © 2021 Bottle Rocket Studios. All rights reserved.

import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

const _defaultBoxName = 'settings';
var _didInit = false;

class Preferences {
  Preferences({this.boxName = _defaultBoxName});

  // Allows additional instances with application specific boxes
  final String boxName;
  late Box _box;
  bool? _isFirstRun;
  bool get isFirstRun => (_isFirstRun != null) ? _isFirstRun! : true;
  Box get hiveSettings => _box;

  // WidgetsFlutterBinding.ensureInitialized must be called first
  Future<void> init({String? preferencesDbPath}) async {
    if (!_didInit) {
      _didInit = true;
      var hivePath = preferencesDbPath;
      if (hivePath == null) {
        try {
          final appDocsDir = await getApplicationDocumentsDirectory();
          hivePath = appDocsDir.path;
        } catch (error) {
          if (!kIsWeb) {
            debugPrint('Hive Init exception: ${error.toString()}');
          }
          hivePath = '';
        }
      }
      Hive.init(hivePath);
    }
    return _openSettings();
  }

  Future<void> _openSettings() async {
    _box = await Hive.openBox(boxName);
    _isFirstRun = _box.get('isFirstRun');
    if (_isFirstRun == null) {
      await _box.put('isFirstRun', true);
      _isFirstRun = true;
    } else if (_isFirstRun!) {
      await _box.put('isFirstRun', false);
      _isFirstRun = false;
    }
  }

  Future<dynamic> get(dynamic key) async {
    _box = await Hive.openBox(boxName);
    return _box.get(key);
  }
}
