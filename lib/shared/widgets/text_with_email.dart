import 'package:flutter/gestures.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:txfb_insurance_flutter/shared/shared.dart';
import 'package:txfb_insurance_flutter/resources/theme/theme.dart';

// This class returns a widget of the following structure:
// <Optionally some text><an email address><optionally some Text>
// The email address will be tappable, and start an email with the
// provided subject, body, and destination email.
// you can override styling on the widget if you like.
class TextWithEmail extends StatelessWidget {
  const TextWithEmail({
    required this.emailAddress,
    this.displayEmailAddress,
    this.preEmailString,
    this.postEmailString,
    this.styleForBodyText,
    this.styleForEmailAddress,
    super.key,
  });

  final String? preEmailString;
  final String? emailAddress;
  final String? displayEmailAddress;
  final String? postEmailString;
  final TextStyle? styleForBodyText;
  final TextStyle? styleForEmailAddress;

  Future<void> _launchEmail() async {
    final Map<String, String> queryParameters = {};
    final Uri url = Uri(
      scheme: 'mailto',
      path: emailAddress,
      queryParameters: queryParameters,
    );
    await canLaunchUrl(url)
        ? await launchUrl(url)
        : throw 'Could not launch $url';
  }

  @override
  Widget build(BuildContext context) {
    final bodyStyle = context.tfbText.bodyLightSmall.copyWith(
      color: TfbBrandColors.grayHighest,
    );
    final addressStyle = context.tfbText.bodyLightSmall.copyWith(
      color: LightColors.urlColor,
    );
    return Text.rich(
      TextSpan(
        children: [
          TextSpan(
            text: preEmailString,
            style: styleForBodyText ?? bodyStyle,
          ),
          TextSpan(
            text: displayEmailAddress ?? emailAddress,
            recognizer: TapGestureRecognizer()..onTap = _launchEmail,
            style: styleForEmailAddress ?? addressStyle,
          ),
          TextSpan(
            text: postEmailString,
            style: styleForBodyText ?? bodyStyle,
          ),
        ],
      ),
    );
  }
}
