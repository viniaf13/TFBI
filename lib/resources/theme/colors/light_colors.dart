// coverage:ignore-file

import 'package:flutter/material.dart';
import 'package:txfb_insurance_flutter/resources/theme/colors/tfb_brand_colors.dart';

/** Light mode colors that correspond with Material design color palette
 * Material 3 Color System Docs: https://m3.material.io/styles/color/the-color-system/custom-colors
 * Use Material 3 ThemeBuilder https://m3.material.io/theme-builder#/dynamic for assistance. */ ///
class LightColors {
  // Material Design Colors -- Containers set to a default of white until XD approval
  static Color primary = TfbBrandColors.blueHighest;
  static Color primaryContainer = TfbBrandColors.blueHigh; // TFB Light Blue
  static Color secondary = TfbBrandColors.redHighest; // TFB Dark Red
  static Color secondaryContainer = TfbBrandColors.redHigh; // TFB Light Red
  static Color tertiary = TfbBrandColors.grayHighest; // TFB Dark Gray
  static Color tertiaryContainer = const Color(0xFFFFFFFF);
  static Color activeClaimGreen = const Color(0xFF004E00);

  static Color error = const Color(0xFFD70019);
  static Color darkError = const Color(0xFF6E0000);
  static Color errorContainer = const Color(0xFFFFFFFF);
  static Color outline = TfbBrandColors.blueHighest;
  static Color background = const Color(0xFFFFFFFF);
  static Color surface = const Color(0xFFFFFFFF);
  static Color lightGraySurface = const Color(0xFFF2F2F2);
  static Color lightBlueSurface = const Color(0xFFe4f1f8);
  static Color darkPrimarySurface = const Color(0xff013565);
  static Color lightBlueIcon = const Color(0xFF78C1EE);
  static Color textDark = const Color(0xFF002D5A);
  static Color textLight = const Color(0xFFFFFFFF);
  static Color textSuccess = const Color(0xFF004E00);
  // Variant of Surface intended as a lower emphasis version of Surface
  static Color surfaceVariant = const Color(0xFF79747E);
  static Color inverseSurface = const Color(0xFF000000);
  // static Color inversePrimary = const Color(0xFFD0BCFF);
  static Color shadowColor = const Color(0xFF000000);
  // static Color surfaceTint = const Color(0xFF6750A4);
  // static Color outlineVariant = const Color(0xFFCAC4D0);
  // static Color scrim = const Color(0xFF000000);
  static Color borderGray = const Color(0xFFD9D9D9);
  static Color lightGray = const Color(0xFF999999);
  static Color linkColor = const Color.fromARGB(255, 0, 140, 225);

  // Font Colors
  static Color onPrimary = const Color(0xFFFFFFFF);
  static Color onPrimaryContainer = const Color(0xFFFFFFFF);
  static Color onSecondary = const Color(0xFFFFFFFF);
  static Color secondaryHeaderColor = primary;
  static Color onSecondaryContainer = const Color(0xFFFFFFFF);
  static Color onTertiary = const Color(0xFFFFFFFF);
  static Color onTertiaryContainer = const Color(0xFFFFFFFF);
  static Color onBackground = tertiary;
  static Color onSurface = tertiary;
  static Color onError = const Color(0xFFFFFFFF);
  static Color onErrorContainer = const Color(0xFFFFFFFF);
  // Variant of onSurface intended as a lower emphasis version of onSurface
  static Color onSurfaceVariant = const Color(0x8B323232);
  static Color onSurfaceVariantFull = const Color(0xFF323232);
  static Color onInverseSurface = const Color(0xFFFFFFFF);

  // Component Specific Colors for ThemeData
  static Color canvasColor = primaryContainer;
  static Color cardColor = primaryContainer;
  static Color dialogBackgroundColor = surface;
  static Color disabledColor = inverseSurface;
  static Color dividerColor = outline;
  static Color focusColor = primary;
  static Color highlightColor = tertiaryContainer;
  static Color hintColor = outline;
  static Color hoverColor = primary;
  static Color indicatorColor = primary;
  static Color scaffoldBackgroundColor = lightGraySurface;
  static Color splashColor = primary.withOpacity(0.1);
  static Color unselectedWidgetColor = inverseSurface;
  static Color urlColor = primaryContainer;

  static const Color greenHighLight = Color(0xFF00C938);
  static const Color authGradientTop = Color(0x13323232);
  static const Color authGradientBottom = Color(0x03323232);

  static const LinearGradient authenticationBackgroundGradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [authGradientTop, authGradientBottom],
  );

  static const Color unauthGradientTop = Color.fromARGB(255, 228, 241, 248);
  static const Color unauthGradientBottom = Color.fromARGB(255, 202, 226, 241);

  static const LinearGradient unauthenticatefLandingGradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [unauthGradientTop, unauthGradientBottom],
  );

  static const Color splashGradientTop = Color(0xFFCAE2F1);
  static const Color splashGradientMiddle = Color(0xFFFCE9E8);
  static const Color splashGradientBottom = Color(0xFFF9D4D1);

  static const LinearGradient splashScreenGradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [splashGradientTop, splashGradientMiddle, splashGradientBottom],
  );

  static const Color blueGradientTop = Color(0xff016db5);
  static const Color blueGradientBottom = Color(0xff014d88);

  static const LinearGradient darkBlueGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [blueGradientTop, blueGradientBottom],
  );

  static const Color processingSnackbarBackground = Color(0xFFCAE2F1);
  static const Color errorSnackbarBackground = Color(0xFFF9D4D1);
  static const Color successSnackbarBackground = Color(0xFFBFF1CD);

  static final lightColorScheme = ColorScheme(
    brightness: Brightness.light,
    primary: primary,
    onPrimary: onPrimary,
    primaryContainer: primaryContainer,
    onPrimaryContainer: onPrimaryContainer,
    secondary: secondary,
    onSecondary: onSecondary,
    secondaryContainer: secondaryContainer,
    onSecondaryContainer: onSecondaryContainer,
    tertiary: tertiary,
    onTertiary: onTertiary,
    tertiaryContainer: tertiaryContainer,
    onTertiaryContainer: onTertiaryContainer,
    error: error,
    onError: onError,
    errorContainer: errorContainer,
    onErrorContainer: onErrorContainer,
    outline: outline,
    background: outline,
    onBackground: onBackground,
    surface: surface,
    onSurface: onSurface,
    surfaceVariant: surfaceVariant,
    onSurfaceVariant: onSurfaceVariant,
    inverseSurface: inverseSurface,
    onInverseSurface: onInverseSurface,
    // inversePrimary: inversePrimary,
    shadow: shadowColor,
    // surfaceTint: surfaceTint,
    // outlineVariant: outlineVariant,
    // scrim: scrim,
  );
}
