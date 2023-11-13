//  Copyright © 2022 Bottle Rocket Studios. All rights reserved.

import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';

class AppleNativeWidget extends StatelessWidget {
  AppleNativeWidget({
    Key? key,
    required this.viewType,
    Map<String, dynamic>? params,
  }) : super(key: key) {
    creationParams = params ?? <String, dynamic>{};
    _channel = MethodChannel(viewType);
  }

  late final Map<String, dynamic> creationParams;
  final String viewType;
  late final MethodChannel _channel;

  Future<void> sendMessage(Map<String, dynamic> message) async {
    return _channel.invokeMethod('receiveMessage', message);
  }

  @override
  Widget build(BuildContext context) {
    return UiKitView(
      viewType: viewType,
      layoutDirection: TextDirection.ltr,
      creationParams: creationParams,
      creationParamsCodec: const StandardMessageCodec(),
    );
  }
}
