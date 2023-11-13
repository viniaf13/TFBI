import 'package:txfb_insurance_flutter/app/blocs/claims/claims_bloc.dart';
import 'package:txfb_insurance_flutter/texas_farm_bureau_insurance.dart';
import 'package:txfb_insurance_flutter/resources/theme/theme.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PolicyClaimsLabel extends StatelessWidget {
  const PolicyClaimsLabel({
    required this.policySummary,
    super.key,
  });

  final PolicySummary policySummary;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ClaimsBloc, ClaimsState>(
      buildWhen: (previous, current) {
        return !(current is ClaimsProcessingState && current.isPullToRefresh);
      },
      builder: (context, state) {
        if (state is ClaimSuccessState) {
          final openClaimsThisPolicy = state.openClaims(
            policySummary.policyNumber,
          );
          if (openClaimsThisPolicy != 0) {
            return Padding(
              padding: const EdgeInsets.only(top: kSpacingExtraSmall),
              child: Align(
                alignment: Alignment.bottomLeft,
                child: Text(
                  context.getLocalizationOf.thisPolicyHasOpenClaim(
                    openClaimsThisPolicy,
                  ),
                  style: context.tfbText.bodyMediumSmall.copyWith(
                    color: TfbBrandColors.greenHighest,
                  ),
                ),
              ),
            );
          }
          return const SizedBox.shrink();
        }
        return const SizedBox.shrink();
      },
    );
  }
}
