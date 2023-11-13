import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:plugin_haven/plugin_haven.dart';
import 'package:txfb_insurance_flutter/app/blocs/autopay/autopay_bloc.dart';
import 'package:txfb_insurance_flutter/domain/models/billing/account_info_form_data.dart';
import 'package:txfb_insurance_flutter/domain/models/billing/autopay_form_state.dart';
import 'package:txfb_insurance_flutter/domain/models/policy/policy_summary.dart';
import 'package:txfb_insurance_flutter/resources/theme/theme.dart';
import 'package:txfb_insurance_flutter/shared/shared.dart';

class AutopayEnrollmentButton extends StatelessWidget {
  const AutopayEnrollmentButton({
    required this.isFormValid,
    required this.areTermsChecked,
    required this.draftDay,
    required this.policy,
    required this.accountType,
    required this.accountInfo,
    super.key,
  });

  final bool isFormValid;
  final bool areTermsChecked;
  final String draftDay;
  final PolicySummary policy;
  final AutopayAccountType accountType;
  final AccountInfoFormData accountInfo;

  @override
  Widget build(BuildContext context) {
    final user = context.user;
    final areAllFieldsValid = isFormValid &&
        areTermsChecked &&
        user != null &&
        !draftDay.isNullOrEmpty;

    final formState = AutopayFormState(
      nameOnBankAccount: accountInfo.bankAccountName,
      paymentDate: draftDay.isNullOrEmpty ? 1 : int.parse(draftDay),
      bankRoutingNumber: accountInfo.routingNumber,
      bankAccountNumber: accountInfo.bankAccountNumber,
      bankName: accountInfo.bankName,
      accountType: accountType,
    );

    final String autoPayButtonLabel = policy.isAutoPayEnabled
        ? context.getLocalizationOf.submitChanges
        : context.getLocalizationOf.submitEnrollment;

    return TfbFilledButton.primaryTextButton(
      onPressed: areAllFieldsValid
          ? () {
              BlocProvider.of<AutopayBloc>(context).add(
                (policy.isAutoPayEnabled)
                    ? UpdateAutopay(
                        policy: policy,
                        form: formState,
                        user: user,
                      )
                    : EnrollInAutopay(
                        policy: policy,
                        form: formState,
                        user: user,
                      ),
              );
            }
          : null,
      title: autoPayButtonLabel,
    );
  }
}
