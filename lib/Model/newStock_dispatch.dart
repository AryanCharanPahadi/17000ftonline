// To parse this JSON data, do
//
//     final stockDispatch = stockDispatchFromJson(jsonString);

import 'dart:convert';

List<StockDispatch> stockDispatchFromJson(String str) =>
    List<StockDispatch>.from(
        json.decode(str).map((x) => StockDispatch.fromJson(x)));

String stockDispatchToJson(List<StockDispatch> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class StockDispatch {
  StockDispatch({
    this.dispatchId,
    this.officeId,
    this.toOfficeId,
    this.dispatchCommonId,
    this.dateOfDispatch,
    this.itemUniqueId,
    this.itemName,
    this.itemQty,
    this.receivedBy,
    this.receivedDate,
    this.dispatchQty,
    this.shippingMode,
    this.status,
    this.remarks,
    this.createdAt,
    this.updatedAt,
  });

  String? dispatchId;
  String? officeId;
  String? toOfficeId;
  String? dispatchCommonId;
  String? dateOfDispatch;
  String? itemUniqueId;
  String? itemName;
  String? itemQty;
  String? receivedBy;
  String? receivedDate;
  String? dispatchQty;
  String? shippingMode;
  String? status;
  String? remarks;
  String? createdAt;
  String? updatedAt;

  factory StockDispatch.fromJson(Map<String, dynamic> json) => StockDispatch(
        dispatchId: json["dispatch_id"],
        officeId: json["office_id"],
        toOfficeId: json["to_office_id"],
        dispatchCommonId: json["dispatch_common_id"],
        dateOfDispatch: json["date_of_dispatch"],
        itemUniqueId: json["item_unique_id"],
        itemName: json["item_name"],
        itemQty: json["item_qty"],
        receivedBy: json['received_by'],
        receivedDate: json['received_date'],
        dispatchQty: json["dispatch_qty"],
        shippingMode: json["shippingMode"],
        status: json["status"],
        remarks: json["remarks"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
      );

  // get purchaseId => null;

  Map<String, dynamic> toJson() => {
        "dispatch_id": dispatchId,
        "office_id": officeId,
        "to_office_id": toOfficeId,
        "dispatch_common_id": dispatchCommonId,
        "date_of_dispatch": dateOfDispatch,
        "item_unique_id": itemUniqueId,
        "item_name": itemName,
        "item_qty": itemQty,
        "dispatch_qty": dispatchQty,
        "shippingMode": shippingMode,
        "status": status,
        "remarks": remarks,
        "created_at": createdAt,
        "updated_at": updatedAt,
      };
}
