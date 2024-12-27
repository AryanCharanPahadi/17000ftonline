// To parse this JSON data, do
//
//     final stockDistribution = stockDistributionFromJson(jsonString);

import 'dart:convert';

List<StockDistributionModel> stockDistributionModelFromJson(String str) =>
    List<StockDistributionModel>.from(
        json.decode(str).map((x) => StockDistributionModel.fromJson(x)));

String stockDistributionModelToJson(List<StockDistributionModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class StockDistributionModel {
  StockDistributionModel({
    this.distibutedId,
    this.officeId,
    this.purchaseId,
    this.dispatchCommonId,
    this.distributionCommonId,
    this.recievedCommonId,
    this.itemUniqueId,
    this.schoolNewCode,
    this.stateName,
    this.districtName,
    this.blockName,
    this.schoolName,
    this.itemName,
    this.itemQty,
    this.distributedBy,
    this.distributionDate,
    this.receiverName,
    this.receiverDesignation,
    this.receiverPhone,
    this.status,
    this.remarks,
    this.createdAt,
  });

  String? distibutedId;
  String? officeId;
  String? purchaseId;
  String? dispatchCommonId;
  String? distributionCommonId;
  String? recievedCommonId;
  String? itemUniqueId;
  String? schoolNewCode;
  String? stateName;
  String? districtName;
  String? blockName;
  String? schoolName;
  String? itemName;
  String? itemQty;
  String? distributedBy;
  String? distributionDate;
  String? receiverName;
  String? receiverDesignation;
  String? receiverPhone;
  String? status;
  String? remarks;
  String? createdAt;

  factory StockDistributionModel.fromJson(Map<String, dynamic> json) =>
      StockDistributionModel(
        distibutedId: json["distibuted_id"],
        officeId: json["office_id"],
        purchaseId: json["purchase_id"],
        dispatchCommonId: json["dispatch_common_id"],
        distributionCommonId: json["distribution_common_id"],
        recievedCommonId: json["recieved_common_id"],
        itemUniqueId: json["item_unique_id"],
        schoolNewCode: json["school_new_code"],
        stateName: json["state_name"],
        districtName: json["district_name"],
        blockName: json["block_name"],
        schoolName: json["school_name"],
        itemName: json["item_name"],
        itemQty: json["item_qty"],
        distributedBy: json["distributed_by"],
        distributionDate: json["distributionDate"],
        receiverName: json["reciever_name"],
        receiverDesignation: json["reciever_designation"],
        receiverPhone: json["receiver_phone"],
        status: json["status"],
        remarks: json["remarks"],
        createdAt: json["created_at"],
      );

  Map<String, dynamic> toJson() => {
        "distibuted_id": distibutedId,
        "office_id": officeId,
        "purchase_id": purchaseId,
        "dispatch_common_id": dispatchCommonId,
        "distribution_common_id": distributionCommonId,
        "recieved_common_id": recievedCommonId,
        "item_unique_id": itemUniqueId,
        "school_new_code": schoolNewCode,
        "state_name": stateName,
        "district_name": districtName,
        "block_name": blockName,
        "school_name": schoolName,
        "item_name": itemName,
        "item_qty": itemQty,
        "distributed_by": distributedBy,
        "distributionDate": distributionDate,
        "reciever_name": receiverName,
        "reciever_designation": receiverDesignation,
        "receiver_phone": receiverPhone,
        "status": status,
        "remarks": remarks,
        "created_at": createdAt,
      };
}

