import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:txfb_insurance_flutter/texas_farm_bureau_insurance.dart';

part 'policy_scroll_state.dart';

class PolicyScrollCubit extends Cubit<PolicyScrollState> {
  PolicyScrollCubit() : super(const PolicyInitial());

  void scrollToPolicy(int policyIndex, int policiesLength) {
    emit(
      PolicyScrolled(
        policyVisible: policyIndex,
        policiesLength: policiesLength,
        isScrolled: policyIndex != 1,
      ),
    );
  }

  void resetPolicyScroll() {
    emit(
      const PolicyInitial(),
    );
  }
}
