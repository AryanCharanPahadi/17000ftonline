// To parse this JSON data, do
//
//     final districtModel = districtModelFromJson(jsonString);

import 'dart:convert';

List<DistrictModel> districtModelFromJson(String str) =>
    List<DistrictModel>.from(
        json.decode(str).map((x) => DistrictModel.fromJson(x)));

String districtModelToJson(List<DistrictModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class DistrictModel {
  DistrictModel({
    this.districtId,
    this.stateId,
    this.districtName,
    this.status,
  });

  String? districtId;
  String? stateId;
  String? districtName;
  String? status;

  factory DistrictModel.fromJson(Map<String, dynamic> json) => DistrictModel(
        districtId: json["districtId"],
        stateId: json["stateId"],
        districtName: json["districtName"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "districtId": districtId,
        "stateId": stateId,
        "districtName": districtName,
        "status": status,
      };
}
