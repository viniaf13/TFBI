import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:plugin_haven/network/network_service/haven_proxy_service.dart';
import 'package:txfb_insurance_flutter/app/cubits/file_a_claim_form/vehicle_model/vehicle_model_cubit.dart';
import 'package:txfb_insurance_flutter/app/cubits/file_a_claim_form/vehicle_model/vehicle_model_state.dart';
import 'package:txfb_insurance_flutter/device/environment/tfb_environment.dart';
import 'package:txfb_insurance_flutter/domain/clients/document_information_client.dart';
import 'package:txfb_insurance_flutter/domain/clients/file_a_claim_client.dart';
import 'package:txfb_insurance_flutter/domain/models/claims/file_a_claim/auto_claim/submit_claim_vehicle_model.dart';
import 'package:txfb_insurance_flutter/domain/repositories/tfb_file_claim_repository.dart';
import 'package:txfb_insurance_flutter/domain/repositories/tfb_policy_lookup_repository.dart';
import 'package:txfb_insurance_flutter/resources/theme/colors/tfb_brand_colors.dart';
import 'package:txfb_insurance_flutter/shared/enum/form_validation_type.dart';
import 'package:txfb_insurance_flutter/shared/shared.dart';
import 'package:txfb_insurance_flutter/shared/widgets/bottom_sheet_selector.dart';
import 'package:txfb_insurance_flutter/shared/widgets/validating_form_field.dart';
import 'package:plugin_haven/plugin_haven.dart';

class VehicleModelSelector extends StatelessWidget {
  const VehicleModelSelector({
    required this.onVehicleMakeSelected,
    required this.selectedValueController,
    required this.isEnabled,
    required this.modelRequest,
    super.key,
  });

  final ValueChanged<VehicleModelResponse?> onVehicleMakeSelected;
  final TextEditingController selectedValueController;
  final bool isEnabled;
  final VehicleModelRequest modelRequest;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: context.getLocalizationOf.selectionField(
        context.getLocalizationOf.vehicleMakeLabel,
      ),
      child: _VehicleMakeBottomSheetSelector(
        onChanged: (value) =>
            onVehicleMakeSelected(value as VehicleModelResponse),
        selectedValueController: selectedValueController,
        isEnabled: isEnabled,
        modelRequest: modelRequest,
      ),
    );
  }
}

class _VehicleMakeBottomSheetSelector extends StatefulWidget {
  const _VehicleMakeBottomSheetSelector({
    required this.selectedValueController,
    required this.onChanged,
    required this.isEnabled,
    required this.modelRequest,
  });

  final void Function(dynamic) onChanged;
  final TextEditingController selectedValueController;
  final bool isEnabled;
  final VehicleModelRequest modelRequest;

  @override
  State<_VehicleMakeBottomSheetSelector> createState() =>
      _BottomSheetSelectorState();
}

class _BottomSheetSelectorState extends State<_VehicleMakeBottomSheetSelector> {
  @override
  Widget build(BuildContext context) {
    final userAccessToken = context.listenToAccessToken();
    final baseUrl = context.getEnvironment<TfbEnvironment>().apiUrl.toString();

    return StatefulBuilder(
      builder: (context, setState) {
        return Semantics(
          label: context.getLocalizationOf.vehicleModelLabel,
          child: ValidatingFormField(
            labelText: context.getLocalizationOf.vehicleModelLabel,
            type: ValidationType.selection,
            readOnly: true,
            isRequired: true,
            isEnabled: widget.isEnabled,
            controller: widget.selectedValueController,
            style: context.tfbText.bodyLightLarge
                .copyWith(color: TfbBrandColors.blueHighest),
            suffixIcon: Image.asset(
              TfbAssetStrings.chevronRightIcon,
              width: 24,
              height: 24,
              color: widget.isEnabled
                  ? TfbBrandColors.blueHighest
                  : TfbBrandColors.grayHigh,
            ),
            suffixIconConstraints: const BoxConstraints(
              maxHeight: 24,
              maxWidth: 24,
            ),
            onChanged: widget.onChanged,
            onTap: () {
              /// TODO: Replace 'showModalBottomSheet' with a modal that is
              /// compatible with 'GoRouter'.
              showModalBottomSheet<void>(
                context: context,
                isScrollControlled: true,
                backgroundColor: Colors.transparent,
                builder: (context) {
                  return Wrap(
                    children: [
                      GestureDetector(
                        onTap: () => Navigator.of(context).pop(),
                        child: GestureDetector(
                          onTap: () {},
                          child: DecoratedBox(
                            decoration: BoxDecoration(
                              color: TfbBrandColors.white,
                              borderRadius: context.radii.defaultRadiusTop,
                            ),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(
                                        left: kSpacingMedium,
                                      ),
                                      child: Text(
                                        context.getLocalizationOf
                                            .vehicleModelLabel,
                                        style: context.tfbText.bodyLightLarge
                                            .copyWith(
                                          color: TfbBrandColors.blueHighest,
                                          height: 1,
                                        ),
                                      ),
                                    ),
                                    IconButton(
                                      onPressed: () => Navigator.pop(context),
                                      alignment: Alignment.centerRight,
                                      icon: Image.asset(
                                        TfbAssetStrings.closeIcon,
                                        height: 20,
                                      ),
                                    ),
                                  ],
                                ),
                                const Padding(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: kSpacingMedium,
                                  ),
                                  child: Divider(
                                    height: 1,
                                  ),
                                ),
                                BlocProvider(
                                  create: (context) => VehicleModelCubit(
                                    fileClaimRepository: TfbFileClaimRepository(
                                      fileClaimClient: FileAClaimClient(
                                        baseUrl: baseUrl,
                                        dio: createAuthenticatedDio(
                                          userAccessToken!,
                                        ),
                                      ),
                                      documentClient: context
                                          .read<TfbDocumentInformationClient>(),
                                      policyLookUp: context
                                          .read<TfbPolicyLookupRepository>(),
                                    ),
                                  ),
                                  child: BlocBuilder<VehicleModelCubit,
                                      VehicleModelState>(
                                    builder: (context, state) {
                                      if (state is VehicleModelInitial) {
                                        context
                                            .read<VehicleModelCubit>()
                                            .getVehicleModels(
                                              widget.modelRequest,
                                            );
                                        return const SizedBox(
                                          height: 150,
                                          child: TfbLoadingOverlay(
                                            backgroundColor:
                                                TfbBrandColors.transparent,
                                            spinnerColor:
                                                TfbBrandColors.blueHigh,
                                          ),
                                        );
                                      }
                                      if (state is VehicleModelProcessing) {
                                        return const SizedBox(
                                          height: 150,
                                          child: TfbLoadingOverlay(),
                                        );
                                      }

                                      if (state is VehicleModelFailure) {
                                        return SizedBox(
                                          height: 150,
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(
                                              horizontal: kSpacingMedium,
                                              vertical: kSpacingMedium,
                                            ),
                                            child: Text(
                                              context.getLocalizationOf
                                                  .somethingWentWrong,
                                              style: context
                                                  .tfbText.bodyMediumSmall
                                                  .copyWith(
                                                color: TfbBrandColors.redHigh,
                                              ),
                                            ),
                                          ),
                                        );
                                      }

                                      if (state is VehicleModelSuccess) {
                                        return Container(
                                          constraints: BoxConstraints(
                                            maxHeight: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.45,
                                          ),
                                          child: ListView.builder(
                                            shrinkWrap: true,
                                            itemCount: state.models.length,
                                            padding: EdgeInsets.zero,
                                            itemBuilder: (_, index) {
                                              if (state.models[index]!.value !=
                                                  null) {
                                                return BottomSheetSelectorOptionButton(
                                                  label: state
                                                      .models[index]!.value!,
                                                  value: state
                                                      .models[index]!.value!,
                                                  onPress: () {
                                                    widget.selectedValueController
                                                            .text =
                                                        state.models[index]!
                                                            .value!;
                                                    widget.onChanged(
                                                      state.models[index],
                                                    );
                                                    Navigator.pop(context);
                                                  },
                                                );
                                              }
                                              return null;
                                            },
                                          ),
                                        );
                                      }

                                      return const SizedBox(
                                        height: 0,
                                      );
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  );
                },
              );
            },
          ),
        );
      },
    );
  }

  static Dio createAuthenticatedDio(String accessToken) {
    final sharedAuthenticatedDio = Dio(
      BaseOptions(
        headers: {'Authorization': 'Bearer $accessToken'},
      ),
    );

    if (!HavenProxyService.proxy.isNullOrEmpty) {
      HavenProxyService.addProxyIfSet(sharedAuthenticatedDio);
    }

    return sharedAuthenticatedDio;
  }
}
