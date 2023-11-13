// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auto_policy_detail.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AutoPolicyDetail _$AutoPolicyDetailFromJson(Map<String, dynamic> json) =>
    AutoPolicyDetail(
      policyType: json['PolicyType'] as String,
      policySubType: json['PolicySubType'] as String,
      policySymbol: json['PolicySymbol'] as String,
      policyAddress:
          Address.fromJson(json['PolicyAddress'] as Map<String, dynamic>),
      policyBilling:
          PolicyBilling.fromJson(json['PolicyBilling'] as Map<String, dynamic>),
      policyNumber: json['PolicyNumber'] as String,
      policyDescription: json['PolicyDescription'] as String,
      effectiveDate: json['EffectiveDate'] as String,
      expirationDate: json['ExpirationDate'] as String,
      isEnrolledPaperless: json['IsEnrolledPaperless'] as bool? ?? false,
      isEnrolledEbill: json['IsEnrolledEbill'] as bool? ?? false,
      isEnrolledRecurring: json['IsEnrolledRecurring'] as bool? ?? false,
      isEnrolledAccountBill: json['IsEnrolledAccountBill'] as bool? ?? false,
      showIdCard: json['ShowIdCard'] as bool? ?? false,
      showRoadsideAssistanceCard:
          json['ShowRoadsideAssistanceCard'] as bool? ?? false,
      coveredDrivers: (json['CoveredDrivers'] as List<dynamic>?)
              ?.map((e) => Driver.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      excludedDrivers: (json['ExcludedDrivers'] as List<dynamic>?)
              ?.map((e) => Driver.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      vehicles: (json['Vehicles'] as List<dynamic>?)
              ?.map((e) => Vehicle.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      namedInsuredOne: json['NamedInsuredOne'] as String?,
      namedInsuredTwo: json['NamedInsuredTwo'] as String?,
      writingCompanyName: json['WritingCompanyName'] as String?,
    );

Map<String, dynamic> _$AutoPolicyDetailToJson(AutoPolicyDetail instance) =>
    <String, dynamic>{
      'PolicyNumber': instance.policyNumber,
      'PolicyType': instance.policyType,
      'PolicySubType': instance.policySubType,
      'PolicyDescription': instance.policyDescription,
      'EffectiveDate': instance.effectiveDate,
      'ExpirationDate': instance.expirationDate,
      'NamedInsuredOne': instance.namedInsuredOne,
      'NamedInsuredTwo': instance.namedInsuredTwo,
      'WritingCompanyName': instance.writingCompanyName,
      'PolicyBilling': instance.policyBilling,
      'PolicyAddress': instance.policyAddress,
      'PolicySymbol': instance.policySymbol,
      'ShowIdCard': instance.showIdCard,
      'ShowRoadsideAssistanceCard': instance.showRoadsideAssistanceCard,
      'IsEnrolledPaperless': instance.isEnrolledPaperless,
      'IsEnrolledEbill': instance.isEnrolledEbill,
      'IsEnrolledRecurring': instance.isEnrolledRecurring,
      'IsEnrolledAccountBill': instance.isEnrolledAccountBill,
      'CoveredDrivers': instance.coveredDrivers,
      'ExcludedDrivers': instance.excludedDrivers,
      'Vehicles': instance.vehicles,
    };

Driver _$DriverFromJson(Map<String, dynamic> json) => Driver(
      json['DateOfBirth'] as String,
      json['DriversLicenseNumber'] as String,
      json['DriversLicenseState'] as String,
      json['FirstName'] as String,
      json['FullName'] as String,
      json['MiddleName'] as String,
      json['LastName'] as String,
      json['NamePrefix'] as String,
      json['NameSuffix'] as String,
      json['YearOfBirth'] as String,
    );

Map<String, dynamic> _$DriverToJson(Driver instance) => <String, dynamic>{
      'DateOfBirth': instance.dateOfBirth,
      'DriversLicenseNumber': instance.driversLicenseNumber,
      'DriversLicenseState': instance.driversLicenseState,
      'FirstName': instance.firstName,
      'FullName': instance.fullName,
      'MiddleName': instance.middleName,
      'LastName': instance.lastName,
      'NamePrefix': instance.namePrefix,
      'NameSuffix': instance.nameSuffix,
      'YearOfBirth': instance.yearOfBirth,
    };

Vehicle _$VehicleFromJson(Map<String, dynamic> json) => Vehicle(
      json['ClassCode'] as String,
      json['Description'] as String,
      (json['Coverages'] as List<dynamic>)
          .map((e) => Coverage.fromJson(e as Map<String, dynamic>))
          .toList(),
      (json['Discounts'] as List<dynamic>)
          .map((e) => Discount.fromJson(e as Map<String, dynamic>))
          .toList(),
      json['Endorsements'] as List<dynamic>,
      (json['LienHolders'] as List<dynamic>)
          .map((e) => LienHolder.fromJson(e as Map<String, dynamic>))
          .toList(),
      json['ExtendedClassCode'] as String,
      json['GaragingCounty'] as String,
      json['HasLossPayee'] as String,
      json['Make'] as String,
      json['Model'] as String,
      json['Number'] as String,
      json['TotalCoveragePremium'] as String,
      json['TotalDiscounts'] as String,
      json['TotalVehiclePremium'] as String,
      json['VIN'] as String,
      json['Year'] as String,
    );

Map<String, dynamic> _$VehicleToJson(Vehicle instance) => <String, dynamic>{
      'ClassCode': instance.classCode,
      'Description': instance.description,
      'Coverages': instance.coverages,
      'Discounts': instance.discounts,
      'Endorsements': instance.endorsements,
      'LienHolders': instance.lienHolders,
      'ExtendedClassCode': instance.extendedClassCode,
      'GaragingCounty': instance.garagingCounty,
      'HasLossPayee': instance.hasLossPayee,
      'Make': instance.make,
      'Model': instance.model,
      'Number': instance.number,
      'TotalCoveragePremium': instance.totalCoveragePremium,
      'TotalDiscounts': instance.totalDiscounts,
      'TotalVehiclePremium': instance.totalVehiclePremium,
      'VIN': instance.vin,
      'Year': instance.year,
    };

Coverage _$CoverageFromJson(Map<String, dynamic> json) => Coverage(
      json['CoverageType'] as String,
      json['CoverageTypeDescription'] as String,
      json['Deductible'] as String,
      json['Description'] as String,
      json['Limit'] as String,
      (json['LimitDescription'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      json['Premium'] as String,
      json['Sequence'] as String?,
    );

Map<String, dynamic> _$CoverageToJson(Coverage instance) => <String, dynamic>{
      'CoverageType': instance.coverageType,
      'CoverageTypeDescription': instance.coverageTypeDescription,
      'Deductible': instance.deductible,
      'Description': instance.description,
      'Limit': instance.limit,
      'LimitDescription': instance.limitDescription,
      'Premium': instance.premium,
      'Sequence': instance.sequence,
    };

Discount _$DiscountFromJson(Map<String, dynamic> json) => Discount(
      json['Code'] as String?,
      json['Description'] as String,
      json['DiscountAmount'] as String,
      json['DiscountAmountDescription'] as String,
      json['DiscountType'] as String,
      json['PremiumAdjustment'] as String,
    );

Map<String, dynamic> _$DiscountToJson(Discount instance) => <String, dynamic>{
      'Code': instance.code,
      'Description': instance.description,
      'DiscountAmount': instance.discountAmount,
      'DiscountAmountDescription': instance.discountAmountDescription,
      'DiscountType': instance.discountType,
      'PremiumAdjustment': instance.premiumAdjustment,
    };

LienHolder _$LienHolderFromJson(Map<String, dynamic> json) => LienHolder(
      Address.fromJson(json['Address'] as Map<String, dynamic>),
      json['EffectiveDate'] as String?,
      json['LienHolderType'] as String,
      json['LoanNumber'] as String?,
      json['LogicalSequenceNumber'] as String,
      json['Name'] as String,
      json['ObjectSequenceNumber'] as String?,
      json['OccurrenceNumber'] as String?,
      json['SuspendIndicator'] as String?,
      json['VehicleIdNumber'] as String,
    );

Map<String, dynamic> _$LienHolderToJson(LienHolder instance) =>
    <String, dynamic>{
      'Address': instance.address,
      'EffectiveDate': instance.effectiveDate,
      'LienHolderType': instance.lienHolderType,
      'LoanNumber': instance.loanNumber,
      'LogicalSequenceNumber': instance.logicalSequenceNumber,
      'Name': instance.name,
      'ObjectSequenceNumber': instance.objectSequenceNumber,
      'OccurrenceNumber': instance.occurrenceNumber,
      'SuspendIndicator': instance.suspendIndicator,
      'VehicleIdNumber': instance.vehicleIdNumber,
    };
