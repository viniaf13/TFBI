//  Copyright © 2022 Bottle Rocket Studios. All rights reserved.

import 'package:flutter/material.dart';

class PlaceholderScreen extends StatelessWidget {
  const PlaceholderScreen({Key? key, this.title = 'TO DO'}) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: const Placeholder(),
    );
  }
}
