import 'package:pdf_render/pdf_render_widgets.dart';
import 'package:txfb_insurance_flutter/resources/theme/theme.dart';
import 'package:txfb_insurance_flutter/shared/shared.dart';

class PdfCurrentPageDisplay extends StatefulWidget {
  const PdfCurrentPageDisplay({
    required this.controller,
    super.key,
  });

  final PdfViewerController controller;

  @override
  State<PdfCurrentPageDisplay> createState() => _PdfCurrentPageDisplayState();
}

class _PdfCurrentPageDisplayState extends State<PdfCurrentPageDisplay> {
  int currentPage = 0;
  int totalPages = 0;

  @override
  void initState() {
    super.initState();
    widget.controller.addListener(() {
      try {
        final controllerPage = widget.controller.currentPageNumber;
        final localTotalPages = widget.controller.pageCount;

        if (currentPage != controllerPage) {
          setState(() {
            currentPage = controllerPage;
          });
        }

        if (totalPages != localTotalPages) {
          setState(() {
            totalPages = localTotalPages;
          });
        }
      } catch (_) {}
    });
  }

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomLeft,
      child: SafeArea(
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
                  TfbAssetStrings.documentIcon,
                  height: 24,
                  width: 24,
                ),
              ),
              Text(
                '$currentPage / $totalPages',
                style: const TextStyle(color: TfbBrandColors.white),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
