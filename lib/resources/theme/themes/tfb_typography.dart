import 'package:txfb_insurance_flutter/resources/theme/theme.dart';

@immutable
class TfbTypography extends ThemeExtension<TfbTypography> {
  const TfbTypography({this.color = TfbBrandColors.grayHighest});

  static const String brandFontFamily = 'libre_franklin';

  final Color? color;

  TextStyle get header1 => TextStyle(
        fontFamily: brandFontFamily,
        fontSize: 40,
        height: 1.15,
        fontWeight: FontWeight.w200,
        color: color,
      );

  TextStyle get header2 => TextStyle(
        fontFamily: brandFontFamily,
        fontSize: 32,
        height: 1.15,
        fontWeight: FontWeight.w200,
        color: color,
      );

  TextStyle get header3 => TextStyle(
        fontFamily: brandFontFamily,
        fontSize: 24,
        height: 1.15,
        fontWeight: FontWeight.w200,
        color: color,
      );

  TextStyle get subHeaderBold => TextStyle(
        fontFamily: brandFontFamily,
        fontSize: 18,
        height: 1.15,
        fontWeight: FontWeight.w700,
        color: color,
      );

  TextStyle get subHeaderRegular => TextStyle(
        fontFamily: brandFontFamily,
        fontSize: 18,
        height: 1.15,
        fontWeight: FontWeight.w400,
        color: color,
      );

  TextStyle get subHeaderLight => TextStyle(
        fontFamily: brandFontFamily,
        fontSize: 18,
        height: 1.15,
        fontWeight: FontWeight.w300,
        color: color,
      );

  TextStyle get bodyBoldLarge => TextStyle(
        fontFamily: brandFontFamily,
        fontSize: 16,
        height: 1.5,
        fontWeight: FontWeight.w700,
        color: color,
      );

  TextStyle get bodyBoldSmall => TextStyle(
        fontFamily: brandFontFamily,
        fontSize: 14,
        height: 1.5,
        fontWeight: FontWeight.w700,
        color: color,
      );

  TextStyle get bodyMediumLarge => TextStyle(
        fontFamily: brandFontFamily,
        fontSize: 16,
        height: 1.5,
        fontWeight: FontWeight.w500,
        color: color,
      );

  TextStyle get bodyMediumSmall => TextStyle(
        fontFamily: brandFontFamily,
        fontSize: 14,
        height: 1.5,
        fontWeight: FontWeight.w500,
        color: color,
      );

  TextStyle get bodyRegularLarge => TextStyle(
        fontFamily: brandFontFamily,
        fontSize: 16,
        height: 1.5,
        fontWeight: FontWeight.w400,
        color: color,
      );

  TextStyle get bodyRegularSmall => TextStyle(
        fontFamily: brandFontFamily,
        fontSize: 14,
        height: 1.5,
        fontWeight: FontWeight.w400,
        color: color,
      );

  TextStyle get bodyLightLarge => TextStyle(
        fontFamily: brandFontFamily,
        fontSize: 16,
        height: 1.5,
        fontWeight: FontWeight.w300,
        color: color,
      );

  TextStyle get bodyLightSmall => TextStyle(
        fontFamily: brandFontFamily,
        fontSize: 14,
        height: 1.5,
        fontWeight: FontWeight.w300,
        color: color,
      );

  TextStyle get captionBold => TextStyle(
        fontFamily: brandFontFamily,
        fontSize: 12,
        height: 1.15,
        fontWeight: FontWeight.w700,
        color: color,
      );

  TextStyle get caption => TextStyle(
        fontFamily: brandFontFamily,
        fontSize: 12,
        height: 1.15,
        fontWeight: FontWeight.w400,
        color: color,
      );

  TextStyle get tabBar => TextStyle(
        fontFamily: brandFontFamily,
        fontSize: 10,
        height: 1.15,
        fontWeight: FontWeight.w500,
        color: color,
      );

  @override
  ThemeExtension<TfbTypography> copyWith({
    Color color = TfbBrandColors.grayHighest,
  }) {
    return TfbTypography(color: color);
  }

  @override
  ThemeExtension<TfbTypography> lerp(
    covariant ThemeExtension<TfbTypography>? other,
    double t,
  ) {
    if (other is! TfbTypography) {
      return this;
    }
    return TfbTypography(color: Color.lerp(color, other.color, t));
  }
}
