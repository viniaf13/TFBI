import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:plugin_haven/plugin_haven.dart';
import 'package:txfb_insurance_flutter/app/cubits/wallet/wallet_cubit.dart';
import 'package:txfb_insurance_flutter/app/pages/policy_detail/widgets/wallet_button.dart';
import 'package:txfb_insurance_flutter/domain/domain.dart';
import 'package:txfb_insurance_flutter/resources/theme/theme.dart';

import '../../../../widgets/tfb_widget_tester.dart';

void main() {
  const mockPolicyNumber = '11454247';

  final AutoPolicyDetail mockSixMonthAutoPolicy = AutoPolicyDetail(
    policyType: '',
    policySubType: '',
    policySymbol: '',
    policyAddress: Address(
      '',
      '',
      '',
      '',
      '',
      '',
      '',
      '',
    ),
    policyBilling: PolicyBilling(
      '',
      '',
      '',
      '',
      '',
      '',
      '',
      [],
      '',
      '',
      '',
    ),
    policyNumber: mockPolicyNumber,
    policyDescription: '',
    effectiveDate: '',
    expirationDate: '',
  );

  WalletCardPlatform.instance = GoogleWalletCard();

  testWidgets(
    'WalletButton widget test',
    (WidgetTester tester) async {
      final walletCubit = WalletCubit();
      await tester.pumpWidget(
        TfbWidgetTester(
          child: Scaffold(
            body: BlocProvider<WalletCubit>(
              create: (_) => walletCubit,
              child: WalletButton(policyDetails: mockSixMonthAutoPolicy),
            ),
          ),
        ),
      );

      final foundButton = find.byType(WalletButton);
      final WalletButton walletButton = tester.widget(foundButton);

      expect(foundButton, findsOneWidget);
      expect(walletButton.policyDetails.policyNumber, mockPolicyNumber);
    },
  );

  testWidgets('WalletButton displays error message',
      (WidgetTester tester) async {
    final walletCubit = WalletCubit();
    await tester.pumpWidget(
      TfbWidgetTester(
        child: BlocProvider<WalletCubit>(
          create: (_) => walletCubit,
          child: Scaffold(
            body: WalletButton(policyDetails: mockSixMonthAutoPolicy),
          ),
        ),
      ),
    );

    walletCubit.emit(const WalletFailure('Error'));

    await tester.pump();

    final snackBarFinder = find.byType(SnackBar);

    await tester.pumpAndSettle();

    expect(snackBarFinder, findsOneWidget);
  });
}
