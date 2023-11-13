import 'dart:math';

import 'package:flutter/material.dart';
import 'package:pdf_render/pdf_render_widgets.dart';
import 'package:txfb_insurance_flutter/app/pages/pdf_viewer/widgets/pdf_current_page_display.dart';
import 'package:txfb_insurance_flutter/app/pages/pdf_viewer/widgets/pdf_zoom_level_display.dart';

class PdfViewerPageContent extends StatelessWidget {
  const PdfViewerPageContent({
    required this.filePath,
    required this.controller,
    super.key,
  });

  final String filePath;
  final PdfViewerController controller;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        OrientationBuilder(
          builder: (context, orientation) {
            return PdfViewer.openFile(
              filePath,
              onError: print,
              viewerController: controller,
              params: PdfViewerParams(
                padding: 0,
                maxScale: 5,
                layoutPages: (contentViewSize, pageSizes) => layoutPages(
                  contentViewSize,
                  pageSizes,
                  orientation,
                  context,
                ),
              ),
            );
          },
        ),
        PdfCurrentPageDisplay(controller: controller),
        PdfZoomLevelDisplay(controller: controller),
      ],
    );
  }

  /// Override the default layout computation for the PdfViewer widget so we can
  /// customize the padding depending on the device orientation and SafeArea
  /// edge insets.
  List<Rect> layoutPages(
    Size viewSize,
    List<Size> pages,
    Orientation orientation,
    BuildContext context,
  ) {
    final List<Rect> pageRects = [];

    final isLandscape = orientation == Orientation.landscape;

    const minimumHorizontalPadding = 16.0;
    final safeAreaPadding = max(
      MediaQuery.paddingOf(context).left,
      minimumHorizontalPadding,
    );
    final horizontalPadding = isLandscape ? safeAreaPadding : 8.0;
    const verticalPadding = 8.0;

    var top = isLandscape ? 16.0 : 8.0;
    for (final page in pages) {
      final widthRatio =
          (MediaQuery.sizeOf(context).width - (horizontalPadding * 2)) /
              page.width;

      final pageHeight = page.height * widthRatio;

      pageRects.add(
        Rect.fromLTWH(
          horizontalPadding,
          top,
          page.width * widthRatio,
          pageHeight,
        ),
      );
      top += pageHeight + verticalPadding;
    }
    return pageRects;
  }
}
