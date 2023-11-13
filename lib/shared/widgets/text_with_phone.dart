import 'package:flutter/gestures.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:txfb_insurance_flutter/shared/shared.dart';
import 'package:txfb_insurance_flutter/resources/theme/theme.dart';

// This class returns a widget of the following structure:
// <Optionally some text><a phone number><optionally some Text>
// The phone number will be tappable.
// you can override styling on the widget if you like.
class TextWithPhone extends StatelessWidget {
  const TextWithPhone({
    required this.phoneNumberForDisplay,
    required this.phoneNumberForDialing,
    this.prePhoneNumberString,
    this.postPhoneNumberString,
    this.styleForBodyText,
    this.styleForPhoneNumber,
    super.key,
  });

  final String? prePhoneNumberString;
  final String? phoneNumberForDisplay;
  final String? postPhoneNumberString;
  final String? phoneNumberForDialing;
  final TextStyle? styleForBodyText;
  final TextStyle? styleForPhoneNumber;

  Future<void> _launchPhone() async {
    final Uri url = Uri.parse('tel:$phoneNumberForDialing');
    await canLaunchUrl(url)
        ? await launchUrl(url)
        : throw 'Could not launch $url';
  }

  @override
  Widget build(BuildContext context) {
    final bodyStyle = context.tfbText.bodyLightSmall.copyWith(
      color: TfbBrandColors.grayHighest,
    );
    final phoneStyle = context.tfbText.bodyLightSmall.copyWith(
      color: LightColors.urlColor,
      fontWeight: FontWeight.w400,
    );
    return Text.rich(
      TextSpan(
        children: [
          TextSpan(
            text: prePhoneNumberString,
            style: styleForBodyText ?? bodyStyle,
          ),
          TextSpan(
            text: phoneNumberForDisplay,
            recognizer: TapGestureRecognizer()..onTap = _launchPhone,
            style: styleForPhoneNumber ?? phoneStyle,
            semanticsLabel:
                phoneNumberForDialing?.replaceAll(RegExp(r'\D'), '') ?? '',
            spellOut: true,
          ),
          TextSpan(
            text: postPhoneNumberString,
            style: styleForBodyText ?? bodyStyle,
          ),
        ],
      ),
    );
  }
}
