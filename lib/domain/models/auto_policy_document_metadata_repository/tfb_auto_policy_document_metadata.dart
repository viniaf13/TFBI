import 'dart:convert';

class TfbAutoPolicyDocumentMetadata {
  TfbAutoPolicyDocumentMetadata({
    required this.vehicleDisplayTitles,
    required this.expirationDate,
    required this.documentPath,
    required this.id,
    required this.policyNumber,
    this.documentIsTemporary = false,
  });

  factory TfbAutoPolicyDocumentMetadata.fromMap(Map<String, dynamic> map) {
    return TfbAutoPolicyDocumentMetadata(
      vehicleDisplayTitles:
          List<String>.from(map['vehicleDisplayTitles'] as List),
      expirationDate:
          DateTime.fromMillisecondsSinceEpoch(map['expirationDate'] as int),
      documentPath: map['documentPath'] as String,
      id: map['id'] as String,
      policyNumber: map['policyNumber'] as String,
    );
  }

  factory TfbAutoPolicyDocumentMetadata.fromJson(String source) =>
      TfbAutoPolicyDocumentMetadata.fromMap(
        json.decode(source) as Map<String, dynamic>,
      );

  List<String> vehicleDisplayTitles;
  DateTime expirationDate;
  String documentPath;
  String id;
  String policyNumber;
  bool documentIsTemporary;

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'vehicleDisplayTitles': vehicleDisplayTitles,
      'expirationDate': expirationDate.millisecondsSinceEpoch,
      'documentPath': documentPath,
      'id': id,
      'policyNumber': policyNumber,
    };
  }

  String toJson() => json.encode(toMap());
}
