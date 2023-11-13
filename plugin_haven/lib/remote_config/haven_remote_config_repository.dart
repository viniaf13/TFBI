/// Abstract class for the remote config repository.
abstract class HavenRemoteConfigurationRepository {
  /// Initialize the remote config service.
  Future<void> initialize();

  /// Set the default value for a specific key
  Future<void> setDefaultValue(String key, dynamic value);

  /// Force a refetch of the values from the remote config service.
  Future<void> fetch();

  /// Get a string from the remote config service.
  String? getString(String key);

  /// Get a double from the remote config service.
  double? getDouble(String key);

  /// Get an int from the remote config service.
  int? getInt(String key);

  /// Get a boolean from the remote config service.
  bool? getBool(String key);

  /// Get json from the remote config service.
  Map<String, dynamic> getJson(String key);
}
