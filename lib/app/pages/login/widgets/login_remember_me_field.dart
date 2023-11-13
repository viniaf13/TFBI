import 'package:txfb_insurance_flutter/resources/theme/theme.dart';
import 'package:txfb_insurance_flutter/shared/shared.dart';

class LoginRememberMeField extends StatelessWidget {
  const LoginRememberMeField({
    required this.rememberMeChecked,
    required this.onChanged,
    super.key,
  });

  final bool rememberMeChecked;
  final void Function({bool? value}) onChanged;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 1,
          color: LightColors.borderGray,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: kSpacingExtraSmall),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                context.getLocalizationOf.loginRememberEmail,
                style: context.tfbText.bodyMediumSmall,
              ),
              Switch(
                value: rememberMeChecked,
                onChanged: (value) => onChanged(value: value),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
