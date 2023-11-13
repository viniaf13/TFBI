// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter_test/flutter_test.dart';
import 'package:plugin_haven/environment/environment_notifier.dart';
import 'package:plugin_haven/plugin_haven.dart';

class TestEnvironment extends Environment {
  String name = "test";
  TestEnvironment({
    required this.name,
  });
}

void main() {
  test('Changing the value of an environment notifier should update listeners',
      () {
    var notifier =
        EnvironmentNotifier(environment: TestEnvironment(name: 'before'));
    late TestEnvironment notifiedEnvironment;
    notifier.addListener(() {
      notifiedEnvironment = (notifier.environment as TestEnvironment);
    });
    notifier.environment = TestEnvironment(name: 'after');
    expect(notifiedEnvironment.name, 'after');
  });
}
