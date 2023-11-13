// coverage:ignore-file

import 'package:json_annotation/json_annotation.dart';
import 'package:txfb_insurance_flutter/domain/models/models.dart';

part 'auto_policy_detail.g.dart';

@JsonSerializable()
class AutoPolicyDetail extends PolicyDetail {
  AutoPolicyDetail({
    required super.policyType,
    required super.policySubType,
    required this.policySymbol,
    required this.policyAddress,
    required super.policyBilling,
    required super.policyNumber,
    required super.policyDescription,
    required super.effectiveDate,
    required super.expirationDate,
    this.isEnrolledPaperless = false,
    this.isEnrolledEbill = false,
    this.isEnrolledRecurring = false,
    this.isEnrolledAccountBill = false,
    this.showIdCard = false,
    this.showRoadsideAssistanceCard = false,
    this.coveredDrivers = const [],
    this.excludedDrivers = const [],
    this.vehicles = const [],
    super.namedInsuredOne,
    super.namedInsuredTwo,
    super.writingCompanyName,
  });
  factory AutoPolicyDetail.fromJson(Map<String, dynamic> json) =>
      _$AutoPolicyDetailFromJson(json);

  @JsonKey(name: 'PolicyAddress')
  final Address policyAddress;
  @JsonKey(name: 'PolicySymbol')
  final String policySymbol;
  @JsonKey(name: 'ShowIdCard')
  final bool showIdCard;
  @JsonKey(name: 'ShowRoadsideAssistanceCard')
  final bool showRoadsideAssistanceCard;
  @JsonKey(name: 'IsEnrolledPaperless')
  final bool isEnrolledPaperless;
  @JsonKey(name: 'IsEnrolledEbill')
  final bool isEnrolledEbill;
  @JsonKey(name: 'IsEnrolledRecurring')
  final bool isEnrolledRecurring;
  @JsonKey(name: 'IsEnrolledAccountBill')
  final bool isEnrolledAccountBill;
  @JsonKey(name: 'CoveredDrivers')
  final List<Driver> coveredDrivers;
  @JsonKey(name: 'ExcludedDrivers')
  final List<Driver> excludedDrivers;
  @JsonKey(name: 'Vehicles')
  final List<Vehicle> vehicles;

  @override
  Map<String, dynamic> toJson() => _$AutoPolicyDetailToJson(this);
}

@JsonSerializable()
class Driver {
  Driver(
    this.dateOfBirth,
    this.driversLicenseNumber,
    this.driversLicenseState,
    this.firstName,
    this.fullName,
    this.middleName,
    this.lastName,
    this.namePrefix,
    this.nameSuffix,
    this.yearOfBirth,
  );

  factory Driver.fromJson(Map<String, dynamic> json) => _$DriverFromJson(json);

  @JsonKey(name: 'DateOfBirth')
  final String dateOfBirth;
  @JsonKey(name: 'DriversLicenseNumber')
  final String driversLicenseNumber;
  @JsonKey(name: 'DriversLicenseState')
  final String driversLicenseState;
  @JsonKey(name: 'FirstName')
  final String firstName;
  @JsonKey(name: 'FullName')
  final String fullName;
  @JsonKey(name: 'MiddleName')
  final String middleName;
  @JsonKey(name: 'LastName')
  final String lastName;
  @JsonKey(name: 'NamePrefix')
  final String namePrefix;
  @JsonKey(name: 'NameSuffix')
  final String nameSuffix;
  @JsonKey(name: 'YearOfBirth')
  final String yearOfBirth;

  Map<String, dynamic> toJson() => _$DriverToJson(this);

  @override
  String toString() {
    return fullName;
  }

  String get obfuscatedLicense {
    return driversLicenseNumber.replaceRange(
      0,
      driversLicenseNumber.length - 4,
      'xxxx',
    );
  }

  bool get hasInformationError {
    return (driversLicenseNumber.length < 4 ||
            driversLicenseNumber.length > 13) ||
        yearOfBirth.isEmpty;
  }
}

@JsonSerializable()
class Vehicle {
  Vehicle(
    this.classCode,
    this.description,
    this.coverages,
    this.discounts,
    this.endorsements,
    this.lienHolders,
    this.extendedClassCode,
    this.garagingCounty,
    this.hasLossPayee,
    this.make,
    this.model,
    this.number,
    this.totalCoveragePremium,
    this.totalDiscounts,
    this.totalVehiclePremium,
    this.vin,
    this.year,
  );

  factory Vehicle.fromJson(Map<String, dynamic> json) =>
      _$VehicleFromJson(json);

  @JsonKey(name: 'ClassCode')
  final String classCode;
  @JsonKey(name: 'Description')
  final String description;
  @JsonKey(name: 'Coverages')
  final List<Coverage> coverages;
  @JsonKey(name: 'Discounts')
  final List<Discount> discounts;
  @JsonKey(name: 'Endorsements')
  List<dynamic> endorsements;
  @JsonKey(name: 'LienHolders')
  final List<LienHolder> lienHolders;
  @JsonKey(name: 'ExtendedClassCode')
  final String extendedClassCode;
  @JsonKey(name: 'GaragingCounty')
  final String garagingCounty;
  @JsonKey(name: 'HasLossPayee')
  final String hasLossPayee;
  @JsonKey(name: 'Make')
  final String make;
  @JsonKey(name: 'Model')
  final String model;
  @JsonKey(name: 'Number')
  final String number;
  @JsonKey(name: 'TotalCoveragePremium')
  final String totalCoveragePremium;
  @JsonKey(name: 'TotalDiscounts')
  final String totalDiscounts;
  @JsonKey(name: 'TotalVehiclePremium')
  final String totalVehiclePremium;
  @JsonKey(name: 'VIN')
  final String vin;
  @JsonKey(name: 'Year')
  final String year;

  Map<String, dynamic> toJson() => _$VehicleToJson(this);

  String get yearMakeModel => '$year $make $model';
}

@JsonSerializable()
class Coverage {
  Coverage(
    this.coverageType,
    this.coverageTypeDescription,
    this.deductible,
    this.description,
    this.limit,
    this.limitDescription,
    this.premium,
    this.sequence,
  );

  factory Coverage.fromJson(Map<String, dynamic> json) =>
      _$CoverageFromJson(json);

  @JsonKey(name: 'CoverageType')
  final String coverageType;
  @JsonKey(name: 'CoverageTypeDescription')
  final String coverageTypeDescription;
  @JsonKey(name: 'Deductible')
  final String deductible;
  @JsonKey(name: 'Description')
  final String description;
  @JsonKey(name: 'Limit')
  final String limit;
  @JsonKey(name: 'LimitDescription')
  final List<String> limitDescription;
  @JsonKey(name: 'Premium')
  final String premium;
  @JsonKey(name: 'Sequence')
  final String? sequence;

  Map<String, dynamic> toJson() => _$CoverageToJson(this);
}

@JsonSerializable()
class Discount {
  Discount(
    this.code,
    this.description,
    this.discountAmount,
    this.discountAmountDescription,
    this.discountType,
    this.premiumAdjustment,
  );

  factory Discount.fromJson(Map<String, dynamic> json) =>
      _$DiscountFromJson(json);

  @JsonKey(name: 'Code')
  final String? code;
  @JsonKey(name: 'Description')
  final String description;
  @JsonKey(name: 'DiscountAmount')
  final String discountAmount;
  @JsonKey(name: 'DiscountAmountDescription')
  final String discountAmountDescription;
  @JsonKey(name: 'DiscountType')
  final String discountType;
  @JsonKey(name: 'PremiumAdjustment')
  final String premiumAdjustment;

  Map<String, dynamic> toJson() => _$DiscountToJson(this);
}

@JsonSerializable()
class LienHolder {
  LienHolder(
    this.address,
    this.effectiveDate,
    this.lienHolderType,
    this.loanNumber,
    this.logicalSequenceNumber,
    this.name,
    this.objectSequenceNumber,
    this.occurrenceNumber,
    this.suspendIndicator,
    this.vehicleIdNumber,
  );

  factory LienHolder.fromJson(Map<String, dynamic> json) =>
      _$LienHolderFromJson(json);

  @JsonKey(name: 'Address')
  final Address address;
  @JsonKey(name: 'EffectiveDate')
  final String? effectiveDate;
  @JsonKey(name: 'LienHolderType')
  final String lienHolderType;
  @JsonKey(name: 'LoanNumber')
  final String? loanNumber;
  @JsonKey(name: 'LogicalSequenceNumber')
  final String logicalSequenceNumber;
  @JsonKey(name: 'Name')
  final String name;
  @JsonKey(name: 'ObjectSequenceNumber')
  final String? objectSequenceNumber;
  @JsonKey(name: 'OccurrenceNumber')
  final String? occurrenceNumber;
  @JsonKey(name: 'SuspendIndicator')
  final String? suspendIndicator;
  @JsonKey(name: 'VehicleIdNumber')
  final String vehicleIdNumber;

  Map<String, dynamic> toJson() => _$LienHolderToJson(this);
}
