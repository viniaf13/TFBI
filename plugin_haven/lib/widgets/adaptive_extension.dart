//  Copyright © 2022 Bottle Rocket Studios. All rights reserved.

import 'dart:io';

import 'package:flutter/widgets.dart';

extension Adaptive on Widget {
  bool isHandset(BuildContext context) =>
      (Platform.isIOS || Platform.isAndroid) &&
      MediaQuery.of(context).size.width < 700;
}
