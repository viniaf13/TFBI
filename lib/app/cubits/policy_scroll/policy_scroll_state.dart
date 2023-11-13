part of 'policy_scroll_cubit.dart';

abstract class PolicyScrollState extends Equatable {
  const PolicyScrollState();

  @override
  List<Object> get props => [];
}

class PolicyInitial extends PolicyScrollState {
  const PolicyInitial();
}

class PolicyScrolled extends PolicyScrollState {
  const PolicyScrolled({
    required this.policyVisible,
    required this.policiesLength,
    required this.isScrolled,
  });

  final int policyVisible;
  final int policiesLength;
  final bool isScrolled;

  @override
  List<Object> get props => [
        policyVisible,
        policiesLength,
        isScrolled,
      ];
}
