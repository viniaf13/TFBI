import 'package:plugin_haven/plugin_haven.dart';
import 'package:test/test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:txfb_insurance_flutter/app/cubits/wallet/wallet_cubit.dart';
import 'package:txfb_insurance_flutter/domain/domain.dart';

import '../../../domain/models/policy/mock_google_wallet_card.dart';
import '../../../mocks/mock_policy_lookup_client.dart';
import '../../../mocks/mock_vehicle.dart';

void main() {
  group('WalletCubit', () {
    late WalletCubit walletCubit;
    late AutoPolicyDetail details;
    late MockGoogleWalletCard googleCardMock;

    setUp(() {
      walletCubit = WalletCubit();
      googleCardMock = MockGoogleWalletCard();
      WalletCardPlatform.instance = googleCardMock;
      final AutoPolicyDetail mockPolicyDetails =
          MockPolicy.createAutoPolicyDetail();
      details = AutoPolicyDetail(
        policyType: mockPolicyDetails.policyType,
        policySubType: mockPolicyDetails.policySubType,
        policySymbol: mockPolicyDetails.policySymbol,
        policyAddress: mockPolicyDetails.policyAddress,
        policyBilling: mockPolicyDetails.policyBilling,
        policyNumber: mockPolicyDetails.policyNumber,
        policyDescription: mockPolicyDetails.policyDescription,
        effectiveDate: mockPolicyDetails.effectiveDate,
        expirationDate: mockPolicyDetails.expirationDate,
        vehicles: [
          MockVehicles.generateRandomVehicle(),
        ],
      );
    });

    tearDown(() {
      walletCubit.close();
    });

    test('initial state should be WalletInitial', () {
      expect(walletCubit.state, equals(WalletInitial()));
    });

    blocTest<WalletCubit, WalletState>(
      'walletCubit emits WalletProcessing and WalletSuccess when passId is not empty',
      build: () => walletCubit,
      act: (cubit) async {
        await cubit.handleAddWallet(details);
      },
      expect: () => [
        isA<WalletProcessing>(),
        isA<WalletSuccess>(),
      ],
    );

    blocTest<WalletCubit, WalletState>(
      'walletCubit emits WalletError when passId is empty',
      build: () => walletCubit,
      setUp: () => googleCardMock.passId = '',
      act: (cubit) async {
        await cubit.handleAddWallet(details);
      },
      expect: () => [
        isA<WalletProcessing>(),
        isA<WalletFailure>(),
      ],
    );
  });
}
