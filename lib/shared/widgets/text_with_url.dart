import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:txfb_insurance_flutter/resources/theme/colors/light_colors.dart';
import 'package:txfb_insurance_flutter/shared/extensions/extensions.dart';
import 'package:url_launcher/url_launcher.dart';

class TextWithUrl extends StatelessWidget {
  const TextWithUrl({
    required this.urlForDisplay,
    required this.urlForLaunch,
    this.styleForUrl,
    super.key,
  });

  final String urlForDisplay;
  final String urlForLaunch;
  final TextStyle? styleForUrl;

  Future<void> _launchURL() async {
    final Uri url = Uri.parse(urlForLaunch);
    await canLaunchUrl(url)
        ? await launchUrl(url)
        : throw 'Could not launch $url';
  }

  @override
  Widget build(BuildContext context) {
    final urlStyle = context.tfbText.bodyLightSmall.copyWith(
      color: LightColors.urlColor,
      fontWeight: FontWeight.w400,
    );
    return Text.rich(
      TextSpan(
        children: [
          TextSpan(
            text: urlForDisplay,
            recognizer: TapGestureRecognizer()..onTap = _launchURL,
            style: styleForUrl ?? urlStyle,
          ),
        ],
      ),
    );
  }
}
