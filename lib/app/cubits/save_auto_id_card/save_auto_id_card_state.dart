part of 'save_auto_id_card_cubit.dart';

abstract class SaveAutoIdCardState extends Equatable {
  const SaveAutoIdCardState({required this.showSnackbar});

  final bool showSnackbar;

  @override
  List<Object> get props => [showSnackbar];
}

class SaveAutoIdCardInitial extends SaveAutoIdCardState {
  const SaveAutoIdCardInitial({super.showSnackbar = false});
}

class SaveAutoIdCardProcessing extends SaveAutoIdCardState {
  const SaveAutoIdCardProcessing({super.showSnackbar = false});
}

class SaveAutoIdCardSuccess extends SaveAutoIdCardState {
  const SaveAutoIdCardSuccess({
    required this.idCardMetadata,
    super.showSnackbar = false,
  });

  final TfbAutoPolicyDocumentMetadata idCardMetadata;
}

class SaveAutoIdCardUncached extends SaveAutoIdCardState {
  const SaveAutoIdCardUncached({required super.showSnackbar});
}

class SaveAutoIdCardFailure extends SaveAutoIdCardState {
  const SaveAutoIdCardFailure({
    this.idCardMetadata,
    this.error,
    super.showSnackbar = true,
  });

  final Exception? error;
  final TfbAutoPolicyDocumentMetadata? idCardMetadata;

  @override
  List<Object> get props => [showSnackbar];
}
