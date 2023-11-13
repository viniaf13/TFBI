import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:txfb_insurance_flutter/app/cubits/policy_scroll/policy_scroll_cubit.dart';

class MockPolicyScrollCubit extends MockCubit<PolicyScrollState>
    implements PolicyScrollCubit {}

class FakePolicyScrollState extends Fake implements PolicyScrollState {}
