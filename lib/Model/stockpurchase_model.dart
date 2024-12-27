// To parse this JSON data, do
//
//     final stockRecieved = stockPurchaseFromMap(jsonString);

import 'dart:convert';

List<StockRecieved> stockRecievedFromJson(String str) => List<StockRecieved>.from(json.decode(str).map((x) => StockRecieved.fromJson(x)));

String stockRecievedToJson(List<StockRecieved> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class StockRecieved {
    StockRecieved({
        this.recievingId,
        this.purchaseId,
        this.officeId,
        this.itemUniqueId,
        this.dispatchcommonId,
        this.recievedcommonId,
        this.itemName,
        this.itemQty,
        this.recievedBy,
        this.status,
        this.createdAt,
        this.updateAt,
    });

   String? recievingId;
    String? purchaseId;
    String? officeId;
    String? itemUniqueId;
    String? dispatchcommonId;
    String? recievedcommonId;
    String? itemName;
    String? itemQty;
    String? recievedBy;
    String? status;
    String? createdAt;
   String? updateAt;
    factory StockRecieved.fromJson(Map<String, dynamic> json) => StockRecieved(
        recievingId: json["recieving_id"],
        purchaseId: json["purchase_id"],
        officeId: json["office_id"],
        itemUniqueId: json["item_unique_id"],
        dispatchcommonId: json["dispatch_common_id"],
        recievedcommonId: json["recieved_common_id"],
        itemName: json["item_name"],
        itemQty: json["item_qty"],
        recievedBy:json["recieved_by"],
        status:json["status"],
        createdAt: json["created_at"],
        updateAt: json["update_at"],
    );

    Map<String, dynamic> toJson() => {
        "recieving_id": recievingId,
        "purchase_id":purchaseId,
        "office_id": officeId,
        "item_unique_id": itemUniqueId,
        "dispatch_common_id":dispatchcommonId,
        "recieved_common_id": recievedcommonId,
        "item_name": itemName,
        "item_qty": itemQty,
        "recieved_by": recievedBy,
        "status":status,
        "created_at": createdAt,
        "update_at": updateAt,
    };
}
