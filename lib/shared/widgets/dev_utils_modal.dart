import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:plugin_haven/environment/environment_notifier.dart';
import 'package:plugin_haven/plugin_haven.dart';
import 'package:provider/provider.dart';
import 'package:txfb_insurance_flutter/app/router/router.dart';
import 'package:txfb_insurance_flutter/data/data.dart';
import 'package:txfb_insurance_flutter/device/environment/environment.dart';
import 'package:txfb_insurance_flutter/device/environment/tfb_environment_device_preview.dart';
import 'package:txfb_insurance_flutter/resources/theme/colors/colors.dart';
import 'package:txfb_insurance_flutter/shared/constants/environment_keys.dart';
import 'package:txfb_insurance_flutter/shared/shared.dart';

class DevUtilsModal extends StatelessWidget {
  const DevUtilsModal({super.key});

  static void show(BuildContext context) {
    const isAppstoreBuild = bool.fromEnvironment(kAppStoreEnvironmentKey);
    if (isAppstoreBuild) {
      return;
    }

    showDialog<void>(
      context: context,
      builder: (childContext) => Provider.value(
        value: context.navigator,
        child: ChangeNotifierProvider.value(
          value: Provider.of<EnvironmentNotifier>(context),
          child: const DevUtilsModal(),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final authState = BlocProvider.of<AuthBloc>(context, listen: true).state;
    final isSignedIn = authState is AuthSignedIn;

    return AlertDialog(
      contentPadding: EdgeInsets.zero,
      surfaceTintColor: TfbBrandColors.transparent,
      content: Scaffold(
        body: Builder(
          builder: (context) {
            return Padding(
              padding: const EdgeInsets.all(kSpacingMedium),
              child: SizedBox(
                height: double.infinity,
                width: MediaQuery.sizeOf(context).width - 100,
                child: ListView(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 8),
                      child: Text(
                        'Current Environment',
                        style: context.tfbText.bodyMediumSmall,
                      ),
                    ),
                    Text(context.getEnvironment<TfbEnvironment>().toString()),
                    const SizedBox(
                      height: 16,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 8),
                      child: Text(
                        isSignedIn ? 'Sign Out To Swap' : 'Swap Environment',
                        style: context.tfbText.bodyMediumSmall,
                      ),
                    ),
                    TfbFilledButton.primaryTextButton(
                      onPressed: isSignedIn
                          ? null
                          : () {
                              context.environment = TfbEnvironmentDev();
                            },
                      title: context.getLocalizationOf.switchDev,
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    TfbFilledButton.primaryTextButton(
                      onPressed: isSignedIn
                          ? null
                          : () {
                              context.environment = TfbEnvironmentProduction();
                            },
                      title: context.getLocalizationOf.switchProd,
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    TfbFilledButton.primaryTextButton(
                      onPressed: isSignedIn
                          ? null
                          : () {
                              context.environment = TfbEnvironmentStage();
                            },
                      title: context.getLocalizationOf.switchStage,
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    TfbFilledButton.primaryTextButton(
                      onPressed: isSignedIn
                          ? null
                          : () {
                              context.environment =
                                  TfbEnvironmentDevicePreview();
                            },
                      title: context.getLocalizationOf.switchPreview,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 24),
                      child: Text(
                        'Charles Proxy IP',
                        style: context.tfbText.bodyMediumSmall,
                      ),
                    ),
                    TextFormField(
                      decoration: const InputDecoration(
                        hintText: '0.0.0.0',
                      ),
                      enabled: !isSignedIn,
                      onFieldSubmitted: (value) {
                        final environmentConfig = context.readEnvConfig();
                        final unauthenticateDioInstance =
                            environmentConfig?.unauthenticatedDio;
                        if (value.trim().isNullOrEmpty ||
                            unauthenticateDioInstance == null) return;

                        HavenProxyService.setProxy(value.trim());
                        HavenProxyService.addProxyIfSet(
                          unauthenticateDioInstance,
                        );
                        context.showSuccessSnackBar(
                          text: 'Charles proxy IP set to $value',
                          icon: const SizedBox.shrink(),
                        );
                      },
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 24),
                      child: Text(
                        'URL Path',
                        style: context.tfbText.bodyMediumSmall,
                      ),
                    ),
                    TextFormField(
                      decoration: InputDecoration(
                        hintText: '/path?queryParam=test',
                        hintStyle: context.tfbText.bodyLightLarge.copyWith(
                          color: TfbBrandColors.grayHigh,
                        ),
                      ),
                      onFieldSubmitted: (value) {
                        Navigator.pop(context);
                        context.navigator.UNSAFE_goWithPath(value);
                      },
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        top: kSpacingLarge,
                        bottom: kSpacingMedium,
                      ),
                      child: Text(
                        context.getLocalizationOf.devUtilsSimulateErrors,
                        style: context.tfbText.bodyMediumSmall,
                      ),
                    ),
                    TfbFilledButton.primaryTextButton(
                      title:
                          context.getLocalizationOf.devUtilsThrowTestException,
                      onPressed: () => throw Exception('Test Exception'),
                    ),
                    const SizedBox(
                      height: kSpacingSmall,
                    ),
                    TfbFilledButton.primaryTextButton(
                      title: context.getLocalizationOf.devUtilsCrashTest,
                      onPressed: () => FirebaseCrashlytics.instance.crash(),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
