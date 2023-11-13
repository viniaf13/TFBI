part of 'dashboard.dart';

class DashboardSection extends StatelessWidget {
  const DashboardSection({
    required this.title,
    required this.content,
    this.trailing,
    super.key,
  });

  final String title;
  final Widget content;
  final Widget? trailing;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.only(
                left: 24,
                bottom: 8,
              ),
              child: Text(
                title,
                style: context.tfbText.header3
                    .copyWith(color: TfbBrandColors.white),
              ),
            ),
            if (trailing != null) trailing!,
          ],
        ),
        content,
      ],
    );
  }
}
