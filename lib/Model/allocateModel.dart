// To parse this JSON data, do
//
//     final allocateModel = allocateModelFromJson(jsonString);

import 'dart:convert';

List<AllocateModel> allocateModelFromJson(String str) =>
    List<AllocateModel>.from(
        json.decode(str).map((x) => AllocateModel.fromJson(x)));

String allocateModelToJson(List<AllocateModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class AllocateModel {
  AllocateModel({
    this.allocationId,
    this.recievedCommonId,
    this.officeId,
    this.funders,
    this.schoolNewCode,
    this.itemUniqueId,
    this.itemQty,
    this.allocateQty,
    this.remarks,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.schoolName,
    this.schoolState,
    this.schoolDistrict,
    this.schoolBlock,
    this.itemName,
    this.purchaseId,
    this.dispatchCommonId
  });

  String? allocationId;
  String? recievedCommonId;
  String? officeId;
  String? funders;
  String? schoolNewCode;
  String? itemUniqueId;
  String? itemQty;
  String? allocateQty;
  String? remarks;
  String? status;
  String? createdAt;
  String? updatedAt;
  String? schoolName;
  String? schoolState;
  String? schoolDistrict;
  String? schoolBlock;
  String? itemName;
  String? purchaseId;
  String? dispatchCommonId;

  factory AllocateModel.fromJson(Map<String, dynamic> json) => AllocateModel(
        allocationId: json["allocation_id"],
        recievedCommonId: json["recieved_common_id"],
        officeId: json["office_id"],
        funders: json["funders"],
        schoolNewCode: json["school_new_code"],
        itemUniqueId: json["item_unique_id"],
        itemQty: json["item_qty"],
        allocateQty: json["allocate_qty"],
        remarks: json["remarks"],
        status: json["status"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
        schoolName: json["school_name"],
        schoolState: json["school_state"],
        schoolDistrict: json["school_district"],
        schoolBlock: json["school_block"],
        itemName: json["item_name"],
        purchaseId: json["purchase_id"],
        dispatchCommonId: json["dispatch_common_id"],
      );

  Map<String, dynamic> toJson() => {
        "allocation_id": allocationId,
        "recieved_common_id": recievedCommonId,
        "office_id": officeId,
        "funders": funders,
        "school_new_code": schoolNewCode,
        "item_unique_id": itemUniqueId,
        "item_qty": itemQty,
        "allocate_qty": allocateQty,
        "remarks": remarks,
        "status": status,
        "created_at": createdAt,
        "updated_at": updatedAt,
        "school_name": schoolName,
        "school_state": schoolState,
        "school_district": schoolDistrict,
        "school_block": schoolBlock,
        "item_name": itemName,
        "purchase_id":purchaseId,
        "dispatch_common_id":dispatchCommonId,
      };
}
