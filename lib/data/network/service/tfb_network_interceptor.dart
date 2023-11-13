// coverage:ignore-file

import 'package:txfb_insurance_flutter/data/data.dart';

/// TFBNetworkInterceptor extends the Haven plugin interceptor even though
/// the abstract plugin class defines concrete implementations, here is where
/// plugin method overrides will live, as well as any TFB specific interceptor
/// methods and variables. See HavenNetworkInterceptor for more details on
/// the available methods and variables.
class TfbNetworkInterceptor extends HavenNetworkServiceInterceptor {
  TfbNetworkInterceptor({required super.allowFaking});
}
