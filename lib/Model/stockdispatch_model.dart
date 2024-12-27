// // To parse this JSON data, do
// //
// //     final stockDispatch = stockPurchaseFromMap(jsonString);

// import 'dart:convert';

// List<StockDispatch> stockDispatchFromJson(String str) => List<StockDispatch>.from(json.decode(str).map((x) => StockDispatch.fromJson(x)));

// String stockDispatchToJson(List<StockDispatch> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

// class StockDispatch {
//     StockDispatch({
       
//         this.purchaseId,
//         this.itemuniqueId,
//         this.officeId,
//         this.toOfficeId,
//         this.dispatchcommonId,
//         this.dateofdispatch,
//         this.programmes,
//         this.stateName,
//         this.districtName,
//         this.blockName,
//         this.schoolName,
//         this.invoiceNo,
//         this.vendorId,
//         this.funderId,
//         this.itemName,
//         this.itemQty,
//         this.rate,
//         this.totalAmount,
//         this.status,
//         this.remarks,
//         this.createdAt,
//         this.updatedAt,
//     });
//     String? purchaseId;
//     String?itemuniqueId;
//     String? officeId;
//     String? toOfficeId;
//     String? dispatchcommonId;
//     String? dateofdispatch;
//     String? stateName;
//     String? districtName;
//     String? blockName;
//     String? schoolName;
//     String? programmes;
//     String? invoiceNo;
//     String? vendorId;
//     String? funderId;
//     String? purchaseDate;
//     String? itemName;
//     int? itemQty;
//     String? rate;
//     String? totalAmount;
//     String? status;
//     String? remarks;
//     String? createdAt;
//     String? updatedAt;

//     factory StockDispatch.fromJson(Map<String, dynamic> json) => StockDispatch(
        
//         purchaseId: json["purchase_id"],
//         itemuniqueId:json["item_unique_id"],
//         officeId: json["office_id"],
//         toOfficeId:json["to_office_id"],
//         dispatchcommonId: json["dispatch_common_id"],
//         dateofdispatch: json["date_of_dispatch"],
//         stateName: json["State_name"],
//         districtName: json["district_name"],
//         blockName: json["block_name"],
//         schoolName: json["school_name"],
//         programmes: json["programmes"],
//         invoiceNo: json["invoice_no"],
//         vendorId: json["vendor_id"],
//         funderId: json["funder_id"],
//         itemName: json["item_name"],
//         itemQty: json["item_qty"],
//         rate: json["rate"],
//         totalAmount: json["total_amount"],
//         status: json["status"],
//         remarks: json["remarks"],
//         createdAt: json["created_at"],
//         updatedAt: json["updated_at"],
//     );

//     Map<String, dynamic> toJson() => {
//         "purchase_id":purchaseId,
//         "item_unique_id":itemuniqueId,
//         "office_id":officeId,
//         "to_office_id":toOfficeId,
//         "dispatch_common_id":dispatchcommonId,
//         "date_of_dispatch":dateofdispatch,
//         "State_name": stateName,
//         "district_name": districtName,
//         "block_name": blockName,
//         "school_name": schoolName,
//         "programmes": programmes,
//         "invoice_no": invoiceNo,
//         "vendor_id": vendorId,
//         "funder_id": funderId,
//         "purchase_date": purchaseDate,
//         "item_name": itemName,
//         "item_qty": itemQty,
//         "rate": rate,
//         "total_amount": totalAmount,
//         "status": status,
//         "remarks": remarks,
//         "created_at": createdAt,
//         "updated_at": updatedAt,
//     };
// }
