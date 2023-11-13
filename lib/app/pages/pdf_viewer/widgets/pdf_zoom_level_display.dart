import 'package:pdf_render/pdf_render_widgets.dart';
import 'package:txfb_insurance_flutter/resources/theme/theme.dart';
import 'package:txfb_insurance_flutter/shared/shared.dart';

class PdfZoomLevelDisplay extends StatefulWidget {
  const PdfZoomLevelDisplay({required this.controller, super.key});

  final PdfViewerController controller;

  @override
  State<PdfZoomLevelDisplay> createState() => _PdfZoomLevelDisplayState();
}

class _PdfZoomLevelDisplayState extends State<PdfZoomLevelDisplay> {
  double zoomLevel = 1;

  @override
  void initState() {
    super.initState();
    widget.controller.addListener(() {
      if (widget.controller.zoomRatio != zoomLevel) {
        setState(() {
          zoomLevel = widget.controller.zoomRatio;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Align(
        alignment: Alignment.bottomRight,
        child: GestureDetector(
          onTap: () => widget.controller.setZoomRatio(zoomRatio: 1),
          child: AnimatedOpacity(
            opacity: zoomLevel != 1.0 ? 1 : 0,
            duration: const Duration(milliseconds: 200),
            child: Container(
              margin: const EdgeInsets.symmetric(
                horizontal: kSpacingMedium,
                vertical: kSpacingSmall,
              ),
              decoration: BoxDecoration(
                borderRadius: context.radii.small,
                color: LightColors.darkPrimarySurface,
              ),
              padding: const EdgeInsets.all(kSpacingSmall),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: kSpacingSmall),
                    child: Image.asset(
                      TfbAssetStrings.shrinkIcon,
                      height: 24,
                      width: 24,
                    ),
                  ),
                  const Text(
                    'Reset zoom',
                    style: TextStyle(color: TfbBrandColors.white),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
