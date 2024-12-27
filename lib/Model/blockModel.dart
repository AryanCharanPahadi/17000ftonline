import 'dart:convert';

List<StateInfo> stateInfoFromJson(String str) =>
    List<StateInfo>.from(json.decode(str).map((x) => StateInfo.fromJson(x)));

String stateInfoToJson(List<StateInfo> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class StateInfo {
  StateInfo({
    this.stateName,
    this.districtName,
    this.status,
    this.blockName,
  });

  String? stateName;
  String? districtName;
  String? status;
  String? blockName;

  factory StateInfo.fromJson(Map<String, dynamic> json) => StateInfo(
        stateName: json["stateName"],
        districtName: json["districtName"],
        blockName: json["blockName"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "stateName": stateName,
        "districtName": districtName,
        "blockName": blockName,
        "status": status,
      };
}
