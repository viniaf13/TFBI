import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations_en.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:txfb_insurance_flutter/app/pages/roadside_assistance/widgets/roadside_assistance_header.dart';
import 'package:txfb_insurance_flutter/shared/constants/strings.dart';
import 'package:txfb_insurance_flutter/shared/widgets/separator_line.dart';
import 'package:txfb_insurance_flutter/shared/widgets/text_with_phone.dart';

import '../../../../widgets/tfb_widget_tester.dart';

void main() {
  testWidgets('TipsInfoHeader renders correctly', (WidgetTester tester) async {
    await tester.pumpWidget(
      const TfbWidgetTester(
        child: RoadsideAssistanceHeader(),
      ),
    );

    await tester.pumpAndSettle();

    expect(find.byType(SeparatorLine), findsNWidgets(2));
    expect(find.byType(Image), findsNWidgets(3));
    expect(find.byType(TextWithPhone), findsOneWidget);

    expect(
      find.text(AppLocalizationsEn().roadsideAssistanceTitle),
      findsOneWidget,
    );
    expect(
      find.text(AppLocalizationsEn().roadsideAssistanceTipsInfoHeaderMessage),
      findsOneWidget,
    );
    expect(
      find.text(
        AppLocalizationsEn().roadsideAssistanceTipsInfoSubHeaderMessage,
      ),
      findsOneWidget,
    );
    expect(
      find.text(
        AppLocalizationsEn().roadsideAssistanceTipsInfoCallForAssistance,
      ),
      findsOneWidget,
    );
    expect(
      find.text(
        AppLocalizationsEn().roadsideAssistanceTipsInfoRequestServiceOnline,
      ),
      findsOneWidget,
    );
    expect(
      find.text(kRequestAssistancePhoneDialing.replaceAll(RegExp(r'\D'), '')),
      findsOneWidget,
    );
    expect(
      find.text(kRequestAssistanceServiceOnline),
      findsOneWidget,
    );
  });
}
