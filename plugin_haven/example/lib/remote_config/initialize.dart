// ignore_for_file: dead_code

import 'package:plugin_haven/remote_config/haven_remote_config_repository.dart';
import 'package:plugin_haven_example/remote_config/azure/azure_remote_config_repository.dart';
import 'package:plugin_haven_example/remote_config/firebase/firebase_remote_config_repository.dart';

/// For the purposes of this example app, Liam McMains went ahead and created
/// a Firebase and Azure app configuration resource for the example app.
///
/// Azure app configuration resource currently created at this link:
/// https://portal.azure.com/#@omgww.onmicrosoft.com/resource/subscriptions/69527b22-42a9-40f8-9974-5348f60b6868/resourceGroups/haven_remote_config_testing/providers/Microsoft.AppConfiguration/configurationStores/haven-app-config/kvs
///
/// Firebase remote configuration resource currently created at this link:
/// https://console.firebase.google.com/u/1/project/haven-example-app/config
///
/// Send Liam a message if you'd like access to either resource
Future<HavenRemoteConfigurationRepository>
    initializeRemoteConfiguration() async {
  // Set to true to use Firebase, false to use Azure
  bool useFirebase = true;

  HavenRemoteConfigurationRepository remoteConfig = useFirebase
      ? FirebaseRemoteConfigRepository()
      : AzureRemoteAppConfigurationRepository();
  String defaultValue = "${useFirebase ? "Firebase" : "Azure"} Default";

  await remoteConfig.initialize();
  await remoteConfig.setDefaultValue(
    "hello_world",
    defaultValue,
  );
  await remoteConfig.fetch();

  return remoteConfig;
}
