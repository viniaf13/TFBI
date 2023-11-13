import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations_en.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:plugin_haven/plugin_haven.dart';
import 'package:txfb_insurance_flutter/app/cubits/contacts/contacts_cubit.dart';
import 'package:txfb_insurance_flutter/app/cubits/delete_account/delete_account_cubit.dart';
import 'package:txfb_insurance_flutter/app/cubits/status_bar_scroll/cubit/status_bar_scroll_cubit.dart';
import 'package:txfb_insurance_flutter/app/pages/account/account_page.dart';
import 'package:txfb_insurance_flutter/shared/widgets/list_tile_with_arrow.dart';
import 'package:txfb_insurance_flutter/app/pages/account/widgets/logout_confirmation_modal.dart';
import 'package:txfb_insurance_flutter/domain/clients/member_lookup_client.dart';
import 'package:txfb_insurance_flutter/domain/clients/tfb_member_access_client.dart';

import '../../../device/tfb_secure_storage_test.dart';
import '../../../mocks/bloc/mock_auth_bloc.dart';
import '../../../mocks/bloc/mock_status_bar_scroll_cubit.dart';
import '../../../mocks/mock_member_access_client.dart';
import '../../../widgets/tfb_widget_tester.dart';

class MockMemberLookupClient extends Mock implements TfbMemberLookupClient {}

void main() {
  late TfbMemberAccessClient mockMemberAccessClient;

  late TfbMemberLookupClient mockLookupClient;
  late AuthBloc mockAuthBloc;
  final mockStatusBarScrollCubit = MockStatusBarScrollCubit();

  setUp(
    () {
      mockMemberAccessClient = MockMemberAccessClient();
      mockLookupClient = MockMemberLookupClient();
      mockAuthBloc = MockAuthBloc();
      when(() => mockAuthBloc.state).thenReturn(AuthSignedIn(testUser));
      when(() => mockLookupClient.getContacts(any()))
          .thenAnswer((invocation) => Future.value([]));
      when(() => mockStatusBarScrollCubit.state)
          .thenReturn(const StatusBarScrollInitial(''));
    },
  );
  testWidgets(
      'Tapping on the sign out button on the account page will display the logout confirmation modal.',
      (tester) async {
    final TfbMemberAccessClient mockMemberAccessClient =
        MockMemberAccessClient();

    final TfbMemberLookupClient mockLookupClient = MockMemberLookupClient();
    final AuthBloc mockAuthBloc = MockAuthBloc();
    when(() => mockAuthBloc.state).thenReturn(AuthSignedIn(testUser));
    when(() => mockLookupClient.getContacts(any()))
        .thenAnswer((invocation) => Future.value([]));

    await tester.pumpWidget(
      TfbWidgetTester(
        mockStatusBarScrollCubit: mockStatusBarScrollCubit,
        mockAuthBloc: mockAuthBloc,
        child: MultiBlocProvider(
          providers: [
            BlocProvider<DeleteAccountCubit>(
              create: (context) => DeleteAccountCubit(
                memberAccessClient: mockMemberAccessClient,
              ),
            ),
            BlocProvider(
              create: (context) => ContactsCubit(
                client: mockLookupClient,
                memberNumber: '',
              ),
            ),
          ],
          child: const AccountPage(),
        ),
      ),
    );

    await tester.scrollUntilVisible(
      find.text('Log out'),
      100,
    );
    await tester.pump();

    await tester.tap(
      find.byWidgetPredicate(
        (widget) =>
            widget is ListTileWithArrow &&
            widget.title == AppLocalizationsEn().myAccountLogoutCTA,
      ),
    );

    await tester.pump();

    expect(find.byType(LogoutConfirmationDialog), findsOneWidget);
  });

  testWidgets(
      'Test to verify if the contact update text is appearing correctly.',
      (tester) async {
    await tester.pumpWidget(
      TfbWidgetTester(
        mockAuthBloc: mockAuthBloc,
        mockStatusBarScrollCubit: mockStatusBarScrollCubit,
        child: MultiBlocProvider(
          providers: [
            BlocProvider<DeleteAccountCubit>(
              create: (context) => DeleteAccountCubit(
                memberAccessClient: mockMemberAccessClient,
              ),
            ),
            BlocProvider(
              create: (context) => ContactsCubit(
                client: mockLookupClient,
                memberNumber: '',
              ),
            ),
          ],
          child: const AccountPage(),
        ),
      ),
    );

    expect(
      find.text(AppLocalizationsEn().communicationPreferencesBody),
      findsOneWidget,
    );
  });
}
