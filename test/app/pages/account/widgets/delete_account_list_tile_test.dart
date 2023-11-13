import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:txfb_insurance_flutter/app/cubits/delete_account/delete_account_cubit.dart';
import 'package:txfb_insurance_flutter/app/pages/account/widgets/delete_account_confirmation_modal.dart';
import 'package:txfb_insurance_flutter/app/pages/account/widgets/delete_account_list_tile.dart';

import '../../../../widgets/tfb_widget_tester.dart';

class MockDeleteAccountCubit
    extends MockBloc<DeleteAccountCubit, DeleteAccountState>
    implements DeleteAccountCubit {}

void main() {
  testWidgets(
      'Tapping on the delete account list tile should show the delete account modal',
      (tester) async {
    final DeleteAccountCubit mockBloc = MockDeleteAccountCubit();
    when(() => mockBloc.state)
        .thenAnswer((invocation) => DeleteAccountInitial());

    await tester.pumpWidget(
      TfbWidgetTester(
        child: Scaffold(
          body: BlocProvider.value(
            value: mockBloc,
            child: const DeleteAccountListTile(),
          ),
        ),
      ),
    );

    await tester.tap(find.byType(DeleteAccountListTile));
    await tester.pumpAndSettle();

    expect(find.byType(DeleteAccountConfirmationModal), findsOneWidget);
  });
}
