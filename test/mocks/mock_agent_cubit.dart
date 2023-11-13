import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mocktail/mocktail.dart';
import 'package:provider/single_child_widget.dart';
import 'package:txfb_insurance_flutter/app/cubits/agent_cubit/agent_cubit.dart';
import 'package:mocktail/mocktail.dart' as mocktail;

class MockAgentCubit extends MockCubit<AgentState> implements AgentCubit {}

class FakeAgentState extends Fake implements AgentState {}

class EmptyAgentCubitProvider extends SingleChildStatelessWidget {
  EmptyAgentCubitProvider({super.key, super.child});

  final MockAgentCubit mockAgentCubit = MockAgentCubit();

  @override
  Widget buildWithChild(BuildContext context, Widget? child) {
    mocktail.when(() => mockAgentCubit.state).thenReturn(AgentInitial());

    mocktail
        .when(() => mockAgentCubit.getAgent(mocktail.any()))
        .thenAnswer((invocation) async {});

    return BlocProvider<AgentCubit>.value(
      value: mockAgentCubit,
      child: child,
    );
  }
}
