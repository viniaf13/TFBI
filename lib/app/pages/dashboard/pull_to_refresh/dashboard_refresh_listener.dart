import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:txfb_insurance_flutter/app/blocs/claims/claims_bloc.dart';
import 'package:txfb_insurance_flutter/app/cubits/agent_cubit/agent_cubit.dart';
import 'package:txfb_insurance_flutter/app/cubits/contacts/contacts_cubit.dart';
import 'package:txfb_insurance_flutter/app/cubits/member_summary/member_summary_cubit.dart';
import 'package:txfb_insurance_flutter/app/cubits/tfb_single_request_cubit/tfb_single_request_cubit.dart';
import 'package:txfb_insurance_flutter/resources/theme/theme.dart';

class RefreshListener extends StatelessWidget {
  const RefreshListener({
    required this.refreshCompleter,
    super.key,
  });

  final Completer<void> refreshCompleter;

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<MemberSummaryCubit, MemberSummaryState>(
          listener: (context, state) {
            checkIfRefreshComplete(context, refreshCompleter);
          },
        ),
        BlocListener<ClaimsBloc, ClaimsState>(
          listener: (context, state) {
            checkIfRefreshComplete(context, refreshCompleter);
          },
        ),
        BlocListener<AgentCubit, AgentState>(
          listener: (context, state) {
            checkIfRefreshComplete(context, refreshCompleter);
          },
        ),
        BlocListener<ContactsCubit, TfbSingleRequestState>(
          listener: (context, state) {
            checkIfRefreshComplete(context, refreshCompleter);
          },
        ),
      ],
      child: Container(),
    );
  }

  void checkIfRefreshComplete(
    BuildContext context,
    Completer<dynamic> completer,
  ) {
    if (isRefreshComplete(context) && !completer.isCompleted) {
      completer.complete();
    }
  }
}

bool isRefreshComplete(BuildContext context) {
  final memberSummaryState = context.read<MemberSummaryCubit>().state;
  final claimsState = context.read<ClaimsBloc>().state;
  final agentState = context.read<AgentCubit>().state;
  final contactsState = context.read<ContactsCubit>().state;

  return (memberSummaryState is MemberSummaryDetailsSuccess ||
          memberSummaryState is MemberSummaryFailure) &&
      (claimsState is ClaimsFailureState || claimsState is ClaimSuccessState) &&
      (agentState is AgentDetailsSuccess ||
          agentState is AgentFailure ||
          agentState is AgentCodeSuccess) &&
      (contactsState is TfbSingleRequestSuccess ||
          contactsState is TfbSingleRequestFailed);
}
