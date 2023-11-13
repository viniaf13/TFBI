import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:plugin_haven/haven.dart';
import 'package:plugin_haven/splash/widgets/widget_splash_view.dart';

/// A widget that uses the [SplashBloc] to display the correct splash screen
/// based on the current state of the bloc.
///
/// Once the splash is complete, the [splashCompleteBuilder] is called to
/// display the main app.
class SplashGate extends StatelessWidget {
  const SplashGate({
    super.key,
    required this.splashCompleteBuilder,
    this.expectRoute = false,
  });

  final Widget Function(BuildContext) splashCompleteBuilder;
  final bool expectRoute;

  @override
  Widget build(BuildContext context) {
    final bool hasPreview =
        context.findAncestorWidgetOfExactType<DevicePreview>() != null;
    return BlocSelector<SplashBloc, SplashState, SplashState>(
      selector: (state) {
        // Skip all the splash stuff if we are expecting route
        // (this normally happens from web when going directly to a URL)
        if (state is InitialSplashState && (expectRoute)) {
          return const DoneSplashState();
        }
        return state;
      },
      builder: (context, state) {
        if (state is DoneSplashState) {
          return splashCompleteBuilder(context);
        } else if (state is ImageSplashState) {
          return MaterialApp(
            //useInheritedMediaQuery: hasPreview,
            locale: hasPreview ? DevicePreview.locale(context) : null,
            builder: hasPreview ? DevicePreview.appBuilder : null,
            home: ImageSplashView(
              imageAsset: state.imageAsset,
              backgroundColor: state.backgroundColor,
            ),
          );
        } else if (state is WidgetSplashState) {
          return MaterialApp(
            //useInheritedMediaQuery: hasPreview,
            locale: hasPreview ? DevicePreview.locale(context) : null,
            builder: hasPreview ? DevicePreview.appBuilder : null,
            home: WidgetSplashView(child: state.widget),
          );
        } else if (state is LottieSplashState) {
          return MaterialApp(
            //useInheritedMediaQuery: hasPreview,
            locale: hasPreview ? DevicePreview.locale(context) : null,
            builder: hasPreview ? DevicePreview.appBuilder : null,
            home: LottieView(
              backgroundColor: state.backgroundColor,
              lottieAsset: state.lottieAsset,
              repeatSplashWhile: state.repeatSplashWhile,
              onComplete: () {
                BlocProvider.of<SplashBloc>(context)
                    .add(RemoveSplashWaiterEvent());
              },
            ),
          );
        } else if (state is InitialSplashState) {
          return MaterialApp(
            //useInheritedMediaQuery: hasPreview,
            locale: hasPreview ? DevicePreview.locale(context) : null,
            builder: hasPreview ? DevicePreview.appBuilder : null,
            home: const Scaffold(
              body: Center(
                child: CircularProgressIndicator(
                  strokeWidth: 4.0,
                ),
              ),
            ),
          );
        } else {
          debugPrint('Unexpected init state: ${state.toString()}');
          return const Placeholder();
        }
      },
    );
  }
}
