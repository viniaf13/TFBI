import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:plugin_haven/haven.dart';

import 'package:txfb_insurance_flutter/app/cubits/agent_cubit/agent_cubit.dart';
import 'package:txfb_insurance_flutter/shared/widgets/list_tile_with_arrow.dart';
import 'package:txfb_insurance_flutter/shared/widgets/decorated_container_with_loading.dart';
import 'package:txfb_insurance_flutter/shared/widgets/decorated_failure_container.dart';
import 'package:txfb_insurance_flutter/resources/theme/theme.dart';
import 'package:txfb_insurance_flutter/shared/shared.dart';
import 'package:url_launcher/url_launcher.dart';

class EmailUsCTA extends StatelessWidget {
  const EmailUsCTA({
    required this.emailAddress,
    super.key,
  });

  final String? emailAddress;

  Future<void> _launchEmail(String? emailAddress) async {
    final Uri url = Uri(
      scheme: 'mailto',
      path: emailAddress,
    );
    await canLaunchUrl(url)
        ? await launchUrl(url)
        : throw 'Could not launch $url';
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AgentCubit, AgentState>(
      listener: (context, state) {
        if (state is AgentFailure) {
          context.showErrorSnackBar(
            text: context.getLocalizationOf.somethingWentWrong,
          );
        }
      },
      builder: (context, state) {
        if (state is AgentInitial) {
          context.read<AgentCubit>().getAgent(context.getUserMemberNumber);
        }
        if (state is AgentDetailsSuccess) {
          final agentDetails = state.agentDetails;
          return ListTileWithArrow(
            title: context.getLocalizationOf.emailUsCTA,
            onPress: () async => _launchEmail(
              agentDetails.emailAddress.isNullOrEmpty
                  ? kGeneralCustomerServiceEmail
                  : agentDetails.emailAddress,
            ),
          );
        } else if (state is AgentProcessing) {
          return const DecoratedContainerWithLoading(containerHeight: 120);
        } else if (state is AgentCodeSuccess) {
          return ListTileWithArrow(
            title: context.getLocalizationOf.emailUsCTA,
            onPress: () async => _launchEmail(
              kGeneralCustomerServiceEmail,
            ),
          );
        } else if (state is AgentFailure) {
          return DecoratedFailureContainer(
            errorDescription: context.getLocalizationOf.containerErrorText(
              context.getLocalizationOf.agent.toLowerCase(),
            ),
          );
        }
        return const SizedBox.shrink();
      },
    );
  }
}
