import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:plugin_haven/network/network_service/haven_proxy_service.dart';
import 'package:plugin_haven/plugin_haven.dart';
import 'package:txfb_insurance_flutter/app/cubits/file_a_claim_form/vehicle_make/vehicle_make_cubit.dart';
import 'package:txfb_insurance_flutter/app/cubits/file_a_claim_form/vehicle_make/vehicle_make_state.dart';
import 'package:txfb_insurance_flutter/device/environment/tfb_environment.dart';
import 'package:txfb_insurance_flutter/domain/clients/document_information_client.dart';
import 'package:txfb_insurance_flutter/domain/clients/file_a_claim_client.dart';
import 'package:txfb_insurance_flutter/domain/models/claims/file_a_claim/auto_claim/submit_claim_vehicle_make.dart';
import 'package:txfb_insurance_flutter/domain/repositories/tfb_file_claim_repository.dart';
import 'package:txfb_insurance_flutter/domain/repositories/tfb_policy_lookup_repository.dart';
import 'package:txfb_insurance_flutter/resources/theme/colors/tfb_brand_colors.dart';
import 'package:txfb_insurance_flutter/shared/enum/form_validation_type.dart';
import 'package:txfb_insurance_flutter/shared/shared.dart';
import 'package:txfb_insurance_flutter/shared/widgets/bottom_sheet_selector.dart';
import 'package:txfb_insurance_flutter/shared/widgets/validating_form_field.dart';

class VehicleMakeSelector extends StatelessWidget {
  const VehicleMakeSelector({
    required this.onVehicleMakeSelected,
    required this.selectedValueController,
    required this.isEnabled,
    required this.year,
    super.key,
  });

  final ValueChanged<SubmitClaimVehicleMake?> onVehicleMakeSelected;
  final TextEditingController selectedValueController;
  final bool isEnabled;
  final String year;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: context.getLocalizationOf.selectionField(
        context.getLocalizationOf.vehicleMakeLabel,
      ),
      child: _VehicleMakeBottomSheetSelector(
        onChanged: (value) =>
            onVehicleMakeSelected(value as SubmitClaimVehicleMake),
        selectedValueController: selectedValueController,
        isEnabled: isEnabled,
        year: year,
      ),
    );
  }
}

class _VehicleMakeBottomSheetSelector extends StatefulWidget {
  const _VehicleMakeBottomSheetSelector({
    required this.selectedValueController,
    required this.onChanged,
    required this.isEnabled,
    required this.year,
  });

  final void Function(dynamic) onChanged;
  final TextEditingController selectedValueController;
  final bool isEnabled;
  final String year;

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
          label: context.getLocalizationOf.vehicleMakeLabel,
          child: ValidatingFormField(
            labelText: context.getLocalizationOf.vehicleMakeLabel,
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
                                        context
                                            .getLocalizationOf.vehicleMakeLabel,
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
                                  create: (context) => VehicleMakeCubit(
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
                                  child: BlocBuilder<VehicleMakeCubit,
                                      VehicleMakeState>(
                                    builder: (context, state) {
                                      if (state is VehicleMakeInitial) {
                                        context
                                            .read<VehicleMakeCubit>()
                                            .getVehicleMakes(widget.year);
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
                                      if (state is VehicleMakeProcessing) {
                                        return const SizedBox(
                                          height: 150,
                                          child: TfbLoadingOverlay(),
                                        );
                                      }

                                      if (state is VehicleMakeFailure) {
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

                                      if (state is VehicleMakeSuccess) {
                                        return Container(
                                          constraints: BoxConstraints(
                                            maxHeight: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.45,
                                          ),
                                          child: ListView.builder(
                                            shrinkWrap: true,
                                            itemCount: state.makes.length,
                                            padding: EdgeInsets.zero,
                                            itemBuilder: (_, index) {
                                              return BottomSheetSelectorOptionButton(
                                                label:
                                                    state.makes[index]!.value!,
                                                value:
                                                    state.makes[index]!.value!,
                                                onPress: () {
                                                  widget.selectedValueController
                                                          .text =
                                                      state
                                                          .makes[index]!.value!;
                                                  widget.onChanged(
                                                    state.makes[index],
                                                  );
                                                  Navigator.pop(context);
                                                },
                                              );
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
