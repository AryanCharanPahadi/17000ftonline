// To parse this JSON data, do
//
//     final newStateModel = newStateModelFromJson(jsonString);

import 'dart:convert';

List<NewStateModel> newStateModelFromJson(String str) => List<NewStateModel>.from(json.decode(str).map((x) => NewStateModel.fromJson(x)));

String newStateModelToJson(List<NewStateModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class NewStateModel {
    NewStateModel({
        this.stateId,
        this.stateName,
        this.status,
    });

    String? stateId;
    String? stateName;
    dynamic? status;

    factory NewStateModel.fromJson(Map<String, dynamic> json) => NewStateModel(
        stateId: json["stateId"],
        stateName: json["stateName"],
        status: json["status"],
    );

    Map<String, dynamic> toJson() => {
        "stateId": stateId,
        "stateName": stateName,
        "status": status,
    };
}
