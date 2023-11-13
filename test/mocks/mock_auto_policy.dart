import 'package:bloc_test/bloc_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:txfb_insurance_flutter/app/cubits/auto_policy/auto_policy_cubit.dart';
import 'package:txfb_insurance_flutter/domain/domain.dart';

class MockAutoPolicyCubit extends MockCubit<AutoPolicyState>
    implements AutoPolicyCubit {}

class FakeAutoPolicyState extends Fake implements AutoPolicyState {}

class MockAutoPolicyDetail extends Mock implements AutoPolicyDetail {}
