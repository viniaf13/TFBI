import 'package:txfb_insurance_flutter/resources/theme/theme.dart';
import 'package:txfb_insurance_flutter/shared/shared.dart';

class PageViewControls extends StatelessWidget {
  const PageViewControls({
    required this.pageViewController,
    required this.currentPage,
    required this.maxPages,
    required this.showPageCount,
    super.key,
  });

  final PageController pageViewController;
  final num currentPage;
  final int maxPages;
  final bool showPageCount;

  @override
  Widget build(BuildContext context) {
    final disableLeftButton = currentPage == 1;
    final disableRightButton = currentPage == maxPages;

    return Padding(
      padding: const EdgeInsets.only(bottom: kSpacingSmall),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            onPressed: disableLeftButton
                ? null
                : () {
                    pageViewController.previousPage(
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeOut,
                    );
                  },
            icon: ImageIcon(
              AssetImage(TfbAssetStrings.basicArrowLeft),
              color: disableLeftButton
                  ? TfbBrandColors.grayMedium
                  : TfbBrandColors.blueHighest,
            ),
          ),
          if (showPageCount)
            Text(
              context.getLocalizationOf.pageDisplay(
                currentPage,
                maxPages,
              ),
              style: context.tfbText.bodyRegularSmall.copyWith(
                color: TfbBrandColors.blueHighest,
              ),
            ),
          IconButton(
            onPressed: disableRightButton
                ? null
                : () {
                    pageViewController.nextPage(
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeInOut,
                    );
                  },
            icon: ImageIcon(
              AssetImage(TfbAssetStrings.basicArrowRight),
              color: disableRightButton
                  ? TfbBrandColors.grayMedium
                  : TfbBrandColors.blueHighest,
            ),
          ),
        ],
      ),
    );
  }
}
