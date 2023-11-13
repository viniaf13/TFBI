part of '../dashboard.dart';

class QuickAccessSection extends DashboardSection {
  const QuickAccessSection({required this.sectionTitle, super.key})
      : super(
          title: sectionTitle,
          content: const QuickAccessSectionBody(),
        );

  final String sectionTitle;
}

class QuickAccessSectionBody extends StatelessWidget {
  const QuickAccessSectionBody({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: kSpacingMedium),
      child: Row(
        children: [
          QuickAccessRoadsideAssistance(),
          SizedBox(width: kSpacingSmall),
          QuickAccessInsuranceCard(),
        ],
      ),
    );
  }
}
