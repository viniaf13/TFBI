import 'package:mocktail/mocktail.dart';
import 'package:txfb_insurance_flutter/app/cubits/status_bar_scroll/cubit/status_bar_scroll_cubit.dart';
import 'package:txfb_insurance_flutter/app/pages/app_info/app_info_page.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:txfb_insurance_flutter/device/environment/tfb_environment_stage.dart';
import 'package:txfb_insurance_flutter/app/pages/app_info/widgets/widgets.dart';

import '../../../mocks/bloc/mock_status_bar_scroll_cubit.dart';
import '../../../widgets/tfb_widget_tester.dart';

void main() {
  group(
    'app_info_page_test',
    () {
      testWidgets(
        'App info page should show the correct widgets',
        (tester) async {
          final mockStatusBarScrollCubit = MockStatusBarScrollCubit();

          when(() => mockStatusBarScrollCubit.state)
              .thenReturn(const StatusBarScrollInitial(''));

          await tester.pumpWidget(
            TfbWidgetTester(
              mockStatusBarScrollCubit: mockStatusBarScrollCubit,
              mockEnvironment: TfbEnvironmentStage(),
              child: const AppInfoPage(),
            ),
          );

          expect(find.byType(AppIcon), findsOneWidget);
          expect(
            find.byType(AppInfoLink, skipOffstage: false),
            findsNWidgets(7),
          );
          expect(find.byType(AppInfoSectionHeader), findsNWidgets(3));
        },
      );
    },
  );
}
