import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:txfb_insurance_flutter/app/blocs/claims/claims_bloc.dart';
import 'package:txfb_insurance_flutter/app/cubits/member_summary/member_summary_cubit.dart';
import 'package:txfb_insurance_flutter/resources/theme/theme.dart';

class PoliciesSectionMultiBlocBuilder extends StatelessWidget {
  const PoliciesSectionMultiBlocBuilder({
    required this.shouldBuildAll,
    required this.builder,
    super.key,
  });

  final bool Function(
    MemberSummaryState? memberPrevious,
    MemberSummaryState? memberCurrent,
    ClaimsState? claimsPrevious,
    ClaimsState? claimsCurrent,
  ) shouldBuildAll;

  final Widget Function(
    MemberSummaryState memberSummaryState,
    ClaimsState claimsState,
  ) builder;

  @override
  Widget build(BuildContext context) {
    MemberSummaryState? memberPrevious;
    MemberSummaryState? memberCurrent;
    ClaimsState? claimsPrevious;
    ClaimsState? claimsCurrent;

    return BlocBuilder<ClaimsBloc, ClaimsState>(
      buildWhen: (previous, current) {
        claimsPrevious = previous;
        claimsCurrent = current;
        return shouldBuildAll(
          memberPrevious,
          memberCurrent,
          claimsPrevious,
          claimsCurrent,
        );
      },
      builder: (context, stateClaims) =>
          BlocBuilder<MemberSummaryCubit, MemberSummaryState>(
        buildWhen: (previous, current) {
          memberPrevious = previous;
          memberCurrent = current;
          return shouldBuildAll(
            memberPrevious,
            memberCurrent,
            claimsPrevious,
            claimsCurrent,
          );
        },
        builder: (context, state) {
          return builder(
            memberCurrent ?? BlocProvider.of<MemberSummaryCubit>(context).state,
            claimsCurrent ?? BlocProvider.of<ClaimsBloc>(context).state,
          );
        },
      ),
    );
  }
}
