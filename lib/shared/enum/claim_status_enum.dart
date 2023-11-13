import 'package:txfb_insurance_flutter/data/data.dart';
import 'package:txfb_insurance_flutter/resources/theme/theme.dart';
import 'package:txfb_insurance_flutter/shared/extensions/extensions.dart';

@JsonEnum(valueField: 'value')
enum ClaimStatusEnum {
  active('OPEN'),
  inactive('CLOSED'),
  undefinedClaimStatus('UNDEFINED');

  const ClaimStatusEnum(this.value);

  final String value;

  String name(BuildContext context) {
    switch (this) {
      case inactive:
        return context.getLocalizationOf.claimsClosed;
      case active:
        return context.getLocalizationOf.claimsActive;
      default:
        return context.getLocalizationOf.undefinedClaimStatus;
    }
  }
}
