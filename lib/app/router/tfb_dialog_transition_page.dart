// coverage:ignore-file
import 'package:txfb_insurance_flutter/resources/theme/theme.dart';

class TfbDialogTransitionPage<T> extends Page<T> {
  const TfbDialogTransitionPage({required this.child, super.key});

  final Widget child;

  @override
  Route<T> createRoute(BuildContext context) => DialogRoute<T>(
        context: context,
        settings: this,
        barrierDismissible: false,
        builder: (context) => child,
      );
}
