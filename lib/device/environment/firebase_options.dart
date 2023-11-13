// coverage:ignore-file

import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;
import 'package:txfb_insurance_flutter/texas_farm_bureau_insurance.dart';

class DefaultFirebaseOptions {
  static FirebaseOptions currentPlatformWithEnvironment(TfbEnvironment env) {
    if (kIsWeb) {
      throw UnsupportedError(
        'DefaultFirebaseOptions have not been configured for web - '
        'you can reconfigure this by running the FlutterFire CLI again.',
      );
    }

    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        if (env is TfbEnvironmentProduction) {
          return androidProduction;
        } else {
          return androidStaging;
        }
      case TargetPlatform.iOS:
        if (env is TfbEnvironmentProduction) {
          return iosProduction;
        } else {
          return iosStaging;
        }
      case TargetPlatform.macOS:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for macos - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.windows:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for windows - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions androidStaging = FirebaseOptions(
    apiKey: 'AIzaSyDewH-C_yalOH1LltSpXktg0zl7uR_enmQ',
    appId: '1:81458761110:android:a209cc282530c7140fa1b7',
    messagingSenderId: '81458761110',
    projectId: 'tfbi-consumer-app-staging',
    storageBucket: 'tfbi-consumer-app-staging.appspot.com',
    androidClientId:
        '81458761110-q9sjmddcgk8l5ptdk66cnvounptp58np.apps.googleusercontent.com',
  );

  static const FirebaseOptions iosStaging = FirebaseOptions(
    apiKey: 'AIzaSyAz1whtkLJDKXLuqI5gZ7e5SNrpnszdRDQ',
    appId: '1:81458761110:ios:46b5a61454d941a40fa1b7',
    messagingSenderId: '81458761110',
    projectId: 'tfbi-consumer-app-staging',
    storageBucket: 'tfbi-consumer-app-staging.appspot.com',
    iosClientId:
        '81458761110-m0tv0e85a66u9ius8ipr970lcdasuljd.apps.googleusercontent.com',
    iosBundleId: 'com.txfb-ins.txfb1',
  );

  static const FirebaseOptions androidProduction = FirebaseOptions(
    apiKey: 'AIzaSyAjdgbQOoMDgXI_9rOcQgCJbAJHYIjkwwI',
    appId: '1:909735394444:android:e6a4f4a1a4ecf1127bcfa9',
    messagingSenderId: '909735394444',
    projectId: 'tfbi-consumer-app',
    storageBucket: 'tfbi-consumer-app.appspot.com',
  );

  static const FirebaseOptions iosProduction = FirebaseOptions(
    apiKey: 'AIzaSyBly99YNsroFR4JqKSFDVG6mb695SUdXhw',
    appId: '1:909735394444:ios:a0bc19c8dd860d8a7bcfa9',
    messagingSenderId: '909735394444',
    projectId: 'tfbi-consumer-app',
    storageBucket: 'tfbi-consumer-app.appspot.com',
    iosClientId:
        '909735394444-vqne7pns7q62nvn444aphv5bim0kh14k.apps.googleusercontent.com',
    iosBundleId: 'com.txfb-ins.txfb1',
  );
}
