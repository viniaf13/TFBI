import 'package:txfb_insurance_flutter/app/cubits/policy_scroll/policy_scroll_cubit.dart';
import 'package:txfb_insurance_flutter/resources/theme/theme.dart';
import 'package:txfb_insurance_flutter/shared/shared.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PolicySectionCounter extends StatelessWidget {
  const PolicySectionCounter({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PolicyScrollCubit, PolicyScrollState>(
      builder: (context, state) {
        if (state is PolicyScrolled && state.policiesLength != 0) {
          return Padding(
            padding: const EdgeInsets.only(
              right: kSpacingMedium,
              bottom: kSpacingSmall,
            ),
            child: Semantics(
              label: '${state.policyVisible} of ${state.policiesLength}',
              child: Text(
                '${state.policyVisible}/${state.policiesLength}',
                style: context.tfbText.header3
                    .copyWith(color: TfbBrandColors.white),
              ),
            ),
          );
        }
        return const SizedBox.shrink();
      },
    );
  }
}
