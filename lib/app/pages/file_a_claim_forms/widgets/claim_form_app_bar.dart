import 'package:flutter/services.dart';
import 'package:txfb_insurance_flutter/app/pages/file_a_claim_forms/widgets/auto_form_progress_indicator.dart';
import 'package:txfb_insurance_flutter/app/pages/file_a_claim_forms/widgets/claims_form_progress_indicator.dart';
import 'package:txfb_insurance_flutter/app/pages/file_a_claim_forms/widgets/property_form_progress_indicator.dart';
import 'package:txfb_insurance_flutter/app/router/router.dart';
import 'package:txfb_insurance_flutter/domain/models/claims/file_a_claim/policy_selection.dart';
import 'package:txfb_insurance_flutter/domain/models/policy/policy_summary.dart';
import 'package:txfb_insurance_flutter/resources/theme/theme.dart';
import 'package:txfb_insurance_flutter/shared/shared.dart';

/// App bar that automatically animates the title into the center of the AppBar
/// when the user scrolls.
///
/// Use in conjunction with TfbDropShadowScrollWidget to create an animated,
/// elevated AppBar effect.
class ClaimsFormAppBar extends StatefulWidget implements PreferredSizeWidget {
  const ClaimsFormAppBar({
    required this.keyReporterSection,
    required this.keyLossAndDamageSection,
    required this.reporterSectionStatus,
    required this.lossAndDamageSectionStatus,
    required this.policy,
    this.keyDriversAndVehiclesSection,
    this.driversAndVehiclesSectionStatus,
    super.key,
  });

  final GlobalKey keyReporterSection;
  final GlobalKey keyLossAndDamageSection;
  final PolicySelection policy;

  /// Required for policyType TxPersonalAuto
  final GlobalKey? keyDriversAndVehiclesSection;
  final ValueNotifier<ProgressIndicatorStatus> reporterSectionStatus;
  final ValueNotifier<ProgressIndicatorStatus> lossAndDamageSectionStatus;

  /// Required for policyType TxPersonalAuto
  final ValueNotifier<ProgressIndicatorStatus>? driversAndVehiclesSectionStatus;

  @override
  State<ClaimsFormAppBar> createState() => _ClaimsFormAppBarState();

  @override
  Size get preferredSize => const Size.fromHeight(122);
}

class _ClaimsFormAppBarState extends State<ClaimsFormAppBar> {
  ScrollController? _scrollController;
  ValueNotifier<bool> shouldShowNotifier = ValueNotifier(false);
  final animationDuration = const Duration(milliseconds: 100);

  @override
  void initState() {
    if (widget.policy.policyType == PolicyType.txPersonalAuto) {
      assert(
        widget.keyDriversAndVehiclesSection != null,
        'keyDriversAndVehiclesSection is required for policyType txPersonalAuto',
      );
      assert(
        widget.driversAndVehiclesSectionStatus != null,
        'driversAndVehiclesSectionStatus is required for policyType txPersonalAuto',
      );
    }
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _updateTitle());
  }

  @override
  Widget build(BuildContext context) {
    _scrollController = PrimaryScrollController.of(context);
    _scrollController!.addListener(_updateTitle);

    final actions = CancelAppBarAction(
      onPress: () async =>
          context.navigator.pushCancelClaimsDialog(widget.policy),
    );

    return AppBar(
      elevation: 0,
      scrolledUnderElevation: 0,
      actions: [actions],
      centerTitle: true,
      automaticallyImplyLeading: false,
      backgroundColor: Colors.transparent,
      systemOverlayStyle: const SystemUiOverlayStyle(
        statusBarIconBrightness: Brightness.dark,
        statusBarBrightness: Brightness.light,
      ),
      title: ValueListenableBuilder(
        valueListenable: shouldShowNotifier,
        builder: (context, state, child) {
          return Padding(
            padding: const EdgeInsets.all(kSpacingSmall),
            child: AnimatedOpacity(
              duration: animationDuration,
              opacity: state ? 1.0 : 0.0,
              child: Text(
                context.getLocalizationOf.fileAClaimHeaderTitle,
                style: context.tfbText.bodyLightLarge.copyWith(
                  color: TfbBrandColors.blueHighest,
                ),
              ),
            ),
          );
        },
      ),
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(70),
        child: ValueListenableBuilder(
          valueListenable: shouldShowNotifier,
          builder: (context, state, child) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: kSpacingLarge),
              child: AnimatedSwitcher(
                duration: animationDuration,
                child: state
                    ? Padding(
                        padding: const EdgeInsets.only(bottom: kSpacingMedium),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SeparatorLine(),
                            if (widget.policy.policyType ==
                                    PolicyType.txPersonalAuto &&
                                widget.keyDriversAndVehiclesSection != null &&
                                widget.driversAndVehiclesSectionStatus != null)
                              AutoFormProgressIndicator(
                                keyDriversAndVehiclesSection:
                                    widget.keyDriversAndVehiclesSection!,
                                keyLossAndDamageSection:
                                    widget.keyLossAndDamageSection,
                                keyReporterSection: widget.keyReporterSection,
                                driversAndVehiclesSectionStatus:
                                    widget.driversAndVehiclesSectionStatus!,
                                lossAndDamageSectionStatus:
                                    widget.lossAndDamageSectionStatus,
                                reporterSectionStatus:
                                    widget.reporterSectionStatus,
                              )
                            else
                              PropertyFormProgressIndicator(
                                keyReporterSection: widget.keyReporterSection,
                                keyLossAndDamageSection:
                                    widget.keyLossAndDamageSection,
                                reporterSectionStatus:
                                    widget.reporterSectionStatus,
                                lossAndDamageSectionStatus:
                                    widget.lossAndDamageSectionStatus,
                              ),
                          ],
                        ),
                      )
                    : Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            context.getLocalizationOf.fileAClaimHeaderTitle,
                            style: context.tfbText.header3.copyWith(
                              color: TfbBrandColors.blueHighest,
                            ),
                          ),
                          const SeparatorLine(),
                        ],
                      ),
              ),
            );
          },
        ),
      ),
    );
  }

  void _updateTitle() {
    if (_scrollController != null) {
      bool show = false;

      if (_scrollController!.hasClients) {
        show = _scrollController!.position.pixels > 0 && !show;
      }
      if (shouldShowNotifier.value != show) {
        shouldShowNotifier.value = show;
      }
    }
  }

  @override
  void dispose() {
    _scrollController?.removeListener(_updateTitle);
    super.dispose();
  }
}
