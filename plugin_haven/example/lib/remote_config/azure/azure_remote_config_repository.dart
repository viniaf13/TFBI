import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';
import 'package:plugin_haven/remote_config/haven_remote_config_repository.dart';
import 'package:plugin_haven_example/remote_config/azure/azure_app_configuration_client.dart';
import 'package:plugin_haven_example/remote_config/azure/azure_remote_config_credentials.dart';

Uri _appConfigurationBaseUri =
    Uri.parse('https://haven-app-config.azconfig.io');

class AzureRemoteAppConfigurationRepository
    extends HavenRemoteConfigurationRepository {
  Uri? _baseUrl;
  AzureAppConfigurationClient? _client;

  static final AzureRemoteAppConfigurationRepository _instance =
      AzureRemoteAppConfigurationRepository._internal();

  AzureRemoteAppConfigurationRepository._internal();

  factory AzureRemoteAppConfigurationRepository({Uri? baseUrl}) {
    return _instance;
  }

  Box? _cache;

  @override
  Future<void> initialize() async {
    _baseUrl ??= _appConfigurationBaseUri;
    _client ??= AzureAppConfigurationClient(
      baseUri: _baseUrl!,
      credential: remoteConfigCredential,
      secret: remoteConfigSecret,
    );
    _cache ??= await Hive.openBox('azure_remote_config');
  }

  @override
  Future<void> fetch() {
    return Future.value();
  }

  @override
  bool? getBool(String key) {
    return getValue<bool>(key);
  }

  @override
  double? getDouble(String key) {
    return getValue<double>(key);
  }

  @override
  int? getInt(String key) {
    return getValue<int>(key);
  }

  @override
  String? getString(String key) {
    return getValue<String>(key);
  }

  @override
  Map<String, dynamic> getJson(String key) {
    throw UnimplementedError();
  }

  @override
  Future<void> setDefaultValue(String key, value) async {
    if (_cache?.get(key) == null) {
      _cache?.put(key, value);
    }
  }

  T? getValue<T>(String key) {
    asynchronouslyGetConfigValueAndCacheResult<T>(key);

    // Immediately return the cached result if it exists
    if (_cache?.get(key) is T) {
      return _cache?.get(key) as T;
    }

    return null;
  }

  void asynchronouslyGetConfigValueAndCacheResult<T>(String key) {
    _client?.getAzureAppConfigurationValue(key).then(
      (response) {
        if (response.value is T) {
          _cache?.put(key, response.value);
        }
      },
    ).catchError((e) {
      debugPrint(e.toString());
    });
  }
}
