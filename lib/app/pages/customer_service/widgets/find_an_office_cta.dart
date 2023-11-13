import 'package:txfb_insurance_flutter/shared/widgets/list_tile_with_arrow.dart';
import 'package:txfb_insurance_flutter/resources/theme/theme.dart';
import 'package:flutter/foundation.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:txfb_insurance_flutter/shared/shared.dart';

class FindAnOfficeCTA extends StatelessWidget {
  const FindAnOfficeCTA({super.key});

  Future<void> openMapApp() async {
    final Uri url = defaultTargetPlatform == TargetPlatform.iOS
        ? Uri.parse(
            kOfficeLocatorAppleMaps,
          )
        : Uri.parse(
            kOfficeLocatorGoogleMaps,
          );

    await canLaunchUrl(url)
        ? await launchUrl(
            url,
            mode: LaunchMode.externalApplication,
          )
        : throw 'Could not launch maps app';
  }

  @override
  Widget build(BuildContext context) {
    return ListTileWithArrow(
      title: context.getLocalizationOf.findAnOfficeCTA,
      onPress: () {
        openMapApp().catchError(
          (_) => context.showErrorSnackBar(
            text: context.getLocalizationOf.officeLocatorError,
          ),
        );
      },
    );
  }
}
