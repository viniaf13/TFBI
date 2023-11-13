part of '../dashboard.dart';

class SupportDashSection extends DashboardSection {
  const SupportDashSection({
    required this.sectionTitle,
    required this.horizontalPadding,
    super.key,
  }) : super(
          title: sectionTitle,
          content: const Column(
            children: [
              CustomerServiceCardButton(),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: kSpacingSmall),
                child: AgentCard(),
              ),
            ],
          ),
        );
  final String sectionTitle;
  final double horizontalPadding;
}

class SupportSection extends StatelessWidget {
  const SupportSection({super.key});

  @override
  Widget build(BuildContext context) {
    final String? memberNumber = context.getUserMemberNumber;
    context.read<AgentCubit>().getAgent(memberNumber);
    return _DashboardSpacer(
      child: Padding(
        padding: const EdgeInsets.only(
          bottom: kSpacingMedium,
        ),
        child: SupportDashSection(
          sectionTitle: context.getLocalizationOf.supportSectionTitle,
          horizontalPadding: kSpacingSmall,
        ),
      ),
    );
  }
}
