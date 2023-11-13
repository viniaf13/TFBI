part of 'dashboard.dart';

class DashboardHeader extends StatelessWidget {
  const DashboardHeader({required this.user, super.key});

  final TfbUser user;

  String _getTextWelcome(String welcomeTitle) {
    String str = welcomeTitle;
    if (!user.getFirstName.isNullOrEmpty) {
      str += ', ${user.getFirstName.toTitleCase()}';
    }
    return str;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: kSpacingMedium,
            vertical: kSpacingSmall,
          ),
          child: Image.asset(
            TfbAssetStrings.tfbiLogoDashboard,
            height: 60,
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: kSpacingLarge,
            vertical: kSpacingMedium,
          ),
          child: Text(
            _getTextWelcome(context.getLocalizationOf.dashboardWelcomeTitle),
            overflow: TextOverflow.ellipsis,
            style: context.tfbText.header3.copyWith(
              height: 1,
              color: TfbBrandColors.blueHighest,
            ),
          ),
        ),
        const SizedBox(
          height: kSpacingExtraSmall,
        ),
      ],
    );
  }
}
