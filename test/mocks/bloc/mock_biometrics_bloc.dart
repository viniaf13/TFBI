import 'package:bloc_test/bloc_test.dart';
import 'package:txfb_insurance_flutter/app/blocs/biometrics/biometrics_bloc.dart';

class MockBiometricsBloc extends MockBloc<BiometricsEvent, BiometricsState>
    implements BiometricsBloc {}
