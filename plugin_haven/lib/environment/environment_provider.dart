import 'package:flutter/material.dart';
import 'package:plugin_haven/app/haven_environment.dart';
import 'package:plugin_haven/environment/environment_notifier.dart';
import 'package:provider/provider.dart';

/// A wrapper around the environment notifier that provides the environment
/// to the rest of the app.
class EnvironmentProvider extends StatelessWidget {
  const EnvironmentProvider({
    Key? key,
    required this.child,
    this.defaultEnvironment,
  }) : super(key: key);

  final Widget child;
  final Environment? defaultEnvironment;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (e) => EnvironmentNotifier(environment: defaultEnvironment),
      child: child,
    );
  }
}
