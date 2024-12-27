// To parse this JSON data, do
//
//     final vendorModel = vendorModelFromJson(jsonString);

import 'dart:convert';

List<VendorModel> vendorModelFromJson(String str) => List<VendorModel>.from(json.decode(str).map((x) => VendorModel.fromJson(x)));

String vendorModelToJson(List<VendorModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class VendorModel {
    String vendorName;

    VendorModel({
        required this.vendorName,
    });

    factory VendorModel.fromJson(Map<String, dynamic> json) => VendorModel(
        vendorName: json["vendor_name"],
    );

    Map<String, dynamic> toJson() => {
        "vendor_name": vendorName,
    };
}
