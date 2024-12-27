
// To parse this JSON data, do
//
//     final programmeMaster = programmeMasterFromMap(jsonString);

import 'dart:convert';

List<ProgrammeMaster> programmeMasterFromMap(String str) =>
    List<ProgrammeMaster>.from(
        json.decode(str).map((x) => ProgrammeMaster.fromMap(x)));

String programmeMasterToMap(List<ProgrammeMaster> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toMap())));

class ProgrammeMaster {
  ProgrammeMaster({
    this.programId,
    this.program,
    this.remarks,
    this.createdAt,
    this.updateAt,
  });

  String? programId;
  String? program;
  dynamic remarks;
  DateTime? createdAt;
  dynamic updateAt;

  factory ProgrammeMaster.fromMap(Map<String, dynamic> json) => ProgrammeMaster(
        programId: json["program_id"],
        program: json["program"],
        remarks: json["remarks"],
        createdAt: DateTime.parse(json["created_at"]),
        updateAt: json["update_at"],
      );

  Map<String, dynamic> toMap() => {
        "program_id": programId,
        "program": program,
        "remarks": remarks,
        "created_at":
            "${createdAt!.year.toString().padLeft(4, '0')}-${createdAt!.month.toString().padLeft(2, '0')}-${createdAt!.day.toString().padLeft(2, '0')}",
        "update_at": updateAt,
      };
}