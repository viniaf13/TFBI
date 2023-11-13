import 'package:flutter_test/flutter_test.dart';
import 'package:txfb_insurance_flutter/app/pages/dashboard/dashboard.dart';
import 'package:txfb_insurance_flutter/shared/extensions/extensions.dart';

import '../../../../mocks/mock_context_provider.dart';
import '../../../../mocks/mock_tfb_user.dart';
import '../../../../widgets/tfb_widget_tester.dart';

void main() {
  late MockTfbUser user;
  late MockTfbUserWithoutName userWithoutName;
  late MockBuildContext context;

  setUp(() {
    user = MockTfbUser();
    userWithoutName = MockTfbUserWithoutName();
    context = MockBuildContext();
  });

  testWidgets('Dashboard header with the first name', (tester) async {
    var text = context.getLocalizationOf.dashboardWelcomeTitle;
    text += ', ${user.getFirstName.toTitleCase()}';

    await tester.pumpWidget(
      TfbWidgetTester(
        child: DashboardHeader(
          user: user,
        ),
      ),
    );

    expect(
      find.text(text),
      findsOneWidget,
    );
  });
  testWidgets('Dashboard header without the first name', (tester) async {
    final text = context.getLocalizationOf.dashboardWelcomeTitle;

    await tester.pumpWidget(
      TfbWidgetTester(
        child: DashboardHeader(
          user: userWithoutName,
        ),
      ),
    );

    expect(
      find.text(text),
      findsOneWidget,
    );
  });
}
