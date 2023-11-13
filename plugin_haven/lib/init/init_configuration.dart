//  Copyright © 2020 Bottle Rocket Studios. All rights reserved.

import 'package:plugin_haven/haven.dart';

typedef PrerunFuture = Future<void> Function();

class InitConfiguration {
  InitConfiguration({
    this.onInitialize,
    this.initialEnvironment,
    this.environmentConfigurationFactory,
  });

  final Environment? initialEnvironment;
  final PrerunFuture? onInitialize;
  final EnvironmentConfiguration? Function(Environment)?
      environmentConfigurationFactory;
}
