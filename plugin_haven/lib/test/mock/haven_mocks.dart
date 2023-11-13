//  Copyright © 2022 Bottle Rocket Studios. All rights reserved.

import 'package:flutter/material.dart';
import 'package:plugin_haven/analytics/analytics.dart';
import 'package:plugin_haven/auth/auth.dart';

class ScreenSize {
  static const iPhone12Mini = Size(1080, 2340);
}

class MockAnalyticsEvent extends AnalyticsEvent {
  const MockAnalyticsEvent(this.name);

  @override
  final String name;

  @override
  get properties => [name];

  @override
  Map<String, dynamic> toJson() => {'name': name};
}

class MockAnalyticsProvider extends AnalyticsProvider {
  final List<dynamic> events = [];

  @override
  Future<void> init(config) async {}

  @override
  Future<void> logEvent(AnalyticsEvent event) async {
    events.add(event);
  }

  @override
  Future<void> update(localFields) async {}

  void clear() {
    events.clear();
  }

  @override
  Future<void> disableTracking() async {}
}

class MockUser extends HavenUser {
  MockUser({this.uid = '0', this.value});
  final String uid;
  final dynamic value;

  MockUser copyWith({dynamic value}) {
    return MockUser(uid: uid, value: value ?? this.value);
  }

  @override
  List<Object?> get props => [uid, value];
}

class MockAuthRepository extends AuthRepository<HavenUser> with AuthExtensions {
  MockAuthRepository({HavenUser? user}) {
    _user = user;
  }
  HavenUser? _user;
  bool isInitialized = false;

  @override
  Future<void> cancel() async {}

  @override
  Future<void> init() async {
    isInitialized = true;
  }

  @override
  bool isAuthenticating = false;

  @override
  bool get isSignedIn => _user != null;

  @override
  String? logMessage;

  @override
  Future<HavenUser?> signIn({
    AuthType type = AuthType.standard,
    credentials,
  }) async {
    if (credentials == 'flow') {
      isAuthenticating = true;
      return null;
    } else if (credentials == 'error') {
      error = Exception('error');
    } else {
      isAuthenticating = false;
      _user = MockUser();
    }
    notifyListeners();
    return _user;
  }

  @override
  Future signOut() async {
    _user = null;
    notifyListeners();
  }

  @override
  void updateUser(updatedUser) {
    _user = updatedUser;
    notifyListeners();
  }

  @override
  get user => _user;

  @override
  Future<void> receivedResponse(String response, {credentials}) async {
    logMessage = response;
    notifyListeners();
  }
}
