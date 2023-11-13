// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:plugin_haven/plugin_haven.dart';

class ExampleAppEnvironment extends Environment {
  ExampleAppEnvironment(this.envType) : super();
  final EnvironmentType envType;
  final bool usePreview = true;

  EnvironmentType get exampleEnvType => envType;

  @override
  String toString() {
    return envType.name.toUpperCase();
  }

  @override
  bool operator ==(covariant ExampleAppEnvironment other) {
    if (identical(this, other)) return true;

    return other.envType == envType;
  }

  @override
  int get hashCode => envType.hashCode;
}
