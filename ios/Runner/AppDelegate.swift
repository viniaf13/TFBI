import UIKit
import Flutter
import workmanager
import path_provider_foundation
import shared_preferences_foundation
import flutter_secure_storage

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    GeneratedPluginRegistrant.register(with: self)
    WorkmanagerPlugin.registerTask(withIdentifier: "com.txfb-ins.txfb1.submitPhoto")
    WorkmanagerPlugin.setPluginRegistrantCallback { registry in  
        PathProviderPlugin.register(with: registry.registrar(forPlugin: "io.flutter.plugins.pathprovider.PathProviderPlugin")!)
        SharedPreferencesPlugin.register(with: registry.registrar(forPlugin: "io.flutter.plugins.sharedpreferences.SharedPreferencesPlugin")!)
        FlutterSecureStoragePlugin.register(with: registry.registrar(forPlugin: "com.it_nomads.fluttersecurestorage.FlutterSecureStoragePlugin")!)
    }
    UIApplication.shared.setMinimumBackgroundFetchInterval(TimeInterval(60*15))
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}
