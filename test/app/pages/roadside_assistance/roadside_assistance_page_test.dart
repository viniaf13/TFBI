import 'package:flutter_gen/gen_l10n/app_localizations_en.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:txfb_insurance_flutter/app/cubits/status_bar_scroll/cubit/status_bar_scroll_cubit.dart';
import 'package:txfb_insurance_flutter/app/pages/roadside_assistance/roadside_assistance_page.dart';
import 'package:txfb_insurance_flutter/app/pages/roadside_assistance/widgets/roadside_assistance_details.dart';
import 'package:txfb_insurance_flutter/app/pages/roadside_assistance/widgets/roadside_assistance_header.dart';

import '../../../mocks/bloc/mock_status_bar_scroll_cubit.dart';
import '../../../widgets/tfb_widget_tester.dart';

void main() {
  testWidgets('TipsInfoPage renders correctly', (WidgetTester tester) async {
    final mockStatusBarScrollCubit = MockStatusBarScrollCubit();
    when(() => mockStatusBarScrollCubit.state)
        .thenReturn(const StatusBarScrollInitial(''));

    await tester.pumpWidget(
      TfbWidgetTester(
        mockStatusBarScrollCubit: mockStatusBarScrollCubit,
        child: const RoadsideAssistancePage(),
      ),
    );

    await tester.pumpAndSettle();

    expect(find.byType(RoadsideAssistanceHeader), findsOneWidget);
    expect(find.byType(RoadsideAssistanceDetails), findsOneWidget);

    expect(
      find.text(
        AppLocalizationsEn().roadsideAssistanceTipsInfoInvolvedInAccident,
      ),
      findsOneWidget,
    );
    expect(
      find.text(
        AppLocalizationsEn().roadsideAssistanceTipsInfoFileAClaim,
      ),
      findsOneWidget,
    );
  });
}
