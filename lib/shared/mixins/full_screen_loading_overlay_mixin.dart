import 'package:flutter/material.dart';
import 'package:txfb_insurance_flutter/shared/widgets/tfb_loading_overlay.dart';

mixin FullScreenLoadingOverlay<T extends StatefulWidget> on State<T> {
  OverlayEntry? overlayEntry;
  ModalRoute<dynamic>? _route;

  void hideFullscreenLoadingOverlay() {
    overlayEntry?.remove();
    overlayEntry = null;

    _allowPop();
  }

  void showFullscreenLoadingOverlay({
    BuildContext? context,
    bool preventPop = false,
  }) {
    final overlayContext = context ?? this.context;

    hideFullscreenLoadingOverlay();

    overlayEntry = OverlayEntry(
      builder: (context) => const TfbLoadingOverlay(),
    );

    Overlay.of(overlayContext).insert(overlayEntry!);

    if (preventPop) {
      _preventPop(overlayContext);
    }
  }

  Future<bool> _dontPop() async => false;

  void _preventPop(BuildContext context) {
    if (!context.mounted) return;
    _route = ModalRoute.of(context);
    _route?.addScopedWillPopCallback(_dontPop);
  }

  void _allowPop() {
    _route?.removeScopedWillPopCallback(_dontPop);
  }

  @override
  void dispose() {
    _allowPop();
    super.dispose();
  }
}
