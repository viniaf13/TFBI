import 'package:flutter/material.dart';
import 'package:mocktail/mocktail.dart';
import 'package:provider/provider.dart';
import 'package:txfb_insurance_flutter/domain/models/policy/member_summary.dart';
import 'package:txfb_insurance_flutter/domain/repositories/tfb_policy_lookup_repository.dart';

import '../mocks/mock_tfb_policy_lookup_repository.dart';

class MockPolicyLookupRepositoryProvider extends StatelessWidget {
  const MockPolicyLookupRepositoryProvider({required this.child, super.key});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    final TfbPolicyLookupRepository mockLookupRepository =
        MockTfbPolicyLookupRepository();

    when(mockLookupRepository.getMemberSummary)
        .thenAnswer((invocation) => Future.value(MemberSummary(policies: [])));

    return Provider.value(
      value: mockLookupRepository,
      child: child,
    );
  }
}
