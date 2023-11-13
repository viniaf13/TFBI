//  Copyright © 2022 Bottle Rocket Studios. All rights reserved.

import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';

class AndroidNativeWidget extends StatelessWidget {
  AndroidNativeWidget({
    Key? key,
    required this.viewType,
    Map<String, dynamic>? params,
  }) : super(key: key) {
    creationParams = params ?? <String, dynamic>{};
  }

  late final Map<String, dynamic> creationParams;
  final String viewType;
  late final MethodChannel _channel;

  Future<void> sendMessage(Map<String, dynamic> message) async {
    return _channel.invokeMethod('receiveMessage', message);
  }

  @override
  Widget build(BuildContext context) {
    return PlatformViewLink(
      viewType: viewType,
      surfaceFactory: (context, controller) {
        return AndroidViewSurface(
          controller: controller as AndroidViewController,
          gestureRecognizers: const <Factory<OneSequenceGestureRecognizer>>{},
          hitTestBehavior: PlatformViewHitTestBehavior.opaque,
        );
      },
      onCreatePlatformView: (params) {
        _channel = MethodChannel('${viewType}_${params.id}');
        return PlatformViewsService.initSurfaceAndroidView(
          id: params.id,
          viewType: viewType,
          layoutDirection: TextDirection.ltr,
          creationParams: creationParams,
          creationParamsCodec: const StandardMessageCodec(),
        )
          ..addOnPlatformViewCreatedListener(params.onPlatformViewCreated)
          ..create();
      },
    );
  }
}
