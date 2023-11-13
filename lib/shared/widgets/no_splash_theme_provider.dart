import 'package:txfb_insurance_flutter/resources/theme/theme.dart';

class NoSplashThemeProvider extends StatelessWidget {
  const NoSplashThemeProvider({required this.child, super.key});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
      ),
      child: child,
    );
  }
}
