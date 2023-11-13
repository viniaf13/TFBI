import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:txfb_insurance_flutter/app/blocs/claims/claims_bloc.dart';
import 'package:txfb_insurance_flutter/app/pages/claims_landing/widgets/claim_details_widgets.dart';
import 'package:txfb_insurance_flutter/resources/theme/theme.dart';
import 'package:txfb_insurance_flutter/texas_farm_bureau_insurance.dart';

class ClaimsStateConsumer extends StatelessWidget {
  const ClaimsStateConsumer({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ClaimsBloc, ClaimsState>(
      listener: (context, state) {
        if (state is ClaimsFailureState) {
          context.showErrorSnackBar(
            text: state.error.toString(),
          );
        }
      },
      builder: (context, state) {
        final String? memberNumber = context.getUserMemberNumber;
        if (state is ClaimsInitState && memberNumber != null) {
          BlocProvider.of<ClaimsBloc>(context).add(
            ClaimsInitEvent(memberNumber),
          );
        }

        if (state is ClaimsProcessingState) {
          return const SizedBox(
            height: 120,
            child: TfbLoadingOverlay(
              backgroundColor: Colors.transparent,
              spinnerColor: TfbBrandColors.blueHigh,
            ),
          );
        }

        if (state is ClaimSuccessState) {
          return (state.fullClaimsList.isEmpty)
              ? const ClaimsEmptyView()
              : ClaimListView(state.fullClaimsList);
        }

        return const SizedBox.shrink();
      },
    );
  }
}
