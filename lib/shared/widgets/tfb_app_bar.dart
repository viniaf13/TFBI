import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:txfb_insurance_flutter/shared/widgets/cancel_app_bar_action.dart';

class TfbAppBar extends StatelessWidget implements PreferredSizeWidget {
  const TfbAppBar({required this.onCancelPressed, super.key});

  final VoidCallback onCancelPressed;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      scrolledUnderElevation: 0,
      backgroundColor: Colors.transparent,
      automaticallyImplyLeading: false,
      actions: [CancelAppBarAction(onPress: onCancelPressed)],
      systemOverlayStyle: const SystemUiOverlayStyle(
        statusBarIconBrightness: Brightness.dark, // For Android (dark icons)
        statusBarBrightness: Brightness.light,
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
