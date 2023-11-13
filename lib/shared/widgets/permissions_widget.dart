import 'package:permission_handler/permission_handler.dart';
import 'package:txfb_insurance_flutter/resources/theme/theme.dart';

// Wraps package specific types
enum AppPermission {
  appTrackingTransparency;

  // Access the underlying package implementation
  Permission permission() {
    switch (this) {
      case appTrackingTransparency:
        return Permission.appTrackingTransparency;
    }
  }
}

// Contains minimum functionality for user tracking permission on iOS.
// This may need additional considerations for different permission types.
class PermissionsWidget extends StatefulWidget {
  const PermissionsWidget(this.type, {this.onRequestComplete, super.key});

  final AppPermission type;
  final void Function(AppPermission, PermissionStatus)? onRequestComplete;

  @override
  State<StatefulWidget> createState() => _PermissionsWidgetState();
}

class _PermissionsWidgetState extends State<PermissionsWidget> {
  final ValueNotifier<PermissionStatus?> _permissionStatus =
      ValueNotifier(null);

  bool get hasNotPromptedUser =>
      _permissionStatus.value == null ||
      _permissionStatus.value == PermissionStatus.denied;

  // Due to widget build timing, the native system prompt may not have
  // displayed and we get a status instead of a request result. Repeat the
  // attempt until system prompt has been presented to user.
  Future<void> _requestPermission() async {
    final currentStatus = _permissionStatus.value;
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      _permissionStatus.value = await widget.type.permission().request();
      if (currentStatus == PermissionStatus.denied && hasNotPromptedUser) {
        _requestPermission();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: _permissionStatus,
      builder: (context, _) {
        if (hasNotPromptedUser) {
          _requestPermission();
        } else if (_permissionStatus.value != null) {
          // TFBI-194: Analytics
          // When analytics are implemented, enable user specific tracking
          // options here. Otherwise, default should be do not set user data.
          widget.onRequestComplete?.call(widget.type, _permissionStatus.value!);
        }
        return const SizedBox.shrink();
      },
    );
  }
}
