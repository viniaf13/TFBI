import 'package:txfb_insurance_flutter/data/data.dart';

const tfbRequestErrorMessageDefault =
    'Something went wrong. Please try again later.';

class TfbRequestError implements Exception {
  TfbRequestError({
    this.message = tfbRequestErrorMessageDefault,
    this.stackTrace,
    this.exception,
  });

  factory TfbRequestError.fromObject(
    Object e, {
    StackTrace? stack,
    String? defaultMessage,
  }) {
    final genericMessage = defaultMessage ?? tfbRequestErrorMessageDefault;

    return TfbRequestError(
      message: genericMessage,
      stackTrace: stack,
      exception: e is Exception ? e : null,
    );
  }

  final String message;
  final StackTrace? stackTrace;
  final Exception? exception;

  @override
  String toString() {
    return message;
  }
}
