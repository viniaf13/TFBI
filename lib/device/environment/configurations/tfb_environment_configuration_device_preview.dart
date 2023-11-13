// coverage:ignore-file
import 'package:txfb_insurance_flutter/data/data.dart';
import 'package:txfb_insurance_flutter/device/environment/configurations/tfb_environment_configuration_stage.dart';

class TfbEnvironmentConfigurationDevicePreview
    extends TfbEnvironmentConfigurationStage {
  @override
  bool get usePreview => true;
}
