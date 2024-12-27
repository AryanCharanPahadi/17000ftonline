// To parse this JSON data, do
//
//     final checkboxAttr = checkboxAttrFromMap(jsonString);

import 'dart:convert';

List<CheckboxAttr> checkboxAttrFromMap(String str) => List<CheckboxAttr>.from(
    json.decode(str).map((x) => CheckboxAttr.fromMap(x)));

String checkboxAttrToMap(List<CheckboxAttr> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toMap())));

class CheckboxAttr {
  CheckboxAttr({
    this.checkId,
    this.issueComponentId,
    this.attributeName,
    this.fieldType,
  });

  String? checkId;
  String? issueComponentId;
  String? attributeName;
  String? fieldType;

  factory CheckboxAttr.fromMap(Map<String, dynamic> json) => CheckboxAttr(
        checkId: json["check_id"],
        issueComponentId: json["issue_component_id"],
        attributeName: json["attribute_ name"],
        fieldType: json["field_type"],
      );

  Map<String, dynamic> toMap() => {
        "check_id": checkId,
        "issue_component_id": issueComponentId,
        "attribute_ name": attributeName,
        "field_type": fieldType,
      };
}
