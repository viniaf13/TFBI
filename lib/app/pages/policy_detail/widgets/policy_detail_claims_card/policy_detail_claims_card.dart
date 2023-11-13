import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:txfb_insurance_flutter/app/blocs/claims/claims_bloc.dart';
import 'package:txfb_insurance_flutter/app/pages/policy_detail/widgets/policy_detail_card.dart';
import 'package:txfb_insurance_flutter/app/pages/policy_detail/widgets/policy_detail_card_title.dart';
import 'package:txfb_insurance_flutter/app/router/tfb_navigator.dart';
import 'package:txfb_insurance_flutter/resources/theme/theme.dart';
import 'package:txfb_insurance_flutter/texas_farm_bureau_insurance.dart';

class PolicyDetailClaimsCard extends StatelessWidget {
  const PolicyDetailClaimsCard({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ClaimsBloc, ClaimsState>(
      builder: (context, state) {
        Widget text = Text(
          context.getLocalizationOf.errorLoadingClaims,
          style: context.tfbText.bodyRegularSmall.copyWith(
            color: TfbBrandColors.redHigh,
          ),
        );
        Widget button = const SizedBox.shrink();

        if (state is ClaimSuccessState) {
          final claimsList = state.activeClaims;
          if (claimsList.isEmpty) {
            text = Text(
              context.getLocalizationOf.noActiveClaims,
              style: context.tfbText.bodyRegularLarge.copyWith(
                color: TfbBrandColors.grayHighest,
              ),
            );
            button = const SizedBox.shrink();
          } else {
            text = Text(
              '${claimsList.length} ${context.getLocalizationOf.activeClaims}',
              style: context.tfbText.subHeaderRegular.copyWith(
                color: TfbBrandColors.greenHighest,
              ),
            );
            button = Padding(
              padding: const EdgeInsets.only(top: kSpacingMedium),
              child: TfbFilledButton.primaryTextButton(
                onPressed: () {
                  context.navigator.goToClaimsDetailsPage();
                },
                title: context.getLocalizationOf.viewClaimsDetailsCTA,
                style: context.tfbText.bodyMediumSmall.copyWith(
                  color: TfbBrandColors.white,
                ),
              ),
            );
          }
        }

        final List<Widget> listWidget = [
          PolicyDetailCardTitle(
            title: context.getLocalizationOf.claimsTitle,
          ),
          text,
          button,
        ];

        if (state is ClaimSuccessState || state is ClaimsFailureState) {
          return PolicyDetailCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: listWidget,
            ),
          );
        }
        return const SizedBox.shrink();
      },
    );
  }
}
