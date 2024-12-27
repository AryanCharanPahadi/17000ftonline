// To parse this JSON data, do
//
//     final stateModel = stateModelFromJson(jsonString);

import 'dart:convert';

StateModel stateModelFromJson(String str) =>
    StateModel.fromJson(json.decode(str));

String stateModelToJson(StateModel data) => json.encode(data.toJson());

class StateModel {
  StateModel({
    this.status,
    this.data,
  });

  int? status;
  List<State>? data;

  factory StateModel.fromJson(Map<String, dynamic> json) => StateModel(
        status: json["status"],
        data: List<State>.from(json["data"].map((x) => State.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "data": List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class State {
  State({
    this.state,
  });

  String? state;

  factory State.fromJson(Map<String, dynamic> json) => State(
        state: json["STATE"],
      );

  Map<String, dynamic> toJson() => {
        "STATE": state,
      };
}

DistrictModel districtModelFromJson(String str) =>
    DistrictModel.fromJson(json.decode(str));

String districtModelToJson(DistrictModel data) => json.encode(data.toJson());

class DistrictModel {
  DistrictModel({
    this.status,
    this.data,
  });

  int? status;
  List<District>? data;

  factory DistrictModel.fromJson(Map<String, dynamic> json) => DistrictModel(
        status: json["status"],
        data:
            List<District>.from(json["data"].map((x) => District.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "data": List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class District {
  District({
    this.district,
  });

  String? district;

  factory District.fromJson(Map<String, dynamic> json) => District(
        district: json["DISTNAME"],
      );

  Map<String, dynamic> toJson() => {
        "DISTNAME": district,
      };
}

BlockModel blockModelFromJson(String str) =>
    BlockModel.fromJson(json.decode(str));

String blockModelToJson(BlockModel data) => json.encode(data.toJson());

class BlockModel {
  BlockModel({
    this.status,
    this.data,
  });

  int? status;
  List<Block>? data;

  factory BlockModel.fromJson(Map<String, dynamic> json) => BlockModel(
        status: json["status"],
        data: List<Block>.from(json["data"].map((x) => Block.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "data": List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class Block {
  Block({
    this.block,
  });

  String? block;

  factory Block.fromJson(Map<String, dynamic> json) => Block(
        block: json["BLOCK_NAME"],
      );

  Map<String, dynamic> toJson() => {
        "BLOCK_NAME": block,
      };
}
