import 'package:txfb_insurance_flutter/domain/models/claims/file_a_claim/policy_selection.dart';
import 'package:txfb_insurance_flutter/domain/models/claims/file_a_claim/property_claim/submit_claim_property.dart';
import 'package:txfb_insurance_flutter/domain/models/claims/file_a_claim/property_claim/submit_claim_property_primary_insured.dart';
import 'package:txfb_insurance_flutter/domain/models/claims/file_a_claim/shared/submit_claim_loss_info.dart';
import 'package:txfb_insurance_flutter/domain/models/claims/file_a_claim/shared/submit_claim_name.dart';
import 'package:txfb_insurance_flutter/domain/models/claims/file_a_claim/shared/submit_claim_reporter_info.dart';
import 'package:txfb_insurance_flutter/domain/models/policy/policy_summary.dart';

abstract class MockPropertyClaim {
  static PolicySelection getPropertyPolicySelection() {
    return PolicySelection(
      insuredName: 'John Doe',
      policyNumber: '12345678',
      policyType: PolicyType.homeowners,
      policySymbol: 'HO6',
    );
  }

  static PropertyClaimSubmission getPropertyClaim() {
    return const PropertyClaimSubmission(
      claimDestination: 1,
      claimType: '1',
      policyNumber: '41115981',
      hasPhotos: 'N',
      primaryInsured: PropertyPrimaryInsured(
        name: SubmitClaimName(
          firstName: 'DELVON',
          lastName: 'RICE',
        ),
        phone: '2544246733',
        phoneType: 'fax',
      ),
      reporterInformation: ReporterInformation(
        name: 'DELVON RICE',
        reporterType: 'Insured',
        phoneNumber: '2544246733',
        phoneType: 'hm_phn',
      ),
      lossInformation: LossInformation(
        dateOfLoss: '2023-08-07',
        timeOfLoss: '14:31:05',
        typeOfLoss: 'Hit Domestic/Farm Animal or Fowl',
        lossDescription: 'description',
        location: 'farm',
        city: 'Dallas',
        state: 'TX',
        county: 'Anderson',
        policeDepartment: 'Texas PD',
        policeCaseNumber: '254-424-6733',
      ),
    );
  }
}
