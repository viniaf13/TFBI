part of 'delete_account_cubit.dart';

abstract class DeleteAccountState extends Equatable {
  const DeleteAccountState();

  @override
  List<Object> get props => [];
}

class DeleteAccountInitial extends DeleteAccountState {}

class DeleteAccountProcessing extends DeleteAccountState {}

class DeleteAccountSuccess extends DeleteAccountState {}

class DeleteAccountFailed extends DeleteAccountState {
  const DeleteAccountFailed({required this.error});

  final TfbRequestError error;

  @override
  List<Object> get props => [error];
}
