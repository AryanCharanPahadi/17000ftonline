// To parse this JSON data, do
//
//     final generalRecords = generalRecordsFromJson(jsonString);

import 'dart:convert';

List<GeneralRecords> generalRecordsFromJson(String str) =>
    List<GeneralRecords>.from(
        json.decode(str).map((x) => GeneralRecords.fromJson(x)));

String generalRecordsToJson(List<GeneralRecords> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class GeneralRecords {
  GeneralRecords({
    this.id,
    this.modeOfTransport,
    this.reasonOfTravel,
    this.paymentMode,
    this.paymentType,
  });

  String? id;
  String? modeOfTransport;
  String? reasonOfTravel;
  String? paymentMode;
  String? paymentType;

  factory GeneralRecords.fromJson(Map<String, dynamic> json) => GeneralRecords(
        id: json["id"],
        modeOfTransport: json["mode_of_transport"],
        reasonOfTravel: json["reason_of_travel"],
        paymentMode: json["payment_mode"],
        paymentType: json["payment_type"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "mode_of_transport": modeOfTransport,
        "reason_of_travel": reasonOfTravel,
        "payment_mode": paymentMode,
        "payment_type": paymentType,
      };
}
