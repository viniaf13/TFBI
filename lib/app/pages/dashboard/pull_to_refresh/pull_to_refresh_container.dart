import 'dart:async';

import 'package:custom_refresh_indicator/custom_refresh_indicator.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:txfb_insurance_flutter/app/blocs/claims/claims_bloc.dart';
import 'package:txfb_insurance_flutter/app/cubits/agent_cubit/agent_cubit.dart';
import 'package:txfb_insurance_flutter/app/cubits/contacts/contacts_cubit.dart';
import 'package:txfb_insurance_flutter/app/cubits/member_summary/member_summary_cubit.dart';
import 'package:txfb_insurance_flutter/app/pages/dashboard/pull_to_refresh/dashboard_refresh_listener.dart';
import 'package:txfb_insurance_flutter/app/pages/dashboard/pull_to_refresh/pull_to_refresh_icon.dart';
import 'package:txfb_insurance_flutter/data/data.dart';
import 'package:txfb_insurance_flutter/resources/theme/theme.dart';
import 'package:txfb_insurance_flutter/shared/extensions/context_extension.dart';
import 'package:txfb_insurance_flutter/shared/widgets/has_scrolled_listener.dart';

class PullToRefreshContainer extends StatefulWidget {
  const PullToRefreshContainer({
    required this.child,
    super.key,
  });

  final Widget child;

  @override
  State<PullToRefreshContainer> createState() => _PullToRefreshContainerState();
}

class _PullToRefreshContainerState extends State<PullToRefreshContainer> {
  Completer<void> refreshCompleter = Completer();
  final hasScrolledNotifier = ValueNotifier(false);

  @override
  Widget build(BuildContext context) {
    return CustomRefreshIndicator(
      offsetToArmed: pullToRefreshIconHeight,
      builder: (
        BuildContext context,
        Widget child,
        IndicatorController controller,
      ) {
        return Stack(
          children: <Widget>[
            ChangeNotifierProvider<IndicatorController>.value(
              value: controller,
              child: AnimatedBuilder(
                builder: (context, _) {
                  return child;
                },
                animation: controller,
              ),
            ),
            RefreshListener(
              refreshCompleter: refreshCompleter,
            ),
            ValueListenableBuilder(
              valueListenable: hasScrolledNotifier,
              builder: (_, hasScrolled, __) {
                return PullToRefreshIcon(
                  controller: controller,
                  shouldShowShadow: hasScrolled,
                );
              },
            ),
          ],
        );
      },
      onRefresh: () async {
        final memberSummaryCubit = BlocProvider.of<MemberSummaryCubit>(context);
        final agentCubit = BlocProvider.of<AgentCubit>(context);
        final claimsBloc = BlocProvider.of<ClaimsBloc>(context);
        final contactsCubit = BlocProvider.of<ContactsCubit>(context);

        final noRefreshIsActive = isRefreshComplete(context);

        // If there is an active refresh already occurring, then don't make the
        // API calls to refresh the data again
        //
        // But DO set the completer to a new instance so the Pull to Refresh
        // icon appears and the user knows the app is loading their data
        if (noRefreshIsActive) {
          final userMemberNumber = context.getUserMemberNumber!;

          memberSummaryCubit.getMemberSummary(isPullToRefresh: true);
          contactsCubit.request(pullToRefresh: true);
          agentCubit.getAgent(userMemberNumber, isPullToRefresh: true);
          claimsBloc.add(
            ClaimsInitEvent(
              userMemberNumber,
              isPullToRefresh: true,
            ),
          );
        }

        refreshCompleter = Completer();
        return refreshCompleter.future;
      },
      child: HasScrolledListener(
        valueNotifier: hasScrolledNotifier,
        child: widget.child,
      ),
    );
  }
}
