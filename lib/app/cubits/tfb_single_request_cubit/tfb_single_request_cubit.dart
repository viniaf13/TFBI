import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_gen/gen_l10n/app_localizations_en.dart';
import 'package:txfb_insurance_flutter/domain/models/tfb_request_error.dart';
import 'package:txfb_insurance_flutter/texas_farm_bureau_insurance.dart';

part 'tfb_single_request_state.dart';

/// A generic cubit responsible for making a single API request at a time
/// with success and failure states built in, caching, and response-level error
/// checking.
///
/// The request function can either be defined when the cubit is created using
/// the [requestFunction] parameter on the cubit constructor, or when the request
/// is made using the [fallbackRequest] parameter on the request call. The cubit
/// will always prefer [requestFunction] over [fallbackRequest] if both are
/// provided.
///
/// `shouldCache = true` will cache the response of the API call locally so
/// future requests pull from the cache
///
/// Commonly, TFBI APIs will return a successful response, but with an `errorMessage`
/// property in the response. Provide a `checkErrorInResponse` function to
/// check for an error and move to the `TfbSingleRequestFailed` state if an
/// error is present.
///
/// [TfbSingleRequestCubit] will also drop any new requests if an existing
/// request is ongoing, similar to `bloc_concurrency.droppable`
///
/// See the [ContactsCubit] for a basic usage example.
class TfbSingleRequestCubit<ResponseType extends Object>
    extends Cubit<TfbSingleRequestState> {
  TfbSingleRequestCubit({
    Future<ResponseType> Function()? requestFunction,
    bool shouldCache = false,
    String? Function(ResponseType response)? checkErrorInResponse,
  })  : _requestFunction = requestFunction,
        _getErrorFromResponse = checkErrorInResponse,
        _useCache = shouldCache,
        super(TfbSingleRequestInitial());

  final Future<ResponseType> Function()? _requestFunction;
  final String? Function(ResponseType response)? _getErrorFromResponse;
  final bool _useCache;
  ResponseType? _cachedValue;
  bool _isProcessing = false;

  Future<void> request({
    bool forceRefresh = false,
    bool pullToRefresh = false,
    Future<ResponseType> Function()? fallbackRequest,
  }) async {
    try {
      if (_isProcessing) return;

      _isProcessing = true;

      if (_useCache && _cachedValue != null && !forceRefresh) {
        emit(TfbSingleRequestSuccess<ResponseType>(response: _cachedValue!));
        return;
      }

      emit(TfbSingleRequestProcessing(isPullToRefresh: pullToRefresh));

      ResponseType response;
      if (_requestFunction != null) {
        response = await _requestFunction!();
      } else if (fallbackRequest != null) {
        response = await fallbackRequest();
      } else {
        throw Exception('No request method found for single request cubit');
      }

      final error = _getErrorFromResponse?.call(response);
      final hasError = error != null;

      if (hasError) {
        emit(
          TfbSingleRequestFailed(
            error: TfbRequestError(
              message: error,
            ),
          ),
        );
      } else {
        emit(TfbSingleRequestSuccess<ResponseType>(response: response));
        if (_useCache) {
          _cachedValue = response;
        }
      }
    } catch (e, stack) {
      TfbLogger.verbose(
        'A request failed inside the TfbSingleRequestCubit',
        e,
        stack,
      );
      final error = TfbRequestError.fromObject(
        e,
        stack: stack,
        defaultMessage: AppLocalizationsEn().somethingWentWrongOnDashboard,
      );
      emit(TfbSingleRequestFailed(error: error));
    }

    _isProcessing = false;
  }
}
