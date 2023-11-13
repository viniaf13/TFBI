import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:plugin_haven/plugin_haven.dart';
import 'package:provider/provider.dart';
import 'package:txfb_insurance_flutter/app/pages/account/widgets/logout_confirmation_modal.dart';
import 'package:txfb_insurance_flutter/app/router/router.dart';
import 'package:txfb_insurance_flutter/resources/theme/theme.dart';
import 'package:txfb_insurance_flutter/shared/shared.dart';

import '../../../../mocks/mock_tfb_navigator.dart';
import '../../../../widgets/tfb_widget_tester.dart';

void main() {
  setUp(() {
    registerFallbackValue(AuthInitEvent());
  });

  testWidgets(
      'Tapping the logout button on the logout confirmation modal will call the logout event on the auth bloc ...',
      (tester) async {
    final TfbNavigator mockNavigator = MockTfbNavigator();

    await tester.pumpWidget(
      TfbWidgetTester(
        mockNavigator: mockNavigator,
        child: Builder(
          builder: (context) {
            WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
              showDialog<void>(
                context: context,
                builder: (dialogContext) {
                  // You have to re-provide the same values to the dialog
                  return Provider.value(
                    value: context.navigator,
                    child: Provider.value(
                      value: BlocProvider.of<AuthBloc>(context),
                      child: const LogoutConfirmationDialog(),
                    ),
                  );
                },
              );
            });
            return const SizedBox.shrink();
          },
        ),
      ),
    );

    await tester.pumpAndSettle();
    await tester.tap(find.byType(TfbFilledButton).last);

    verify(() => mockNavigator.goToLoginPage(isLoggingOut: true)).called(1);
  });
}
