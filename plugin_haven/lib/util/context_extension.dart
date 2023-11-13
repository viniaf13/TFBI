//  Copyright © 2022 Bottle Rocket Studios. All rights reserved.

import 'package:flutter/material.dart';
import 'package:plugin_haven/app/app.dart';
import 'package:plugin_haven/environment/environment_notifier.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

extension ContextExtension on BuildContext {
  void unwindNavigationStack({
    bool Function(Route<dynamic>)? popUntilCondition,
  }) {
    Navigator.of(this).popUntil((route) {
      return popUntilCondition?.call(route) ?? route.settings.name == null;
    });
  }

  Future<void> openUrl({required String url, Widget? alert}) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else if (alert != null) {
      await showDialog(context: this, builder: (context) => alert);
    }
  }

  Future<void> launchURL(
    String scheme,
    String? path,
    Widget alert, {
    String? host,
    String? query,
  }) async {
    if (path != null) {
      final params = Uri(
        scheme: scheme,
        host: host,
        path: path,
        query: query,
      );

      if (await canLaunchUrl(params)) {
        await launchUrl(params);
      } else {
        await showDialog(context: this, builder: (context) => alert);
      }
    }
  }

  T getEnvironment<T extends Environment?>() {
    var envType = Provider.of<EnvironmentNotifier>(this).environment as T;
    return envType;
  }

  set environment(Environment? environment) {
    var currentEnvironment = read<EnvironmentNotifier>().environment;
    if (environment == currentEnvironment) return;

    Provider.of<EnvironmentNotifier>(this, listen: false).environment =
        environment;
  }
}
