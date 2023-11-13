import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:plugin_haven/haven.dart';
import 'package:txfb_insurance_flutter/resources/theme/theme.dart';
import 'package:txfb_insurance_flutter/shared/enum/form_validation_type.dart';
import 'package:txfb_insurance_flutter/shared/shared.dart';
import 'package:txfb_insurance_flutter/shared/widgets/text_field_semantics_wrapper.dart';

/// This widget provides a simple-to-configure text input
/// field for use while building a form. In particular,
/// validations for regex & min/max lengths, as well as
/// visual indicators and the like, are all supported.

class ValidatingFormField extends StatefulWidget {
  ValidatingFormField({
    required this.labelText,
    required this.type,
    this.semanticsLabel,
    this.showCharacterCount = false,
    this.additionalValidator,
    this.autoFillHints,
    this.controller,
    this.initialValue,
    this.inputFormatters,
    this.isRequired = false,
    this.isEnabled = true,
    this.onChanged,
    this.returnButtonType = TextInputAction.done,
    this.style,
    this.readOnly = false,
    this.suffixIcon,
    this.suffixIconConstraints,
    this.onTap,
    super.key,
  });

  /// Semantics Label is a non-required field. When left empty, the
  /// accessibility tag will default to labelText.
  final String? semanticsLabel;

  /// should the character count be displayed?
  final bool showCharacterCount;

  /// A style for the body of text. If you need to override the hint style or
  /// anything else, you'll need to add those in via a refactor. I actually don't
  /// expect even this style to be overridden.
  final TextStyle? style;

  /// The 'title' of the input field
  final String labelText;

  /// an initial value, if any.
  final String? initialValue;

  /// Does this field get a red asterisk and validation rules? Note that *all*
  /// fields are validated as the user types.
  final bool isRequired;

  /// The controller that will hold the output text
  final TextEditingController? controller;

  /// What kind of text input field are we talking about here?
  final ValidationType type;

  /// Any final form validation not covered by regex or length.
  final FormFieldValidator<String>? additionalValidator;

  /// Autofill hints, if needed.
  final Iterable<String>? autoFillHints;

  /// Input formatters, to be added to the integrated formatters.
  final List<TextInputFormatter>? inputFormatters;

  /// Optional callback when values change.
  final ValueChanged<String>? onChanged;

  /// What kind of button is on the keyboard? Defaults to 'next'.
  final TextInputAction returnButtonType;

  // Number formatter for character counts (we want a comma for 1,000 characters)
  final _formatter = NumberFormat('###,###', 'en_US');

  /// should field be disabled for editing
  final bool readOnly;

  /// icon to display at end of line
  final Widget? suffixIcon;

  /// icon constraints
  final BoxConstraints? suffixIconConstraints;

  final void Function()? onTap;

  final bool isEnabled;

  @override
  State<ValidatingFormField> createState() => _ValidatingFormFieldState();
}

class _ValidatingFormFieldState
    extends FocusAwareWidgetState<ValidatingFormField> {
  // Generates a character count display, if the showCharacterCount boolean is
  // true.
  String? _charCount() {
    if (!widget.showCharacterCount) {
      return null;
    }
    final charCountMessage = focusNode.hasFocus
        ? '${widget.controller?.text.characters.length.toString()}/${widget._formatter.format(widget.type.maxLength)} characters'
        : null;
    return charCountMessage;
  }

  // Set up error states when needed, and move changes into the controller

  void _onChanged(String s) {
    setState(() {
      widget.onChanged?.call(s);
    });
  }

  // A FormFieldValidator<String>? for the form. This is somewhat heavy, as we
  // don't just return the message, we also set our local error message variable.
  // We validate length first, then (if there's a specific message) we validate that
  // next, and finally allow a custom end validation.
  // Note that it'd be *very* strange to have a value enter here with anything other
  // than a length error (although email & phone do have formatting to deal with),
  // because we're stopping bad input at the source.
  String? _validate(String? s) => validateWithValidationType(
        context: context,
        type: widget.type,
        value: s,
        isRequired: widget.isRequired,
        numberFormatter: widget._formatter,
        labelText: widget.labelText,
        additionalValidator: widget.additionalValidator,
        focusNode: focusNode,
      );

  // Ensures we don't go beyond the limit of characters accepted by the API

  TextEditingValue _formatLimitingLength(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    if (newValue.text.characters.length > widget.type.maxLength) {
      return oldValue;
    }
    return newValue;
  }

  @override
  Widget build(BuildContext context) {
    // On build, set the controller's value to the initial value, if provided.
    // This should, in theory, run one time (or if the form is reset).
    final initialValue = widget.initialValue;
    final String semantics = widget.semanticsLabel.isNullOrEmpty
        ? widget.labelText
        : widget.semanticsLabel!;
    final controllerValue = widget.controller?.value.text;
    if (!initialValue.isNullOrEmpty && controllerValue.isNullOrEmpty) {
      widget.controller?.text = widget.initialValue!;
    }

    // Append our input formatters (length & regex) to any provided in the
    // constructor.
    final List<TextInputFormatter> inputFormatters =
        (widget.inputFormatters ?? [])
          ..addAll([
            TextInputFormatter.withFunction(_formatLimitingLength),
            FilteringTextInputFormatter.allow(RegExp(widget.type.filter)),
          ]);

    return TextFieldSemanticsWrapper(
      label: semantics,
      child: TextFormField(
        onTapOutside: (event) => FocusManager.instance.primaryFocus?.unfocus(),
        focusNode: focusNode,
        controller: widget.controller,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        key: formFieldKey,
        onChanged: _onChanged,
        onSaved: (_) {},
        enabled: widget.isEnabled,
        validator: _validate,
        textInputAction: widget.returnButtonType,
        keyboardType: widget.type.keyboardType,
        maxLines: null,
        style: widget.style ??
            context.tfbText.bodyLightLarge.copyWith(
              color: TfbBrandColors.blueHighest,
            ),
        inputFormatters: inputFormatters,
        autofillHints: widget.autoFillHints,
        smartQuotesType: SmartQuotesType.disabled,
        smartDashesType: SmartDashesType.disabled,
        decoration: InputDecoration(
          label: Row(
            children: [
              Text(
                widget.labelText,
                style: context.tfbText.bodyLightLarge.copyWith(
                  color: TfbBrandColors.grayHigh,
                ),
              ),
              if (widget.isRequired) ...[
                Text(
                  '*',
                  style: context.tfbText.bodyLightLarge
                      .copyWith(color: TfbBrandColors.redHigh),
                ),
              ],
            ],
          ),
          // If the character counter is not displayed, we use an empty string
          // to ensure the spacing between fields is always the same
          helperText: _charCount() ?? ' ',
          errorStyle: context.tfbText.caption.copyWith(
            color: TfbBrandColors.redHigh,
          ),
          floatingLabelStyle:
              context.tfbText.caption.copyWith(color: TfbBrandColors.grayHigh),
          helperStyle: context.tfbText.caption.copyWith(
            color: TfbBrandColors.grayHigh,
          ),
          enabledBorder: const UnderlineInputBorder(
            borderSide: BorderSide(
              color: TfbBrandColors.grayHigh,
            ),
          ),
          disabledBorder: const UnderlineInputBorder(
            borderSide: BorderSide(
              color: TfbBrandColors.grayHigh,
            ),
          ),
          focusedBorder: const UnderlineInputBorder(
            borderSide: BorderSide(color: TfbBrandColors.grayHigh),
          ),
          focusedErrorBorder: const UnderlineInputBorder(
            borderSide: BorderSide(color: TfbBrandColors.redHigh),
          ),
          errorBorder: const UnderlineInputBorder(
            borderSide: BorderSide(color: TfbBrandColors.redHigh),
          ),
          suffixStyle: widget.style ??
              context.tfbText.bodyLightLarge.copyWith(
                color: TfbBrandColors.blueHighest,
              ),
          contentPadding: const EdgeInsets.only(
            bottom: kSpacingSmall,
          ),
          suffixIcon: widget.suffixIcon,
          suffixIconConstraints: widget.suffixIconConstraints,
        ),
        readOnly: widget.readOnly,
        onTap: widget.onTap,
      ),
    );
  }
}

String? validateWithValidationType({
  required String? value,
  required ValidationType type,
  required BuildContext context,
  required String labelText,
  final FormFieldValidator<String>? additionalValidator,
  bool isRequired = true,
  NumberFormat? numberFormatter,
  FocusNode? focusNode,
}) {
  String? errorMessage;

  // Number formatter for character counts (we want a comma for 1,000 characters)
  final formatter = numberFormatter ?? NumberFormat('###,###', 'en_US');

  //Do not validate if field is not required and is empty
  if (!isRequired && (value?.characters.isEmpty ?? true)) {
    return null;
  }

  // length validation, but only if required.
  if (type.maxLength == type.minLength) {
    if (value?.characters.length != type.minLength &&
        !(focusNode?.hasFocus ?? false)) {
      errorMessage =
          context.getLocalizationOf.exactCharacterCount(type.minLength);
    }
  } else {
    if ((value?.characters.length ?? 0) < type.minLength &&
        !(focusNode?.hasFocus ?? false)) {
      errorMessage =
          errorMessage = context.getLocalizationOf.rangeCharacterCount(
        formatter.format(type.maxLength),
        type.minLength,
      );
    }
  }

  // If there's an error message, run that in place of the above.
  if (type.validationError != null) {
    final regex = RegExp(type.regex);
    if (!regex.hasMatch(
      (type.uppercaseOnly ? value?.toUpperCase() : value) ?? '',
    )) {
      if (type == ValidationType.selection) {
        errorMessage = context.getLocalizationOf
            .selectedFieldValidation(labelText.toLowerCase());
      } else {
        final validationErrorType = switch (type) {
          ValidationType.phone =>
            context.getLocalizationOf.validationPhoneNumber,
          ValidationType.email =>
            context.getLocalizationOf.validationEmailAddress,
          ValidationType.zipCode => context.getLocalizationOf.validationZipCode,
          _ => ''
        };
        errorMessage = context.getLocalizationOf
            .requiredFieldValidation(validationErrorType);
      }
    }
  }

  errorMessage = additionalValidator?.call(value) ?? errorMessage;
  return errorMessage;
}
