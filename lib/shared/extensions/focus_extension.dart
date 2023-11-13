import 'package:txfb_insurance_flutter/resources/theme/theme.dart';

extension FocusExtension on BuildContext {
  void dismissCurrentFocus() {
    final currentFocus = FocusScope.of(this);

    if (!currentFocus.hasPrimaryFocus) {
      currentFocus.unfocus();
    }
  }
}
