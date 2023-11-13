import 'package:txfb_insurance_flutter/resources/theme/theme.dart';

/// Add a separator between all elements in a list
///
/// Use the [includeStart] and [includeEnd] parameters to add the separator
/// at the beginning or end of the list.
extension Separated<T extends Widget> on List<T> {
  List<Widget> separated(
    Widget separator, {
    bool includeStart = false,
    bool includeEnd = false,
  }) =>
      [
        for (int i = 0; i < length; i++) ...[
          if (elementAt(i) == first && includeStart) separator,
          elementAt(i),
          if (elementAt(i) != last) separator else if (includeEnd) separator,
        ],
      ];
}
