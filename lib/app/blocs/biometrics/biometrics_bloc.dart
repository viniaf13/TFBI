import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:txfb_insurance_flutter/device/biometrics/tfb_biometrics.dart';
import 'package:txfb_insurance_flutter/domain/models/login/tfb_user.dart';
import 'package:txfb_insurance_flutter/domain/repositories/storage/tfb_user_storage_repository.dart';
import 'package:txfb_insurance_flutter/shared/shared.dart';

part 'biometrics_event.dart';
part 'biometrics_state.dart';

enum BiometricsFailureReason {
  noStoredUser,
  storedUserSessionExpired,
  biometricsNotAvailable,
  biometricAuthenticatedFailed,
  unknown,
}

const String kNoStoredUser =
    'No user is stored in secure storage. Skipping biometrics check.';
const String kExpiredToken = 'Expired Token; User must manually authenticate.';
const String kDisabledBio =
    'Biometrics are not enabled. Skipping biometrics check, even though user is stored.';
const String kUnknownBioError =
    'An unknown error occurred when authenticating with biometrics';

class BiometricsBloc extends Bloc<BiometricsEvent, BiometricsState> {
  BiometricsBloc({
    required this.biometrics,
    required this.userStorageRepository,
  }) : super(BiometricsInitState()) {
    on<BiometricsInitEvent>(_initializeBiometrics);
    on<PromptBiometricsIfAvailable>((event, emit) async {
      emit(BiometricsProcessing());

      try {
        final storedUser = await userStorageRepository.getUser();

        if (storedUser == null) {
          TfbLogger.verbose(kNoStoredUser);
          emit(
            BiometricsFailed(
              BiometricsFailureReason.noStoredUser,
              fromTap: event.fromTap,
            ),
          );
          return;
        }

        if (storedUser.isTokenExpired() == true) {
          TfbLogger.verbose(kExpiredToken);
          emit(
            BiometricsFailed(
              BiometricsFailureReason.storedUserSessionExpired,
              fromTap: event.fromTap,
            ),
          );
          return;
        }

        if (!await biometrics.isBiometricsEnabled()) {
          TfbLogger.verbose(kDisabledBio);
          emit(
            BiometricsFailed(
              BiometricsFailureReason.biometricsNotAvailable,
              fromTap: event.fromTap,
            ),
          );
          return;
        }

        await biometrics.isAuthenticated()
            ? emit(BiometricsSucceeded(storedUser))
            : emit(
                BiometricsFailed(
                  BiometricsFailureReason.biometricAuthenticatedFailed,
                  fromTap: event.fromTap,
                ),
              );
      } catch (e, stack) {
        TfbLogger.verbose(kUnknownBioError, e, stack);
        emit(
          BiometricsFailed(
            BiometricsFailureReason.unknown,
            fromTap: event.fromTap,
          ),
        );
      }
    });

    add(BiometricsInitEvent());
  }

  Future<void> _initializeBiometrics(
    BiometricsInitEvent event,
    Emitter<BiometricsState> emit,
  ) async {
    emit(BiometricsInitializingState());
    final isEnabled = await biometrics.isBiometricsEnabled();
    TfbLogger.verbose(
      '[BiometricsBloc] Biometrics Initializing. IsEnabled: $isEnabled',
    );
    emit(BiometricsReadyState(isEnabled: isEnabled));
  }

  TfbUserStorageRepository<TfbUser> userStorageRepository;
  TfbBiometrics biometrics;
}
