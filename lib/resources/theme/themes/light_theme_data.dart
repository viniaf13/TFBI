// coverage:ignore-file

import 'package:txfb_insurance_flutter/resources/theme/theme.dart';
import 'package:txfb_insurance_flutter/resources/theme/themes/tfb_radius_styles.dart';
import 'package:txfb_insurance_flutter/resources/theme/themes/tfb_typography.dart';

class LightThemeData {
  ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,

    // COLOR
    canvasColor: LightColors.canvasColor,
    cardColor: LightColors.cardColor,
    colorScheme: LightColors.lightColorScheme,
    // Color? colorSchemeSeed, used to create a [ColorScheme] from a seed color
    // In this template, a Seed is unnecessary because the a Scheme is established
    dialogBackgroundColor: LightColors.dialogBackgroundColor,
    disabledColor: LightColors.disabledColor,
    dividerColor: LightColors.dividerColor,
    focusColor: LightColors.focusColor,
    highlightColor: LightColors.highlightColor,
    hintColor: LightColors.hintColor,
    hoverColor: LightColors.hoverColor,
    indicatorColor: LightColors.indicatorColor,
    primaryColor: LightColors.primary,
    primaryColorDark: DarkColors.primary,
    primaryColorLight: LightColors.primary,
    scaffoldBackgroundColor: LightColors.scaffoldBackgroundColor,
    secondaryHeaderColor: LightColors.secondaryHeaderColor,
    shadowColor: LightColors.shadowColor,
    splashColor: LightColors.splashColor,
    unselectedWidgetColor: LightColors.unselectedWidgetColor,

    // TYPOGRAPHY & ICONOGRAPHY
    // Component themes, package, iconTheme, primaryIconTheme not currently implemented
    fontFamily: TfbTypography.brandFontFamily,
    fontFamilyFallback: const [
      TfbTypography.brandFontFamily,
    ],
    extensions: const <ThemeExtension<dynamic>>[
      TfbTypography(),
    ],

    // COMPONENT THEMES
    /* Add component themes below, ie AppBarTheme, DialogTheme, etc **/ //
    inputDecorationTheme: const InputDecorationTheme(
      labelStyle: TextStyle(
        color: TfbBrandColors.grayHigh,
        fontWeight: FontWeight.w400,
        fontSize: 16,
        height: 1,
      ),
      errorStyle: TextStyle(
        fontWeight: FontWeight.w400,
        fontSize: 12,
        height: 1.15,
      ),
      enabledBorder: UnderlineInputBorder(
        borderSide: BorderSide(color: TfbBrandColors.grayHigh),
      ),
    ),
    filledButtonTheme: FilledButtonThemeData(
      style: ButtonStyle(
        textStyle: MaterialStateProperty.all(
          const TfbTypography().bodyMediumSmall,
        ),
        padding: MaterialStateProperty.all(const EdgeInsets.all(13)),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: TfbRadiusStyles().defaultRadius,
          ),
        ),
      ),
    ),
    textButtonTheme: TextButtonThemeData(
      style: ButtonStyle(
        splashFactory: NoSplash.splashFactory,
        padding: MaterialStateProperty.all(const EdgeInsets.all(13)),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: TfbRadiusStyles().defaultRadius,
          ),
        ),
      ),
    ),

    switchTheme: SwitchThemeData(
      trackColor: MaterialStateProperty.resolveWith((states) {
        if (states.contains(MaterialState.selected)) {
          return TfbBrandColors.blueHighest;
        }
        return LightColors.surface;
      }),
      thumbColor: MaterialStateProperty.resolveWith((states) {
        if (states.contains(MaterialState.selected)) {
          return LightColors.surface;
        }

        return TfbBrandColors.blueHighest;
      }),
    ),
    snackBarTheme: SnackBarThemeData(
      backgroundColor: LightColors.error,
      actionTextColor: LightColors.onError,
      disabledActionTextColor: LightColors.onError,
      contentTextStyle: const TfbTypography().bodyMediumSmall,
      insetPadding: const EdgeInsets.all(4),
      showCloseIcon: true,
      closeIconColor: TfbBrandColors.redHighest,
    ),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: TfbBrandColors.white,
    ),
    cardTheme: CardTheme(
      shape: RoundedRectangleBorder(
        borderRadius: TfbRadiusStyles().defaultRadius,
      ),
      color: TfbBrandColors.white,
      elevation: 0,
    ),
    dividerTheme: const DividerThemeData(
      color: TfbBrandColors.grayMedium,
    ),
    dialogTheme: DialogTheme(
      surfaceTintColor: TfbBrandColors.transparent,
      shape: RoundedRectangleBorder(
        borderRadius: TfbRadiusStyles().defaultRadius,
      ),
    ),
  );
}
