import 'package:flutter_test/flutter_test.dart';

import '../../mocks/mock_context_provider.dart';

void main() {
  test('getBaseUrl returns the correct URL', () {
    final mockContext = MockBuildContext();
    expect(mockContext.getBaseUrl, 'https://webstg.txfb-ins.com/');
  });
}
