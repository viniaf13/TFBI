import 'package:txfb_insurance_flutter/app/pages/create_account/widgets/password_criteria_row.dart';
import 'package:txfb_insurance_flutter/data/data_validators/tfb_password_registration_validator.dart';
import 'package:txfb_insurance_flutter/resources/theme/theme.dart';
import 'package:txfb_insurance_flutter/shared/shared.dart';

class PasswordCriteria extends StatelessWidget {
  const PasswordCriteria({required this.passwordController, super.key});

  final TextEditingController passwordController;

  @override
  Widget build(BuildContext context) {
    final List<PasswordCriterion> passwordCriteria =
        createLocalizedPasswordCriteria(context);

    return ValueListenableBuilder(
      valueListenable: passwordController,
      builder: (context, value, child) {
        final List<TfbRegistrationPasswordValidatorErrorMessageKeys>
            errorMessageKeys = TfbRegistrationPasswordValidator()
                .validate(passwordController.text);

        return Padding(
          padding: const EdgeInsets.only(
            top: kSpacingLarge,
            bottom: kSpacingMedium,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: passwordCriteria
                .map(
                  (criterion) => PasswordCriteriaRow(
                    isCriteriaMet: criterion.errorKeys.every(
                      (key) => !errorMessageKeys.contains(key),
                    ),
                    labelText: criterion.errorText,
                  ),
                )
                .toList(),
          ),
        );
      },
    );
  }

  List<PasswordCriterion> createLocalizedPasswordCriteria(
    BuildContext context,
  ) =>
      [
        PasswordCriterion(context.getLocalizationOf.passwordCriteria1, [
          TfbRegistrationPasswordValidatorErrorMessageKeys
              .minimumCharactersNotMet,
          TfbRegistrationPasswordValidatorErrorMessageKeys
              .overMaximumCharacterLimit,
        ]),
        PasswordCriterion(
          context.getLocalizationOf.passwordCriteria2,
          [
            TfbRegistrationPasswordValidatorErrorMessageKeys
                .minimumNumbersRequiredNotMet,
          ],
        ),
        PasswordCriterion(context.getLocalizationOf.passwordCriteria3, [
          TfbRegistrationPasswordValidatorErrorMessageKeys
              .minimumLettersRequiredNotMet,
        ]),
        PasswordCriterion(context.getLocalizationOf.passwordCriteria4, [
          TfbRegistrationPasswordValidatorErrorMessageKeys
              .minimumUppercaseLettersRequiredNotMet,
        ]),
        PasswordCriterion(context.getLocalizationOf.passwordCriteria5, [
          TfbRegistrationPasswordValidatorErrorMessageKeys
              .moreThanTwoConcurrentCharacters,
        ]),
        PasswordCriterion(context.getLocalizationOf.passwordCriteria6, [
          TfbRegistrationPasswordValidatorErrorMessageKeys
              .usingDisallowedCharacters,
        ]),
      ];
}

class PasswordCriterion {
  PasswordCriterion(this.errorText, this.errorKeys);

  final String errorText;
  final List<TfbRegistrationPasswordValidatorErrorMessageKeys> errorKeys;
}
