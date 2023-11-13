//  Copyright © 2022 Bottle Rocket Studios. All rights reserved.

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

class HavenWidgetTester extends StatelessWidget {
  const HavenWidgetTester({
    super.key,
    required this.child,
    this.providers = const [],
    this.blocProviders = const [],
    this.containsScaffold = false,
  });

  final List<Provider> providers;
  final List<BlocProvider> blocProviders;
  final Widget child;
  final bool containsScaffold;

  Widget app() {
    if (!containsScaffold) {
      return MaterialApp(
        home: Scaffold(
          appBar: AppBar(),
          body: child,
        ),
      );
    } else {
      return MaterialApp(
        home: child,
      );
    }
  }

  Widget emptyProviders() {
    return MultiBlocProvider(
      providers: blocProviders,
      child: app(),
    );
  }

  Widget emptyBlocProviders() {
    return MultiProvider(
      providers: providers,
      child: app(),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (providers.isEmpty && blocProviders.isNotEmpty) {
      return emptyProviders();
    } else if (providers.isNotEmpty && blocProviders.isEmpty) {
      return emptyBlocProviders();
    } else if (providers.isNotEmpty && blocProviders.isNotEmpty) {
      return MultiProvider(
        providers: providers,
        child: MultiBlocProvider(
          providers: blocProviders,
          child: app(),
        ),
      );
    } else {
      return app();
    }
  }
}
