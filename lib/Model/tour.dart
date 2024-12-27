// To parse this JSON data, do
//
//     final tourId = tourIdFromJson(jsonString);

import 'dart:convert';

List<TourId> tourIdFromJson(String str) =>
    List<TourId>.from(json.decode(str).map((x) => TourId.fromJson(x)));

String tourIdToJson(List<TourId> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class TourId {
  TourId({
    this.tourBudgetId,
    this.tourLeaderName,
    this.stateName,
    this.distName,
    this.blockName,
    this.programName,
    this.datefrom,
    this.dateto,
    this.nightStay,
    this.schoolName,
    this.vistDate,
    this.vistStaff,
    this.tbTransport,
    this.gmodeTransport,
    this.gvehicelNo,
    this.gvehicleDrop,
    this.typeGoods,
    this.goodsTransportKm,
    this.goodsTransportAmount,
    this.smodeTransport,
    this.svehicelNo,
    this.svehicleDrop,
    this.staffTransportKm,
    this.staffTransportAmount,
    this.activity,
    this.distribution,
    this.programSetup,
    this.dataCollection,
    this.dailyAllowance,
    this.tokenId,
    this.itemName,
    this.itemCost,
    this.itemRemarks,
    this.tourId,
    this.officeName,
    this.createdAt,
    this.updatedAt,
    this.approvedBy,
    this.createdBy,
    this.updateBy,
    this.status,
    this.expiryDate,

  });

  String? tourBudgetId;
  String? tourLeaderName;
  String? stateName;
  String? distName;
  String? blockName;
  String? programName;
  String? datefrom;
  String? dateto;
  String? nightStay;
  String? schoolName;
  String? vistDate;
  String? vistStaff;
  String? tbTransport;
  String? gmodeTransport;
  String? gvehicelNo;
  String? gvehicleDrop;
  String? typeGoods;
  String? goodsTransportKm;
  String? goodsTransportAmount;
  String? smodeTransport;
  String? svehicelNo;
  String? svehicleDrop;
  String? staffTransportKm;
  String? staffTransportAmount;
  String? activity;
  String? distribution;
  String? programSetup;
  String? dataCollection;
  String? dailyAllowance;
  String? tokenId;
  String? itemName;
  String? itemCost;
  String? itemRemarks;
  String? tourId;
  String? officeName;
  String? createdAt;
  String? updatedAt;
  String? approvedBy;
  String? createdBy;
  String? updateBy;
  String? status;
  String? expiryDate;
 

  factory TourId.fromJson(Map<String, dynamic> json) => TourId(
        tourBudgetId: json["tour_budget_id"],
        tourLeaderName: json["tour_leader_name"],
        stateName: json["state_name"],
        distName: json["dist_name"],
        blockName: json["block_name"],
        programName: json["program_name"],
        datefrom: json["datefrom"],
        dateto: json["dateto"],
        nightStay: json["nightStay"],
        schoolName: json["school_name"],
        vistDate: json["vist_date"],
        vistStaff: json["vist_staff"],
        tbTransport: json["tb_transport"],
        gmodeTransport: json["gmode_transport"],
        gvehicelNo: json["gvehicel_no"],
        gvehicleDrop: json["gvehicle_drop"],
        typeGoods: json["type_goods"],
        goodsTransportKm: json["goods_transport_km"],
        goodsTransportAmount: json["goods_transport_amount"],
        smodeTransport: json["smode_transport"],
        svehicelNo: json["svehicel_no"],
        svehicleDrop: json["svehicle_drop"],
        staffTransportKm: json["staff_transport_km"],
        staffTransportAmount: json["staff_transport_amount"],
        activity: json["activity"],
        distribution: json["distribution"],
        programSetup: json["program_setup"],
        dataCollection: json["data_collection"],
        dailyAllowance: json["daily_allowance"],
        tokenId: json["token_id"],
        itemName: json["itemName"],
        itemCost: json["item_cost"],
        itemRemarks: json["item_remarks"],
        tourId: json["tour_id"],
        officeName: json["office_name"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
        approvedBy: json["approved_by"],
        createdBy: json["created_by"],
        updateBy: json["update_by"],
        status: json["status"],
        expiryDate: json["expiry_date"],
       
      );

  Map<String, dynamic> toJson() => {
        "tour_budget_id": tourBudgetId,
        "tour_leader_name": tourLeaderName,
        "state_name": stateName,
        "dist_name": distName,
        "block_name": blockName,
        "program_name": programName,
        "datefrom": datefrom,
        "dateto": dateto,
        "nightStay": nightStay,
        "school_name": schoolName,
        "vist_date": vistDate,
        "vist_staff": vistStaff,
        "tb_transport": tbTransport,
        "gmode_transport": gmodeTransport,
        "gvehicel_no": gvehicelNo,
        "gvehicle_drop": gvehicleDrop,
        "type_goods": typeGoods,
        "goods_transport_km": goodsTransportKm,
        "goods_transport_amount": goodsTransportAmount,
        "smode_transport": smodeTransport,
        "svehicel_no": svehicelNo,
        "svehicle_drop": svehicleDrop,
        "staff_transport_km": staffTransportKm,
        "staff_transport_amount": staffTransportAmount,
        "activity": activity,
        "distribution": distribution,
        "program_setup": programSetup,
        "data_collection": dataCollection,
        "daily_allowance": dailyAllowance,
        "token_id": tokenId,
        "itemName": itemName,
        "item_cost": itemCost,
        "item_remarks": itemRemarks,
        "tour_id": tourId,
        "office_name": officeName,
        "created_at": createdAt,
        "updated_at": updatedAt,
        "approved_by": approvedBy,
        "created_by": createdBy,
        "update_by": updateBy,
        "status": status,
        "expiry_date": expiryDate,
      };
}

// To parse this JSON data, do
//
//     final dateModel = dateModelFromJson(jsonString);


Map<String, int> dateModelFromJson(String str) => Map.from(json.decode(str)).map((k, v) => MapEntry<String, int>(k, v));

String dateModelToJson(Map<String, int> data) => json.encode(Map.from(data).map((k, v) => MapEntry<String, dynamic>(k, v)));
