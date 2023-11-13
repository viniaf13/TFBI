import 'package:flutter/material.dart';
import 'package:txfb_insurance_flutter/resources/theme/colors/colors.dart';
import 'package:txfb_insurance_flutter/shared/shared.dart';

class HowClaimsWorkSection extends StatelessWidget {
  const HowClaimsWorkSection({super.key});

  @override
  Widget build(
    BuildContext context,
  ) {
    return Card(
      margin: const EdgeInsets.all(0),
      child: Padding(
        padding: const EdgeInsets.only(
          left: kSpacingMedium,
          top: kSpacingMedium,
          right: kSpacingMedium,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              context.getLocalizationOf.howClaimsWork,
              style: context.tfbText.header3.copyWith(
                color: TfbBrandColors.blueHighest,
                height: 1,
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(
                vertical: kSpacingMedium,
              ),
              child: Divider(
                height: 1,
                color: TfbBrandColors.grayMedium,
              ),
            ),
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TimelineSection(
                  title: context.getLocalizationOf.claimsTimeLineFileTitle,
                  body: context.getLocalizationOf.claimsTimeLineFileDescription,
                ),
                TimelineSection(
                  title:
                      context.getLocalizationOf.claimsTimeLineShareDetailsTitle,
                  body: context
                      .getLocalizationOf.claimsTimeLineShareDetailsDescription,
                ),
                TimelineSection(
                  title: context
                      .getLocalizationOf.claimsTimeLineGetAnEstimateTitle,
                  body: context
                      .getLocalizationOf.claimsTimeLineGetAnEstimateDescription,
                ),
                TimelineSection(
                  title: context.getLocalizationOf.claimsTimeLineResolveTitle,
                  body: context
                      .getLocalizationOf.claimsTimeLineResolveDescription,
                  showLine: false,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class TimelineSection extends StatelessWidget {
  const TimelineSection({
    required this.title,
    required this.body,
    this.showLine = true,
    super.key,
  });

  final String title;
  final String body;
  final bool showLine;

  @override
  Widget build(BuildContext context) {
    final GlobalKey containerKey = GlobalKey();

    return Padding(
      padding: const EdgeInsets.only(
        bottom: kSpacingMedium,
      ),
      child: Row(
        key: containerKey,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(
              right: kSpacingMedium,
              top: kSpacingExtraSmall,
            ),
            child: Column(
              children: [
                Container(
                  width: 17.05,
                  height: 17.05,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: LinearGradient(
                      begin: FractionalOffset.bottomLeft,
                      end: FractionalOffset.topRight,
                      colors: [
                        TfbBrandColors.blueHighest,
                        TfbBrandColors.blueHigh,
                      ],
                    ),
                  ),
                ),
                if (showLine) LineComponent(containerKey: containerKey),
              ],
            ),
          ),
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: kSpacingExtraSmall),
                  child: Text(
                    title,
                    style: context.tfbText.subHeaderLight
                        .copyWith(color: TfbBrandColors.blueHighest),
                  ),
                ),
                Text(
                  body,
                  style: context.tfbText.bodyRegularSmall,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class LineComponent extends StatelessWidget {
  const LineComponent({required this.containerKey, super.key});

  final GlobalKey containerKey;

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: LinePainter(containerKey: containerKey),
    );
  }
}

class LinePainter extends CustomPainter {
  LinePainter({required this.containerKey});

  GlobalKey containerKey;

  double getRowHeight() {
    final renderObject = containerKey.currentContext?.findRenderObject();
    if (renderObject == null) {
      return 0;
    }
    final RenderBox renderBox = renderObject as RenderBox;
    final height = renderBox.size.height;
    return height;
  }

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = TfbBrandColors.blueHighest
      ..strokeWidth = 2.0;

    const startPoint = Offset(0, 0);
    final endPoint = Offset(size.width, getRowHeight());

    canvas.drawLine(startPoint, endPoint, paint);
  }

  @override
  bool shouldRepaint(LinePainter oldDelegate) => false;
}
