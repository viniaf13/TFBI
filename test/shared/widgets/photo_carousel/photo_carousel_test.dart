import 'package:cross_file/cross_file.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:txfb_insurance_flutter/resources/theme/theme.dart';
import 'package:txfb_insurance_flutter/shared/constants/tfb_asset_strings.dart';
import 'package:txfb_insurance_flutter/shared/widgets/photo_carousel/photo_carousel.dart';

import '../../../widgets/tfb_widget_tester.dart';

void main() {
  testWidgets(
    'photo carousel should display remove button when onRemove is not null',
    (tester) async {
      await tester.runAsync(() async {
        final images = [
          XFile(TfbAssetStrings.accountIcon),
        ];
        await tester.pumpWidget(
          TfbWidgetTester(
            child: Scaffold(
              body: PhotoCarousel(
                images: images,
                onRemove: (_) {},
              ),
            ),
          ),
        );
        await tester.pumpAndSettle();
        expect(
          find.byWidgetPredicate(
            (w) => w is Image && w.height == 20 && w.width == 20,
          ),
          findsNWidgets(1),
        );
      });
    },
  );

  testWidgets(
    'photo carousel should NOT display remove button when onRemove is not null',
    (tester) async {
      await tester.runAsync(() async {
        final images = [
          XFile(TfbAssetStrings.accountIcon),
        ];
        await tester.pumpWidget(
          TfbWidgetTester(
            child: Scaffold(
              body: PhotoCarousel(
                images: images,
              ),
            ),
          ),
        );
        await tester.pumpAndSettle();
        expect(
          find.byWidgetPredicate(
            (w) => w is Image && w.height == 20 && w.width == 20,
          ),
          findsNWidgets(0),
        );
      });
    },
  );

  testWidgets(
    'On press remove button, should call callback function with image to remove',
    (tester) async {
      await tester.runAsync(() async {
        final images = [
          XFile(TfbAssetStrings.accountIcon),
        ];
        var callbackWasCalled = false;
        await tester.pumpWidget(
          TfbWidgetTester(
            child: Scaffold(
              body: PhotoCarousel(
                images: images,
                onRemove: (image) {
                  if (images.contains(image)) {
                    callbackWasCalled = true;
                  }
                },
              ),
            ),
          ),
        );
        await tester.pumpAndSettle();
        await tester.tap(
          find.byWidgetPredicate(
            (w) => w is Image && w.height == 20 && w.width == 20,
          ),
        );
        await tester.pumpAndSettle();
        expect(callbackWasCalled, isTrue);
      });
    },
  );
}
