import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pdf_render/pdf_render_widgets.dart';
import 'package:share_plus/share_plus.dart';
import 'package:txfb_insurance_flutter/app/analytics/analytics.dart';
import 'package:txfb_insurance_flutter/app/pages/pdf_viewer/widgets/pdf_viewer_page_content.dart';
import 'package:txfb_insurance_flutter/resources/theme/colors/colors.dart';
import 'package:txfb_insurance_flutter/shared/shared.dart';

class TfbPdfViewer extends StatefulWidget {
  const TfbPdfViewer({
    required this.title,
    required this.filePath,
    required this.pdfViewerEventsParameters,
    this.isLoading = true,
    this.isError = false,
    this.isSuccess = false,
    super.key,
  });

  final String title;
  final String filePath;
  final bool isLoading;
  final bool isError;
  final bool isSuccess;

  final PdfViewerEventsParameters pdfViewerEventsParameters;

  @override
  State<TfbPdfViewer> createState() => _TfbPdfViewerState();
}

class _TfbPdfViewerState extends State<TfbPdfViewer> {
  PdfViewerController controller = PdfViewerController();
  GlobalKey pdfViewerKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
    ]);
  }

  @override
  void dispose() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScaffoldMessenger(
      child: Builder(
        builder: (context) {
          if (widget.isError) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              context.showErrorSnackBar(
                text: context.getLocalizationOf.somethingWentWrong,
              );
            });
          }

          return Scaffold(
            appBar: AppBar(
              centerTitle: true,
              title: Text(
                widget.title,
                style: context.tfbText.bodyLightLarge.copyWith(
                  color: TfbBrandColors.white,
                ),
              ),
              automaticallyImplyLeading: false,
              leading: IconButton(
                icon: Image.asset(
                  TfbAssetStrings.appBarBackButtonArrow,
                  height: 28,
                  width: 28,
                ),
                onPressed: () => Navigator.maybePop(context),
              ),
              backgroundColor: LightColors.darkPrimarySurface,
              systemOverlayStyle: const SystemUiOverlayStyle(
                statusBarIconBrightness: Brightness.light,
                statusBarBrightness: Brightness.dark,
              ),
              actions: (widget.isSuccess)
                  ? [
                      IconButton(
                        onPressed: () async {
                          final shareResult = await Share.shareXFiles(
                            [XFile(widget.filePath)],
                          );

                          TfbAnalytics.instance.track(
                            ShareDocumentEvent(
                              screenName:
                                  widget.pdfViewerEventsParameters.screenName,
                              cta: widget.pdfViewerEventsParameters.cta,
                              shareResult: shareResult.status.name,
                            ),
                          );
                        },
                        icon: Image.asset(
                          TfbAssetStrings.shareIcon,
                          height: 24,
                          width: 24,
                        ),
                      ),
                    ]
                  : [],
            ),
            body: DecoratedBox(
              decoration: const BoxDecoration(
                gradient: LightColors.darkBlueGradient,
              ),
              child: (widget.isLoading)
                  ? const Center(child: TfbLoadingOverlay())
                  : (widget.isSuccess)
                      ? PdfViewerPageContent(
                          filePath: widget.filePath,
                          controller: controller,
                        )
                      : Container(),
            ),
          );
        },
      ),
    );
  }
}

class PdfViewerPageParameters {
  PdfViewerPageParameters({
    required this.title,
    required this.filePath,
    required this.pdfViewerEventsParameters,
  });

  String title;
  String filePath;

  PdfViewerEventsParameters pdfViewerEventsParameters;
}

class PdfViewerEventsParameters {
  PdfViewerEventsParameters({
    this.screenName = 'Undefined',
    this.cta = 'Undefined',
  });

  final String screenName;
  final String cta;
}
