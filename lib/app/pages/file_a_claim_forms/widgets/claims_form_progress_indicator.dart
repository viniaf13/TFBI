import 'package:flutter/material.dart';
import 'package:txfb_insurance_flutter/resources/theme/colors/colors.dart';
import 'package:txfb_insurance_flutter/shared/shared.dart';

enum ProgressIndicatorStatus {
  notStarted(TfbBrandColors.grayHigh, TfbBrandColors.grayHigh),
  inProgress(TfbBrandColors.blueHigh, TfbBrandColors.blueHighest),
  completed(TfbBrandColors.greenHigh, TfbBrandColors.greenHighest);

  const ProgressIndicatorStatus(this.indexColor, this.textColor);

  final Color indexColor;
  final Color textColor;
}

class ClaimFormProgressIndicatorStep {
  ClaimFormProgressIndicatorStep({
    required this.label,
    required this.status,
    this.onTap,
  });

  final String label;
  final ValueNotifier<ProgressIndicatorStatus> status;
  final void Function()? onTap;
}

class ClaimsFormProgressIndicator extends StatelessWidget {
  const ClaimsFormProgressIndicator({
    required this.steps,
    super.key,
  });

  final List<ClaimFormProgressIndicatorStep> steps;

  @override
  Widget build(BuildContext context) {
    return FittedBox(
      child: Row(
        children: steps.asMap().entries.map((step) {
          return _ProgressIndicatorStep(
            label: step.value.label,
            // Add one to the index for display
            index: step.key + 1,
            status: step.value.status,
            onTap: step.value.onTap,
            key: Key('ProgressIndicatorStep_${step.value.label}'),
          );
        }).toList(),
      ),
    );
  }
}

class _ProgressIndicatorStep extends StatelessWidget {
  const _ProgressIndicatorStep({
    required this.label,
    required this.index,
    required this.status,
    this.onTap,
    super.key,
  });

  final String label;
  final int index;
  final ValueNotifier<ProgressIndicatorStatus> status;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: status,
      builder: (context, _) {
        return InkWell(
          onTap: onTap,
          child: Row(
            key: key,
            children: [
              if (index != 1)
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: kSpacingSmall,
                  ),
                  child: Container(
                    height: 1,
                    width: 8,
                    decoration: BoxDecoration(
                      color: status.value.textColor,
                    ),
                  ),
                ),
              Container(
                height: 16,
                width: 16,
                alignment: AlignmentDirectional.center,
                decoration: BoxDecoration(
                  borderRadius: context.radii.largeRadius,
                  color: status.value.indexColor,
                ),
                child: Text(
                  index.toString(),
                  style: context.tfbText.tabBar.copyWith(
                    color: TfbBrandColors.grayLowest,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: kSpacingExtraSmall),
                child: Text(
                  label,
                  style: context.tfbText.tabBar.copyWith(
                    color: status.value.textColor,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
