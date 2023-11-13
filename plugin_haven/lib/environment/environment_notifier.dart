// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:plugin_haven/app/haven_environment.dart';

/// A change notifier to keep track of the current app environment
///
/// We don't need a full blown bloc here because we only need to keep track of
/// a single value.
class EnvironmentNotifier extends ChangeNotifier {
  late Environment? _environment;

  EnvironmentNotifier({
    required environment,
  }) {
    _environment = environment;
  }

  Environment? get environment => _environment;

  set environment(Environment? environment) {
    _environment = environment;
    notifyListeners();
  }
}
