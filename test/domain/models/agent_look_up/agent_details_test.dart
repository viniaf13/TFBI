import 'package:test/test.dart';
import 'package:txfb_insurance_flutter/domain/domain.dart';

void main() {
  group('AgentDetails', () {
    test('fromJson() should correctly deserialize JSON', () {
      final Map<String, dynamic> json = {
        '_aboutText': 'About text',
        '_agentCode': 'ABC123',
        '_agentSinceDate': '2023-07-18',
        '_emailAddress': 'agent@example.com',
        '_errorMessage': 'Error message',
        '_faxNumber': '123-456-7890',
        '_firstName': 'John',
        '_lastName': 'Doe',
        '_mailingAddress': 'Mailing address',
        '_mailingAddress2': 'Mailing address 2',
        '_mailingCity': 'Mailing city',
        '_mailingState': 'Mailing state',
        '_mailingZip': '12345',
        '_mailingZip4': null,
        '_phoneNumber': '987-654-3210',
        '_photo': 'Photo URL',
        '_physicalAddress': 'Physical address',
        '_physicalAddress2': 'Physical address 2',
        '_physicalCity': 'Physical city',
        '_physicalState': 'Physical state',
        '_physicalZip': '54321',
        '_physicalZip4': null,
        '_preferredName': 'Preferred name',
        '_titleDesignation': 'Title designation',
      };

      final AgentDetails agentDetails = AgentDetails.fromJson(json);

      expect(agentDetails.aboutText, 'About text');
      expect(agentDetails.agentCode, 'ABC123');
      expect(agentDetails.agentSinceDate, '2023-07-18');
      expect(agentDetails.emailAddress, 'agent@example.com');
      expect(agentDetails.errorMessage, 'Error message');
      expect(agentDetails.faxNumber, '123-456-7890');
      expect(agentDetails.firstName, 'John');
      expect(agentDetails.lastName, 'Doe');
      expect(agentDetails.mailingAddress, 'Mailing address');
      expect(agentDetails.mailingAddress2, 'Mailing address 2');
      expect(agentDetails.mailingCity, 'Mailing city');
      expect(agentDetails.mailingState, 'Mailing state');
      expect(agentDetails.mailingZip, '12345');
      expect(agentDetails.mailingZip4, isNull);
      expect(agentDetails.phoneNumber, '987-654-3210');
      expect(agentDetails.photo, 'Photo URL');
      expect(agentDetails.physicalAddress, 'Physical address');
      expect(agentDetails.physicalAddress2, 'Physical address 2');
      expect(agentDetails.physicalCity, 'Physical city');
      expect(agentDetails.physicalState, 'Physical state');
      expect(agentDetails.physicalZip, '54321');
      expect(agentDetails.physicalZip4, isNull);
      expect(agentDetails.preferredName, 'Preferred name');
      expect(agentDetails.titleDesignation, 'Title designation');
    });

    test('toJson() should correctly serialize to JSON', () {
      final AgentDetails agentDetails = AgentDetails(
        aboutText: 'About text',
        agentCode: 'ABC123',
        agentSinceDate: '2023-07-18',
        emailAddress: 'agent@example.com',
        errorMessage: 'Error message',
        faxNumber: '123-456-7890',
        firstName: 'John',
        lastName: 'Doe',
        mailingAddress: 'Mailing address',
        mailingAddress2: 'Mailing address 2',
        mailingCity: 'Mailing city',
        mailingState: 'Mailing state',
        mailingZip: '12345',
        mailingZip4: '',
        phoneNumber: '987-654-3210',
        photo: 'Photo URL',
        physicalAddress: 'Physical address',
        physicalAddress2: 'Physical address 2',
        physicalCity: 'Physical city',
        physicalState: 'Physical state',
        physicalZip: '54321',
        physicalZip4: '',
        preferredName: 'Preferred name',
        titleDesignation: 'Title designation',
      );

      final Map<String, dynamic> json = agentDetails.toJson();

      expect(json['_aboutText'], 'About text');
      expect(json['_agentCode'], 'ABC123');
      expect(json['_agentSinceDate'], '2023-07-18');
      expect(json['_emailAddress'], 'agent@example.com');
      expect(json['_errorMessage'], 'Error message');
      expect(json['_faxNumber'], '123-456-7890');
      expect(json['_firstName'], 'John');
      expect(json['_lastName'], 'Doe');
      expect(json['_mailingAddress'], 'Mailing address');
      expect(json['_mailingAddress2'], 'Mailing address 2');
      expect(json['_mailingCity'], 'Mailing city');
      expect(json['_mailingState'], 'Mailing state');
      expect(json['_mailingZip'], '12345');
      expect(json['_mailingZip4'], '');
      expect(json['_phoneNumber'], '987-654-3210');
      expect(json['_photo'], 'Photo URL');
      expect(json['_physicalAddress'], 'Physical address');
      expect(json['_physicalAddress2'], 'Physical address 2');
      expect(json['_physicalCity'], 'Physical city');
      expect(json['_physicalState'], 'Physical state');
      expect(json['_physicalZip'], '54321');
      expect(json['_physicalZip4'], '');
      expect(json['_preferredName'], 'Preferred name');
      expect(json['_titleDesignation'], 'Title designation');
    });

    test('toString() should return the correct string representation', () {
      final AgentDetails agentDetails = AgentDetails(
        firstName: 'John',
        lastName: 'Doe',
        agentCode: 'ABC123',
        phoneNumber: '987-654-3210',
        emailAddress: 'agent@example.com',
      );

      final String result = agentDetails.toString();

      expect(
        result,
        'Agent: John Doe -- ABC123, Phone: 987-654-3210, Email: agent@example.com',
      );
    });

    test('firstAndLastName should return the correct full name', () {
      final AgentDetails agentDetails = AgentDetails(
        firstName: 'John',
        lastName: 'Doe',
      );

      final String result = agentDetails.firstAndLastName;

      expect(result, 'John Doe');
    });
  });
}
