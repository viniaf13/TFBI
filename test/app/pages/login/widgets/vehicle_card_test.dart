import 'package:flutter_test/flutter_test.dart';
import 'package:txfb_insurance_flutter/app/analytics/events/insurance_card_event.dart';
import 'package:txfb_insurance_flutter/app/analytics/tfb_analytics.dart';
import 'package:txfb_insurance_flutter/app/pages/login/widgets/vehicle_card.dart';
import 'package:txfb_insurance_flutter/shared/widgets/tfb_filled_button.dart';

import '../../../../mocks/mock_tfb_flat_auto_policy_document_metadata.dart';
import '../../../../widgets/tfb_widget_tester.dart';
import '../../../analytics/mock_analytics_provider.dart';

void main() {
  late MockAnalyticsProvider mockAnalyticsProvider;

  setUpAll(() {
    mockAnalyticsProvider = MockAnalyticsProvider();
    TfbAnalytics.instance.add(mockAnalyticsProvider);
    TfbAnalytics.instance.init(const TfbAnalyticsConfig());
  });

  testWidgets('Test TfbAnalytics track ViewIdCardEvent',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      TfbWidgetTester(
        child: VehicleCard(
          policyDocumentMetadata: MockTfbFlatAutoPolicyDocumentMetadata
              .getAutoPolicyDocumentMetadata(),
        ),
      ),
    );

    final button = find.byType(TfbFilledButton);

    await tester.tap(button);
    await tester.pump();

    final event =
        mockAnalyticsProvider.loggedEvents.whereType<ViewIdCardEvent>().first;

    expect(event.name, kViewIdCardEvent);
  });
}
