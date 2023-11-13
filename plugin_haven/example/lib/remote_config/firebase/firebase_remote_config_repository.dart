import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:plugin_haven/remote_config/haven_remote_config_repository.dart';

class FirebaseRemoteConfigRepository
    extends HavenRemoteConfigurationRepository {
  late final FirebaseRemoteConfig _remoteConfig;

  static final FirebaseRemoteConfigRepository _instance =
      FirebaseRemoteConfigRepository._internal();

  FirebaseRemoteConfigRepository._internal() {
    _remoteConfig = FirebaseRemoteConfig.instance;
  }

  factory FirebaseRemoteConfigRepository() {
    return _instance;
  }

  @override
  Future<void> initialize() async {
    await _remoteConfig.setConfigSettings(
      RemoteConfigSettings(
        fetchTimeout: const Duration(minutes: 1),
        minimumFetchInterval: const Duration(hours: 1),
      ),
    );
    _remoteConfig.activate();
  }

  @override
  Future<void> fetch() {
    return _remoteConfig.fetchAndActivate();
  }

  @override
  Future<void> setDefaultValue(String key, value) async {
    await _remoteConfig.setDefaults(<String, dynamic>{
      key: value,
    });
  }

  @override
  String getString(String key) {
    return _remoteConfig.getString(key);
  }

  @override
  bool getBool(String key) {
    return _remoteConfig.getBool(key);
  }

  @override
  double getDouble(String key) {
    return _remoteConfig.getDouble(key);
  }

  @override
  int getInt(String key) {
    return _remoteConfig.getInt(key);
  }

  @override
  Map<String, dynamic> getJson(String key) {
    throw UnimplementedError();
  }
}
