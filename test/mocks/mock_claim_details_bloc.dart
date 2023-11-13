import 'package:bloc_test/bloc_test.dart';
import 'package:txfb_insurance_flutter/app/blocs/claims/claim_details/claim_details_bloc.dart';
import 'package:txfb_insurance_flutter/domain/models/claims/claims.dart';

class MockClaimDetailsBloc
    extends MockBloc<ClaimDetailsEvent, ClaimDetailsState>
    implements ClaimDetailsBloc {}

final mockClaimDetailsSuccess = FetchClaimDetailsSuccess(
  claim: ClaimDetails(
    claimAssignments: ClaimAssignments(
      importAssignmentDTO: [
        ClaimImportAssignmentDTO(
          userPhoneNumber: '1234567890',
          userFirstName: 'John',
          userLastName: 'Doe',
          userEmail: 'email@provider.com',
        ),
      ],
    ),
  ),
);
