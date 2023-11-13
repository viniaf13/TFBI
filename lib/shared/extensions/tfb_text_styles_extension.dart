// coverage:ignore-file

import 'package:flutter/material.dart';
import 'package:txfb_insurance_flutter/resources/theme/themes/tfb_typography.dart';

/// Typography extension used with context.
///
/// To access unique Farm Bureau style:
/// context.textStyleOf.tfbTextTheme().bodyMedium;
///
/// To access general text styles to use as-is or copy with:
/// context.textStyleOf.bodyMedium;
///
/// To access and modified a style for a 'One Off' style:
///     TextStyle? copiedStyle = context.textStyleOf.bodyMedium?.copyWith(
///       color: Theme.of(this as BuildContext).primaryColorLight,
///     );
extension TypographyUtils on BuildContext {
  // TfbTypography extension is part of LightThemeData and DarkThemeData
  // so this will not be null. Any new theme supported by app must add the
  // TfbTypography extension.
  TfbTypography get tfbText => Theme.of(this).extension<TfbTypography>()!;
}
