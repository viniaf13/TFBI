//  Copyright © 2021 Bottle Rocket Studios. All rights reserved.

import 'package:flutter/material.dart';

/// A widget that wraps its child for golden file snapshot testing. Per guidance
/// from https://halesworth.org/snapshot-testing-with-flutter-golden
class HavenSnapshotWidget extends StatelessWidget {
  const HavenSnapshotWidget({Key? key, required this.child}) : super(key: key);

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Center(child: RepaintBoundary(child: child));
  }
}
