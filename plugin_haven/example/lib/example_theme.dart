import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ExampleTheme {
  static const Color font = Color(0xFF000000);
  static const Color secondary1 = Color(0xFFFF6200);

  static TextStyle get fkGroteskNeueMedium => const TextStyle(
        fontFamily: 'FK Grotesk Neue',
        fontWeight: FontWeight.w700,
        color: font,
      );

  static TextStyle get fkGroteskNeueRegular => const TextStyle(
        fontFamily: 'FK Grotesk Neue',
        fontWeight: FontWeight.w400,
        color: font,
      );

  static TextStyle headline6Style = fkGroteskNeueMedium.copyWith(
    fontSize: 14,
  );

  static TextStyle body1Style = fkGroteskNeueRegular.copyWith(
    fontSize: 16,
  );
  static TextStyle body2Style = fkGroteskNeueRegular.copyWith(
    fontSize: 14,
  );

  static final ThemeData _base = ThemeData.localize(
    ThemeData.light(),
    ThemeData(fontFamily: 'FK Grotesk Neue').textTheme,
  );

  static ThemeData exampleLightTheme() {
    return _base.copyWith(
      colorScheme: _base.colorScheme.copyWith(
        primary: secondary1,
        onPrimary: Colors.white,
        background: Colors.white,
      ),
      appBarTheme: _base.appBarTheme.copyWith(
        backgroundColor: Colors.white,
        centerTitle: false,
        systemOverlayStyle: const SystemUiOverlayStyle(
          systemNavigationBarColor: Colors.white,
          statusBarColor: Colors.white,
          statusBarBrightness: Brightness.light,
          statusBarIconBrightness: Brightness.dark,
          systemNavigationBarIconBrightness: Brightness.light,
        ),
        actionsIconTheme: const IconThemeData(size: 12),
        toolbarTextStyle: headline6Style,
        titleTextStyle: headline6Style,
        elevation: 0,
        iconTheme: const IconThemeData(
          color: secondary1,
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          textStyle: body2Style,
        ),
      ),
      tabBarTheme: _base.tabBarTheme.copyWith(
        unselectedLabelColor: Colors.black,
        labelColor: Colors.black,
        labelStyle: body1Style,
      ),
      scaffoldBackgroundColor: Colors.white,
      unselectedWidgetColor: Colors.black,
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      bottomNavigationBarTheme: _base.bottomNavigationBarTheme.copyWith(
        backgroundColor: Colors.white,
        unselectedItemColor: font,
        selectedItemColor: secondary1,
      ),
    );
  }
}
