import 'package:intl/intl.dart';
import 'package:txfb_insurance_flutter/domain/models/claims/claim_details/claim_details.dart';
import 'package:txfb_insurance_flutter/domain/models/claims/claims_list/claim.dart';
import 'package:txfb_insurance_flutter/shared/constants/strings.dart';
import 'package:txfb_insurance_flutter/shared/extensions/extensions.dart';
import 'package:txfb_insurance_flutter/shared/utils/tfb_logger.dart';
import 'package:txfb_insurance_flutter/domain/models/claims/domain_models/full_claim.dart';

extension FullClaims on Claim {
  FullClaim toFullClaim(ClaimDetails details) {
    return FullClaim(
      claimNumber: claimNumber,
      statusEnum: claimStatus,
      policyNumber: policyNumber,
      policyType: policyType,
      dateOfLoss: parseDate(dateOfLoss),
      claimDetails: details,
    );
  }

  String parseDate(String? date) {
    final format1 = DateFormat(kAlternateDateFormat);
    final format2 = DateFormat(kDateFormat);
    final outputFormat = DateFormat(kUiDateFormat);

    DateTime? parsedDate;

    if (date != null) {
      try {
        parsedDate = format1.parseStrict(date);
      } catch (e) {
        if (e is FormatException) {
          try {
            parsedDate = format2.parseStrict(date);
          } catch (e) {
            if (e is FormatException) {
              TfbLogger.exception(
                '[toFullClaim.parseDate] $kInvalidDateFormat $date',
              );
            } else {
              rethrow;
            }
          }
        } else {
          rethrow;
        }
      }
    }

    if (parsedDate != null) {
      return outputFormat.format(parsedDate);
    }

    return kUnknownDateFormat;
  }
}

extension FullClaimHelpers on FullClaim {
  String formatRepresentativeName() {
    final assignments =
        claimDetails?.claimAssignments?.importAssignmentDTO?.firstOrNull;
    final firstName = assignments?.userFirstName?.trim().toCapitalized();
    final lastName = assignments?.userLastName?.trim().toCapitalized();

    return '$firstName $lastName';
  }
}
