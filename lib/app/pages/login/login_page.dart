import 'dart:async';

import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:plugin_haven/plugin_haven.dart';
import 'package:txfb_insurance_flutter/app/blocs/biometrics/biometrics_bloc.dart';
import 'package:txfb_insurance_flutter/app/cubits/app_update/app_update_cubit.dart';
import 'package:txfb_insurance_flutter/app/cubits/tfb_single_request_cubit/tfb_single_request_cubit.dart';
import 'package:txfb_insurance_flutter/app/pages/login/widgets/app_update_dialog.dart';
import 'package:txfb_insurance_flutter/app/pages/login/widgets/login_page_content.dart';
import 'package:txfb_insurance_flutter/app/pages/login/widgets/splash_screen/splash_screen.dart';
import 'package:txfb_insurance_flutter/domain/clients/tfb_member_access_client.dart';
import 'package:txfb_insurance_flutter/domain/models/app_update/app_update_response.dart';
import 'package:txfb_insurance_flutter/resources/theme/theme.dart';
import 'package:txfb_insurance_flutter/shared/mixins/page_properties_mixin.dart';
import 'package:txfb_insurance_flutter/shared/shared.dart';

class LoginPage extends StatefulWidget with PagePropertiesMixin {
  const LoginPage({
    this.shouldSkipSplashAnimation = false,
    this.shouldLogout = false,
    super.key,
  });

  @override
  String get screenName => 'Sign in Screen';

  final bool shouldSkipSplashAnimation;
  final bool shouldLogout;

  @override
  State<LoginPage> createState() => _LoginPageState();
}

// The length of the transition from the blue background screen to the actual
// animated background splash screen.
const dashboardOpacityOverlayTransitionDuration = Duration(milliseconds: 300);

// Configuration options for the primary animation, not the opacity animation
const _mainAnimationCurve = Interval(
  0,
  1,
  curve: Cubic(0.75, 0, 0.25, 1),
);
const _mainAnimationDuration = Duration(milliseconds: 1500);
const _mainAnimationPreDelay = Duration(milliseconds: 1200);

class _LoginPageState extends State<LoginPage>
    with TickerProviderStateMixin, WidgetsBindingObserver {
  late AnimationController _mainAnimationController;
  late AnimationController _opacityAnimationController;
  final startIconKey = GlobalKey();
  final endIconKey = GlobalKey();
  RenderBox? startIconRenderBox;
  RenderBox? endIconRenderBox;
  bool showStartingOverlayColor = false;
  bool shouldCheckAppVersion = true;
  bool shouldPromptForBiometrics = false;
  Timer? opacityDelayTimer;

  @override
  void initState() {
    super.initState();

    /// Observer for lifecycle awareness
    WidgetsBinding.instance.addObserver(this);
    _mainAnimationController = AnimationController(
      duration: durationOrSkip(
        _mainAnimationDuration,
        skip: widget.shouldSkipSplashAnimation,
      ),
      vsync: this,
    );

    _opacityAnimationController = AnimationController(
      vsync: this,
      duration: dashboardOpacityOverlayTransitionDuration,
    );

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      // Animate the opacity overlay from blue to transparent
      _opacityAnimationController
        ..addListener(() {
          setState(() {});
        })
        ..forward();

      final delayBeforeStartingMainAnimation = durationOrSkip(
        dashboardOpacityOverlayTransitionDuration + _mainAnimationPreDelay,
        skip: widget.shouldSkipSplashAnimation,
      );

      /// Wait until the opacity animation and delay have completed before
      /// displaying the main animation
      ///
      /// Use a [Timer] object here instead of [Future.delayed] so that if the login
      /// page is disposed, we can cancel the Timer instead of leaving it open.
      opacityDelayTimer = Timer(delayBeforeStartingMainAnimation, () {
        // Update the UI when the animation controller value changes
        _mainAnimationController.addListener(() {
          setState(() {});
        });

        // Get a snapshot of the positions of the two star icons, the one in the
        // center of the screen, and the one at the top. Used to animate between
        // the two widgets
        setState(() {
          startIconRenderBox =
              startIconKey.currentContext?.findRenderObject() as RenderBox;
          endIconRenderBox =
              endIconKey.currentContext?.findRenderObject() as RenderBox;
        });

        // Start the main animation
        _mainAnimationController.forward().orCancel;

        _mainAnimationController.addStatusListener((status) {
          if (status == AnimationStatus.completed) {
            setState(() {
              shouldPromptForBiometrics = true;
            });

            /// Once animations have completed, check the app version
            _checkAppVersion();
          }
        });
      });
    });

    if (widget.shouldLogout) {
      context.read<AuthBloc>().add(AuthSignOutEvent());
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarIconBrightness: Brightness.dark,
        statusBarBrightness: Brightness.light,
      ),
      child: BlocBuilder<AuthBloc, AuthState>(
        builder: (context, state) {
          return GradientBackground(
            showLoadingOverlay: state is AuthProcessing,
            gradient: LightColors.splashScreenGradient,
            child: Stack(
              children: [
                AnimatedTopImage(
                  controller: _mainAnimationController,
                  curve: _mainAnimationCurve,
                ),
                AnimatedCenterLogo(
                  controller: _mainAnimationController,
                  curve: _mainAnimationCurve,
                  logoKey: startIconKey,
                ),
                const AnimatedBottomImage(),
                LoginPageContent(
                  controller: _mainAnimationController,
                  curve: _mainAnimationCurve,
                  endIconKey: endIconKey,
                ),
                if (_mainAnimationController.value != 0 &&
                    _mainAnimationController.value != 1)
                  AnimatedHeroStar(
                    controller: _mainAnimationController,
                    curve: _mainAnimationCurve,
                    endRenderBox: endIconRenderBox,
                    startRenderBox: startIconRenderBox,
                  ),
                BrandOpacityOverlay(
                  opacityProgress: _opacityAnimationController,
                  mainAnimationProgress: _mainAnimationController,
                ),
                BlocListener<AuthBloc, AuthState>(
                  listener: (context, state) {
                    if (state is AuthSignedIn) {
                      _opacityAnimationController.reverse();
                    }
                  },
                  child: const SizedBox.shrink(),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Duration durationOrSkip(Duration duration, {bool skip = false}) {
    return skip ? Duration.zero : duration;
  }

  // Check the current App Version against api call response
  Future<void> _checkAppVersion() async {
    final appUpdateCubit = context.read<AppUpdateCubit>();
    final packageInfo = await PackageInfo.fromPlatform();
    final currentVersion = packageInfo.version;
    AppUpdateResponse response;

    if (appUpdateCubit.state is! TfbSingleRequestInitial) return;

    await appUpdateCubit.request(
      fallbackRequest: () async {
        response = await AppUpdateCubit.checkAppVersion(
          context.read<TfbMemberAccessClient>(),
        );

        final shouldShowUpdatePrompt =
            currentVersion.compareVersionNumbers(response.recommendedVersion);
        final shouldForceUpdate = currentVersion.compareVersionNumbers(
          response.minSupportVersion,
        );

        if (shouldShowUpdatePrompt) {
          _showUpdateDialog(
            response,
            forceUpdate: shouldForceUpdate,
          );
        } else {
          _completeAppUpdatePrompt();
        }

        return response;
      },
    );
  }

  // If app needs to be updated, show update dialog
  void _showUpdateDialog(
    AppUpdateResponse response, {
    required bool forceUpdate,
  }) {
    WidgetsBinding.instance.addPostFrameCallback(
      (_) async {
        await showDialog<void>(
          context: context,
          barrierDismissible: !forceUpdate,
          builder: (context) => AppUpdateDialog(
            androidLink: response.androidStoreLink,
            iosLink: response.iosStoreLink,
            forceUpdate: forceUpdate,
          ),
        );

        _completeAppUpdatePrompt();
      },
    );
  }

  void _completeAppUpdatePrompt() {
    setState(() => shouldCheckAppVersion = false);
    _runLocalAuth();
  }

  void _runLocalAuth() {
    if (shouldPromptForBiometrics) {
      context.read<BiometricsBloc>().add(const PromptBiometricsIfAvailable());

      WidgetsBinding.instance.addPostFrameCallback(
        (_) => setState(() => shouldPromptForBiometrics = false),
      );
    }
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    if (state == AppLifecycleState.resumed && shouldCheckAppVersion == false) {
      _runLocalAuth();
    }
  }

  @override
  void dispose() {
    opacityDelayTimer?.cancel();
    _mainAnimationController.dispose();
    _opacityAnimationController.dispose();
    super.dispose();
  }
}
