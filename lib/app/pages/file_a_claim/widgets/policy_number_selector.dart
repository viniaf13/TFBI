import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:plugin_haven/plugin_haven.dart';
import 'package:txfb_insurance_flutter/app/blocs/claims/submit_claim/submit_claim_bloc.dart';
import 'package:txfb_insurance_flutter/data/network/clients/tfb_client.dart';
import 'package:txfb_insurance_flutter/device/environment/tfb_environment.dart';
import 'package:txfb_insurance_flutter/domain/clients/document_information_client.dart';
import 'package:txfb_insurance_flutter/domain/clients/file_a_claim_client.dart';
import 'package:txfb_insurance_flutter/domain/models/claims/file_a_claim/policy_selection.dart';
import 'package:txfb_insurance_flutter/domain/repositories/tfb_file_claim_repository.dart';
import 'package:txfb_insurance_flutter/domain/repositories/tfb_policy_lookup_repository.dart';
import 'package:txfb_insurance_flutter/resources/theme/colors/tfb_brand_colors.dart';
import 'package:txfb_insurance_flutter/shared/enum/form_validation_type.dart';
import 'package:txfb_insurance_flutter/shared/shared.dart';
import 'package:txfb_insurance_flutter/shared/widgets/bottom_sheet_selector.dart';
import 'package:txfb_insurance_flutter/shared/widgets/tfb_brand_loading_icon.dart';
import 'package:txfb_insurance_flutter/shared/widgets/validating_form_field.dart';

class PolicyNumberSelector extends StatelessWidget {
  const PolicyNumberSelector({
    required this.onPolicySelected,
    required this.selectedValueController,
    super.key,
  });

  final ValueChanged<PolicySelection?> onPolicySelected;
  final TextEditingController selectedValueController;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: context.getLocalizationOf.selectionField(
        context.getLocalizationOf.policyNumLabel,
      ),
      child: _PolicyNumberBottomSheetSelector(
        onChanged: (value) => onPolicySelected(value as PolicySelection),
        selectedValueController: selectedValueController,
      ),
    );
  }
}

class _PolicyNumberBottomSheetSelector extends StatefulWidget {
  const _PolicyNumberBottomSheetSelector({
    required this.selectedValueController,
    required this.onChanged,
  });

  final void Function(dynamic) onChanged;
  final TextEditingController selectedValueController;

  @override
  State<_PolicyNumberBottomSheetSelector> createState() =>
      _BottomSheetSelectorState();
}

class _BottomSheetSelectorState
    extends State<_PolicyNumberBottomSheetSelector> {
  @override
  Widget build(BuildContext context) {
    final userAccessToken = context.listenToAccessToken();
    final baseUrl = context.getEnvironment<TfbEnvironment>().apiUrl.toString();

    return StatefulBuilder(
      builder: (rootContext, setState) {
        return Semantics(
          label: context.getLocalizationOf.policyNumLabel,
          child: ValidatingFormField(
            labelText: context.getLocalizationOf.policyNumLabel,
            type: ValidationType.selection,
            readOnly: true,
            isRequired: true,
            controller: widget.selectedValueController,
            style: context.tfbText.bodyLightLarge
                .copyWith(color: TfbBrandColors.blueHighest),
            suffixIcon: Image.asset(
              TfbAssetStrings.chevronRightIcon,
              width: 24,
              height: 24,
            ),
            suffixIconConstraints: const BoxConstraints(
              maxHeight: 24,
              maxWidth: 24,
            ),
            onChanged: widget.onChanged,
            onTap: () {
              /// TODO: Implement a custom bottom sheet using GoRouter instead
              /// of `showModalBottomSheet` and move the TfbFileClaimRepository
              /// to TfbAuthenticatedProviders. Using `showModalBottomSheet`
              /// with GoRouter will lead to a lack of access to the shared
              /// context in Flutter. This can result in any item declared under
              /// `TfbAuthenticatedProviders` being unavailable. Therefore,
              /// it's necessary to redeclare the provider.
              showModalBottomSheet<void>(
                useRootNavigator: true,
                context: context,
                isScrollControlled: true,
                backgroundColor: Colors.transparent,
                builder: (modalContext) {
                  return Wrap(
                    children: [
                      GestureDetector(
                        onTap: () => Navigator.of(modalContext).pop(),
                        child: GestureDetector(
                          onTap: () {},
                          child: DecoratedBox(
                            decoration: BoxDecoration(
                              color: TfbBrandColors.white,
                              borderRadius: modalContext.radii.defaultRadiusTop,
                            ),
                            child: SafeArea(
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
                                          modalContext
                                              .getLocalizationOf.policyNumLabel,
                                          style: modalContext
                                              .tfbText.bodyLightLarge
                                              .copyWith(
                                            color: TfbBrandColors.blueHighest,
                                            height: 1,
                                          ),
                                        ),
                                      ),
                                      IconButton(
                                        onPressed: () =>
                                            Navigator.pop(modalContext),
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
                                    create: (context) => SubmitClaimBloc(
                                      fileClaimRepo: TfbFileClaimRepository(
                                        fileClaimClient: FileAClaimClient(
                                          baseUrl: baseUrl,
                                          dio: TfbClient.createAuthenticatedDio(
                                            userAccessToken!,
                                          ),
                                        ),
                                        documentClient: rootContext.read<
                                            TfbDocumentInformationClient>(),
                                        policyLookUp: rootContext
                                            .read<TfbPolicyLookupRepository>(),
                                      ),
                                    ),
                                    child: BlocBuilder<SubmitClaimBloc,
                                        SubmitClaimState>(
                                      builder: (context, state) {
                                        if (state is SubmitClaimInitState) {
                                          BlocProvider.of<SubmitClaimBloc>(
                                            context,
                                          ).add(
                                            SubmitClaimGetPolicyListEvent(),
                                          );
                                        }

                                        if (state
                                            is SubmitClaimProcessingState) {
                                          return const SizedBox(
                                            height: 150,
                                            child: TfbBrandLoadingIcon(
                                              size: Size.fromHeight(48),
                                              thickness:
                                                  LoadingOverlayThickness.thick,
                                            ),
                                          );
                                        }

                                        if (state
                                            is SubmitClaimPolicyListFailureState) {
                                          return SizedBox(
                                            height: 150,
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
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

                                        if (state
                                            is SubmitClaimPolicyListSuccessState) {
                                          return Container(
                                            constraints: BoxConstraints(
                                              maxHeight: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  0.45,
                                            ),
                                            child: ListView.builder(
                                              shrinkWrap: true,
                                              itemCount: state.policies.length,
                                              padding: EdgeInsets.zero,
                                              itemBuilder: (_, index) {
                                                return BottomSheetSelectorOptionButton(
                                                  label:
                                                      '${state.policies[index]?.policyNumber} - ${state.policies[index]?.policyType.name(
                                                    context,
                                                  )} ${context.getLocalizationOf.policy}',
                                                  value: state.policies[index]!
                                                      .policyNumber,
                                                  onPress: () {
                                                    widget.selectedValueController
                                                            .text =
                                                        '${state.policies[index]?.policyNumber} - ${state.policies[index]?.policyType.name(
                                                      context,
                                                    )} ${context.getLocalizationOf.policy}';
                                                    widget.onChanged(
                                                      state.policies[index],
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
}
