import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:plugin_haven/plugin_haven.dart';
import 'package:txfb_insurance_flutter/device/device.dart';
import 'package:txfb_insurance_flutter/resources/theme/colors/colors.dart';
import 'package:txfb_insurance_flutter/shared/shared.dart';
import 'package:txfb_insurance_flutter/domain/models/app_info/enums/web_uri_enums.dart';

class TermsCheckbox extends StatefulWidget {
  const TermsCheckbox({
    required this.termsChecked,
    required this.onChanged,
    super.key,
  });

  final bool termsChecked;
  final void Function({bool? value}) onChanged;

  @override
  State<TermsCheckbox> createState() => _TermsCheckboxState();
}

class _TermsCheckboxState extends FocusAwareWidgetState<TermsCheckbox> {
  @override
  Widget build(BuildContext context) {
    void onTap(FormFieldState<bool> state, {required bool? value}) {
      widget.onChanged(value: value);
      state.didChange(value);
      validateOnNextFrame();
    }

    const checkboxOffset = 14.0;
    final termsUri = context
        .getEnvironment<TfbEnvironment>()
        .createWebsiteUri(WebUriEnum.termsAndConditions);
    final privacyUri = context
        .getEnvironment<TfbEnvironment>()
        .createWebsiteUri(WebUriEnum.privacyPolicy);

    return Transform.translate(
      offset: const Offset(-checkboxOffset, 0),
      child: FormField<bool>(
        key: formFieldKey,
        builder: (state) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              GestureDetector(
                onTap: () {
                  onTap(state, value: !widget.termsChecked);
                },
                child: Row(
                  children: <Widget>[
                    Checkbox(
                      focusNode: focusNode,
                      value: widget.termsChecked,
                      onChanged: (value) => onTap(state, value: value),
                      splashRadius: 0,
                    ),
                    Flexible(
                      child: RichText(
                        text: TextSpan(
                          text: context.getLocalizationOf.termsLabel,
                          style: context.tfbText.bodyMediumSmall.copyWith(
                            color: TfbBrandColors.blueHighest,
                          ),
                          children: [
                            TextSpan(
                              text: context.getLocalizationOf.termsLabelBold,
                              style: context.tfbText.bodyMediumSmall.copyWith(
                                color: TfbBrandColors.blueHigh,
                              ),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () => context.openUrl(url: termsUri),
                            ),
                            TextSpan(
                              text: context.getLocalizationOf.and,
                              style: context.tfbText.bodyMediumSmall.copyWith(
                                color: TfbBrandColors.blueHighest,
                              ),
                            ),
                            TextSpan(
                              text: context.getLocalizationOf.privacyLabelBold,
                              style: context.tfbText.bodyMediumSmall.copyWith(
                                color: TfbBrandColors.blueHigh,
                              ),
                              recognizer: TapGestureRecognizer()
                                ..onTap =
                                    () => context.openUrl(url: privacyUri),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              if (state.errorText?.isNotEmpty ?? false)
                Padding(
                  padding: const EdgeInsets.only(
                    bottom: kSpacingMedium,
                    top: kSpacingExtraSmall,
                    left: checkboxOffset,
                  ),
                  child: Text(
                    state.errorText!,
                    style: context.tfbText.caption.copyWith(
                      color: TfbBrandColors.redHigh,
                    ),
                  ),
                ),
            ],
          );
        },
        validator: (value) {
          if (!widget.termsChecked) {
            return context.getLocalizationOf.agreeToTermsError;
          } else {
            return null;
          }
        },
      ),
    );
  }
}
