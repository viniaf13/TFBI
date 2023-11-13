// coverage:ignore-file

import 'package:flutter/material.dart';
import 'package:txfb_insurance_flutter/resources/theme/colors/colors.dart';

/** Dark mode colors that correspond with Material design color palette */ ///
class DarkColors {
  // Material Design Colors -- Containers set to a default of white until XD approval
  static Color primary = TfbBrandColors.blueHighest;
  static Color primaryContainer = TfbBrandColors.blueHigh; // TFB Light Blue
  static Color secondary = TfbBrandColors.redHighest; // TFB Dark Red
  static Color secondaryContainer = TfbBrandColors.redHigh; // TFB Light Red
  static Color tertiary = TfbBrandColors.grayHighest; // TFB Dark Gray
  static Color tertiaryContainer = const Color(0xFFFFFFFF);

  static Color error = const Color(0xFFD70019);
  static Color darkError = const Color(0xFF6E0000);
  static Color errorContainer = const Color(0xFFFFFFFF);
  static Color outline = const Color(0xFF79747E);
  static Color background = const Color(0xFF000000);
  static Color surface = const Color(0xFF000000);
  // Variant of Surface intended as a lower emphasis version of Surface
  static Color surfaceVariant = const Color(0xFF79747E);
  static Color inverseSurface = const Color(0xFFFFFFFF);
  // static Color inversePrimary = const Color(0xFF6750A4);
  static Color shadowColor = const Color(0xFF000000);
  // static Color surfaceTint = const Color(0xFFD0BCFF);
  // static Color outlineVariant = const Color(0xFF49454F);
  // static Color scrim = const Color(0xFF000000);

  // Font Colors
  static Color onPrimary = const Color(0xFF381E72);
  static Color onPrimaryContainer = const Color(0xFFEADDFF);
  static Color onSecondary = const Color(0xFF332D41);
  static Color secondaryHeaderColor = secondary;
  static Color onSecondaryContainer = const Color(0xFFE8DEF8);
  static Color onTertiary = const Color(0xFF492532);
  static Color onTertiaryContainer = const Color(0xFFFFD8E4);
  static Color onBackground = const Color(0xFFE6E1E5);
  static Color onSurface = const Color(0xFFE6E1E5);
  static Color onError = const Color(0xFF601410);
  static Color onErrorContainer = const Color(0xFFF9DEDC);
  static Color onSurfaceVariant = const Color(0xFFCAC4D0);
  static Color onInverseSurface = const Color(0xFF313033);

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
  static Color scaffoldBackgroundColor = background;
  static Color splashColor = primary;
  static Color unselectedWidgetColor = inverseSurface;

  static final darkColorScheme = ColorScheme(
    brightness: Brightness.dark,
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
    background: outline,
  );
}
