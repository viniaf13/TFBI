import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:plugin_haven/util/extensions.dart';
import 'package:txfb_insurance_flutter/app/cubits/agent_cubit/agent_cubit.dart';
import 'package:txfb_insurance_flutter/device/device.dart';
import 'package:txfb_insurance_flutter/resources/theme/theme.dart';
import 'package:txfb_insurance_flutter/shared/shared.dart';
import 'package:txfb_insurance_flutter/shared/widgets/agent_card/agent_contact_info.dart';
import 'package:txfb_insurance_flutter/shared/widgets/decorated_container_with_loading.dart';
import 'package:txfb_insurance_flutter/shared/widgets/decorated_failure_container.dart';
import 'package:txfb_insurance_flutter/shared/widgets/expandable_card/expandable_card.dart';

class AgentCard extends StatelessWidget {
  const AgentCard({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AgentCubit, AgentState>(
      buildWhen: (previous, current) {
        return !(current is AgentProcessing && current.isPullToRefresh);
      },
      listener: (context, state) {
        if (state is AgentFailure) {
          context.showErrorSnackBar(
            text: context.getLocalizationOf.somethingWentWrongOnDashboard,
          );
        }
      },
      builder: (context, state) {
        if (state is AgentDetailsSuccess) {
          final agentDetails = state.agentDetails;
          return ExpandableCard(
            headerContent: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      agentDetails.firstAndLastName,
                      style: context.tfbText.subHeaderRegular.copyWith(
                        color: TfbBrandColors.blueHighest,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        top: kSpacingExtraSmall,
                      ),
                      child: Text(
                        agentDetails.getTitleDesignation,
                        style: context.tfbText.bodyRegularLarge.copyWith(
                          color: TfbBrandColors.blueHighest,
                        ),
                      ),
                    ),
                  ],
                ),
                CachedNetworkImage(
                  imageUrl:
                      '${context.getEnvironment<TfbEnvironment>().websiteUrl}'
                      '${agentDetails.photo}',
                  imageBuilder: (context, imageProvider) => CircleAvatar(
                    radius: 26,
                    backgroundColor: LightColors.lightBlueIcon,
                    child: CircleAvatar(
                      radius: 24,
                      backgroundColor: TfbBrandColors.white,
                      backgroundImage: imageProvider,
                    ),
                  ),
                  errorWidget: (context, url, error) => CircleAvatar(
                    radius: 26,
                    backgroundColor: TfbBrandColors.white,
                    backgroundImage: AssetImage(
                      TfbAssetStrings.avatarIcon,
                    ),
                  ),
                ),
              ],
            ),
            expandableSectionLabel: Text(
              context.getLocalizationOf.contactInfoSupportSection,
              style: context.tfbText.bodyMediumSmall.copyWith(
                color: TfbBrandColors.blueHighest,
              ),
            ),
            expandableSectionContent: [
              AgentContactInfo(agentDetails: agentDetails),
            ],
          );
        } else if (state is AgentProcessing) {
          return const DecoratedContainerWithLoading(containerHeight: 120);
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
