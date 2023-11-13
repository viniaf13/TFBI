part of '../dashboard.dart';

class ClaimsSection extends DashboardSection {
  const ClaimsSection({required this.sectionTitle, super.key})
      : super(
          title: sectionTitle,
          content: const Padding(
            padding: EdgeInsets.symmetric(horizontal: kSpacingSmall),
            child: ClaimsSectionBody(),
          ),
        );
  final String sectionTitle;
}

class ClaimsSectionBody extends StatelessWidget {
  const ClaimsSectionBody({super.key});

  @override
  Widget build(BuildContext context) {
    final String? memberNumber = context.getUserMemberNumber;
    if (memberNumber != null) {
      BlocProvider.of<ClaimsBloc>(context).add(
        ClaimsInitEvent(memberNumber),
      );
    }

    return BlocConsumer<ClaimsBloc, ClaimsState>(
      listener: (context, state) {
        if (state is ClaimsFailureState) {
          context.showErrorSnackBar(
            text: context.getLocalizationOf.somethingWentWrongOnDashboard,
          );
        }
      },
      buildWhen: (previous, current) {
        return !(current is ClaimsProcessingState && current.isPullToRefresh);
      },
      builder: (context, state) {
        if (state is ClaimSuccessState) {
          final claimsList = state.activeClaims;

          return Container(
            padding: const EdgeInsets.all(kSpacingMedium),
            decoration: ShapeDecoration(
              color: TfbBrandColors.white,
              shape: RoundedRectangleBorder(
                borderRadius: context.radii.defaultRadius,
              ),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (claimsList.isEmpty)
                  Text(
                    context.getLocalizationOf.noActiveClaims,
                    style: context.tfbText.bodyRegularLarge.copyWith(
                      color: TfbBrandColors.blueHighest,
                    ),
                  )
                else
                  ClaimsSectionContent(claimsList: claimsList),
                Padding(
                  padding: const EdgeInsets.only(top: kSpacingMedium),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Expanded(
                        child: TfbFilledButton.secondaryTextButton(
                          onPressed: () {
                            context.navigator.pushFileAClaimPage();
                          },
                          title: context.getLocalizationOf.claimsFileAClaimCTA,
                          style: context.tfbText.bodyMediumSmall.copyWith(
                            color: TfbBrandColors.blueHighest,
                            height: 1,
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: kSpacingSmall,
                      ),
                      Expanded(
                        child: TfbFilledButton.secondaryTextButton(
                          onPressed: () {
                            context.navigator.goToClaimsDetailsPage();
                          },
                          title: context.getLocalizationOf.viewClaimsCTA,
                          style: context.tfbText.bodyMediumSmall.copyWith(
                            color: TfbBrandColors.blueHighest,
                            height: 1,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        } else if (state is ClaimsProcessingState) {
          return const DecoratedContainerWithLoading(containerHeight: 178);
        } else if (state is ClaimsFailureState) {
          return DecoratedFailureContainer(
            errorDescription: context.getLocalizationOf.containerErrorText(
              context.getLocalizationOf.claimsSectionTitle.toLowerCase(),
            ),
          );
        } else {
          return const SizedBox.shrink();
        }
      },
    );
  }
}
