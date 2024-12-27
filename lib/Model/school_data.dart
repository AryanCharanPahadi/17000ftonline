// To parse this JSON data, do
//
//     final schoolData = schoolDataFromJson(jsonString);

import 'dart:convert';

List<SchoolData> schoolDataFromJson(String str) =>
    List<SchoolData>.from(json.decode(str).map((x) => SchoolData.fromJson(x)));

String schoolDataToJson(List<SchoolData> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class SchoolData {
  SchoolData({
    this.schoolPid,
    this.state,
    this.distname,
    this.schoolCodeOld,
    this.schoolCodeNew,
    this.schoolName,
    this.blockName,
    this.clusterName,
    this.villageName,
    this.pincode,
    this.the17000FtSchools,
    this.remarks,
    this.createdAt,
    this.updateAt,
  });

  String? schoolPid;
  String? state;
  String? distname;
  String? schoolCodeOld;
  String? schoolCodeNew;
  String? schoolName;
  String? blockName;
  String? clusterName;
  String? villageName;
  String? pincode;
  String? the17000FtSchools;
  dynamic remarks;
  DateTime? createdAt;
  dynamic updateAt;
  bool isSelected = false;

  factory SchoolData.fromJson(Map<String, dynamic> json) => SchoolData(
        schoolPid: json["school_pid"],
        state: json["STATE"],
        distname: json["DISTNAME"],
        schoolCodeOld: json["SCHOOL_CODE_OLD"],
        schoolCodeNew: json["SCHOOL_CODE_NEW"],
        schoolName: json["SCHOOL_NAME"],
        blockName: json["BLOCK_NAME"],
        clusterName: json["CLUSTER_NAME"],
        villageName: json["VILLAGE_NAME"],
        pincode: json["PINCODE"],
        the17000FtSchools: json["17000ft_SCHOOLS"],
        remarks: json["remarks"],
        createdAt: DateTime.parse(json["created_at"]),
        updateAt: json["update_at"],
      );

  Map<String, dynamic> toJson() => {
        "school_pid": schoolPid,
        "STATE": state,
        "DISTNAME": distname,
        "SCHOOL_CODE_OLD": schoolCodeOld,
        "SCHOOL_CODE_NEW": schoolCodeNew,
        "SCHOOL_NAME": schoolName,
        "BLOCK_NAME": blockName,
        "CLUSTER_NAME": clusterName,
        "VILLAGE_NAME": villageName,
        "PINCODE": pincode,
        "17000ft_SCHOOLS": the17000FtSchools,
        "remarks": remarks,
        "created_at":
            "${createdAt!.year.toString().padLeft(4, '0')}-${createdAt!.month.toString().padLeft(2, '0')}-${createdAt!.day.toString().padLeft(2, '0')}",
        "update_at": updateAt,
      };
}
