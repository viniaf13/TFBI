import 'package:txfb_insurance_flutter/app/router/tfb_routes.dart';
import 'package:txfb_insurance_flutter/resources/theme/theme.dart';

class TabTapNotifier extends ValueNotifier<TfbAppRoutes?> {
  TabTapNotifier(super.value);

  void update(TfbAppRoutes? route) {
    value = route;
    notifyListeners();
  }
}
