import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:txfb_insurance_flutter/app/cubits/contacts/contacts_cubit.dart';
import 'package:txfb_insurance_flutter/app/pages/account/widgets/contact_list.dart';
import 'package:txfb_insurance_flutter/domain/clients/member_lookup_client.dart';
import 'package:txfb_insurance_flutter/domain/models/member_lookup/contact.dart';
import 'package:txfb_insurance_flutter/resources/theme/theme.dart';
import 'package:flutter_gen/gen_l10n/app_localizations_en.dart';
import 'package:txfb_insurance_flutter/shared/widgets/tfb_brand_loading_icon.dart';

import '../../../../widgets/tfb_widget_tester.dart';
import '../account_page_test.dart';

void main() {
  testWidgets(
      'Successful contact API response should show all contacts in list',
      (tester) async {
    final TfbMemberLookupClient mockMemberLookupClient =
        MockMemberLookupClient();

    const testName = 'Liam Mcmains';
    when(() => mockMemberLookupClient.getContacts('')).thenAnswer(
      (invocation) {
        return Future.value([
          Contact(
            contactId: 'contactId',
            miraId: 1234,
            fullName: testName,
            phoneNumber: '123.123.1234',
            textEnabled: false,
            verified: false,
          ),
        ]);
      },
    );
    final contactsCubit =
        ContactsCubit(client: mockMemberLookupClient, memberNumber: '');
    await contactsCubit.request();

    await tester.pumpWidget(
      TfbWidgetTester(
        child: BlocProvider.value(
          value: contactsCubit,
          child: const Scaffold(body: ContactList()),
        ),
      ),
    );

    await tester.pumpAndSettle();

    expect(find.text(testName), findsOneWidget);
  });

  testWidgets('Failed contact API response should show error text',
      (tester) async {
    final TfbMemberLookupClient mockMemberLookupClient =
        MockMemberLookupClient();

    when(() => mockMemberLookupClient.getContacts('')).thenThrow(Exception());

    final contactsCubit =
        ContactsCubit(client: mockMemberLookupClient, memberNumber: '');
    await contactsCubit.request();

    await tester.pumpWidget(
      TfbWidgetTester(
        child: BlocProvider.value(
          value: contactsCubit,
          child: const Scaffold(body: ContactList()),
        ),
      ),
    );

    await tester.pumpAndSettle();

    expect(find.text(AppLocalizationsEn().contactLoadingError), findsOneWidget);
  });

  testWidgets('Contact API processing state shows a loading spinner',
      (tester) async {
    final TfbMemberLookupClient mockMemberLookupClient =
        MockMemberLookupClient();

    when(() => mockMemberLookupClient.getContacts(''))
        .thenAnswer((invocation) async {
      await Future<void>.delayed(const Duration(milliseconds: 100));
      return [];
    });

    final contactsCubit =
        ContactsCubit(client: mockMemberLookupClient, memberNumber: '')
          ..request();

    await tester.pumpWidget(
      TfbWidgetTester(
        child: BlocProvider.value(
          value: contactsCubit,
          child: const Scaffold(body: ContactList()),
        ),
      ),
    );

    expect(find.byType(TfbBrandLoadingIcon), findsOneWidget);

    await tester.pumpAndSettle();
  });
}
