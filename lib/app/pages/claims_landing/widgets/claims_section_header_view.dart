import 'package:txfb_insurance_flutter/resources/theme/theme.dart';
import 'package:txfb_insurance_flutter/shared/shared.dart';

/// The sections in the claims list are for for the active & history
/// components. No other headers are possible in this list.
enum ClaimsSection {
  active,
  history;

  String displayTitle(BuildContext context) {
    switch (this) {
      case active:
        return context.getLocalizationOf.claimsActiveSectionHeader;
      case history:
        return context.getLocalizationOf.claimsHistorySectionHeader;
    }
  }
}

class ClaimsSectionHeaderView extends StatelessWidget {
  const ClaimsSectionHeaderView(this.sectionType, {super.key});

  final ClaimsSection sectionType;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: kSpacingSmall,
      ),
      child: Text(
        sectionType.displayTitle(context),
        style: context.tfbText.header3.copyWith(color: LightColors.textDark),
      ),
    );
  }
}
