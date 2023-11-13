import 'package:txfb_insurance_flutter/app/analytics/events/account_registration_events.dart';
import 'package:txfb_insurance_flutter/app/analytics/tfb_analytics.dart';
import 'package:txfb_insurance_flutter/data/data_validators/tfb_member_number_validator.dart';
import 'package:txfb_insurance_flutter/resources/theme/theme.dart';
import 'package:txfb_insurance_flutter/shared/shared.dart';
import 'package:txfb_insurance_flutter/shared/widgets/text_field_semantics_wrapper.dart';

class MemberNumberFormField extends StatefulWidget {
  const MemberNumberFormField({
    required this.memberNumController,
    required this.onChanged,
    required this.validator,
    super.key,
  });

  final TextEditingController memberNumController;
  final TfbMemberNumberValidator validator;
  final void Function(String) onChanged;

  @override
  State<MemberNumberFormField> createState() => _MemberNumberFormFieldState();
}

class _MemberNumberFormFieldState
    extends FocusAwareWidgetState<MemberNumberFormField> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: kSpacingMedium),
      child: TextFieldSemanticsWrapper(
        label: context.getLocalizationOf.memberNumLabel,
        child: TextFormField(
          key: formFieldKey,
          focusNode: focusNode,
          style: context.tfbText.bodyLightLarge.copyWith(
            color: TfbBrandColors.blueHighest,
          ),
          decoration: InputDecoration(
            errorMaxLines: 2,
            labelText: context.getLocalizationOf.memberNumLabel,
            suffixIcon: IconButton(
              onPressed: () {
                TfbAnalytics.instance.track(
                  const MembershipCardModalViewEvent(),
                );
                _showMemberNumberInfo(context);
              },
              icon: Image.asset(
                TfbAssetStrings.questionIcon,
                height: 24,
                width: 24,
              ),
            ),
          ),
          controller: widget.memberNumController,
          validator: widget.validator.validate,
          onChanged: widget.onChanged,
        ),
      ),
    );
  }
}

void _showMemberNumberInfo(BuildContext context) {
  showDialog<void>(
    context: context,
    builder: (BuildContext context) {
      return Dialog(
        insetPadding: const EdgeInsets.all(kSpacingSmall),
        backgroundColor: Colors.transparent,
        shadowColor: Colors.transparent,
        child: Image.asset(TfbAssetStrings.memberNumberInfo),
      );
    },
  );
}
