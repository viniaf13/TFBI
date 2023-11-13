import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:plugin_haven/environment/environment_configuration.dart';
import 'package:plugin_haven/splash/bloc/index.dart';
import 'package:plugin_haven/splash/widgets/splash_gate.dart';

/// A splash gate that waits for a list of [splashChangeNotifiers] to notify before
/// displaying the splash complete builder.
///
/// Once the splash bloc is in the [DoneSplashState] state, the [splashCompleteBuilder]
/// is called to display the main app.
class ChangeNotifierSplashGate extends StatelessWidget {
  const ChangeNotifierSplashGate({
    super.key,
    required this.envConfig,
    required this.splashCompleteBuilder,
  });

  final EnvironmentConfiguration? envConfig;
  final Widget Function(BuildContext) splashCompleteBuilder;

  @override
  Widget build(BuildContext context) {
    return BlocListener<SplashBloc, SplashState>(
      listener: (context, state) {
        if (state is DisplaySplashState) {
          // Register a waiter for each notifier passed in
          envConfig?.splashConfiguration?.waiters?.forEach((element) {
            BlocProvider.of<SplashBloc>(context, listen: false)
                .add(AddSplashWaiterEvent());

            // When the listener notifies, remove the waiter in the splash bloc
            listener() {
              try {
                BlocProvider.of<SplashBloc>(context, listen: false)
                    .add(RemoveSplashWaiterEvent());
              } catch (_) {}
              element?.removeListener(listener);
            }

            element?.addListener(listener);
          });
        }
      },
      child: SplashGate(
        splashCompleteBuilder: splashCompleteBuilder,
        expectRoute: envConfig?.expectRoute ?? false,
      ),
    );
  }
}
