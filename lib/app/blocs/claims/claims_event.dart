part of 'claims_bloc.dart';

abstract class ClaimsEvent extends Equatable {}

class ClaimsInitEvent extends ClaimsEvent {
  ClaimsInitEvent(
    this.memberNumber, {
    this.isPullToRefresh = false,
  });

  final String memberNumber;
  final bool isPullToRefresh;

  @override
  List<Object?> get props => [memberNumber, isPullToRefresh];
}
