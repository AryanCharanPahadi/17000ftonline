import 'dart:convert';

List<IssueComponent> issueComponentFromMap(String str) =>
    List<IssueComponent>.from(
        json.decode(str).map((x) => IssueComponent.fromMap(x)));

String issueComponentToMap(List<IssueComponent> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toMap())));

class IssueComponent {
  IssueComponent({
    this.componentId,
    this.componentName,
    this.nameOfIssue,
  });

  String? componentId;
  String? componentName;
  String? nameOfIssue;

  factory IssueComponent.fromMap(Map<String, dynamic> json) => IssueComponent(
        componentId: json["component_id"],
        componentName: json["component_name"],
        nameOfIssue: json["name_of_issue"],
      );

  Map<String, dynamic> toMap() => {
        "component_id": componentId,
        "component_name": componentName,
        "name_of_issue": nameOfIssue,
      };
}

List<IssueTypeComponent> issueTypeComponentFromMap(String str) =>
    List<IssueTypeComponent>.from(
        json.decode(str).map((x) => IssueTypeComponent.fromMap(x)));

String issueTypeComponentToMap(List<IssueTypeComponent> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toMap())));

class IssueTypeComponent {
  IssueTypeComponent(
      {this.id, this.componentId, this.issueComponentName, this.fieldType});

  String? id;
  String? componentId;
  String? issueComponentName;
  String? fieldType;

  factory IssueTypeComponent.fromMap(Map<String, dynamic> json) =>
      IssueTypeComponent(
        id: json["id"],
        componentId: json["component_id"],
        issueComponentName: json["issue_component_name"],
        fieldType: json["field_type"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "component_id": componentId,
        "issue_component_name": issueComponentName,
        "field_type": fieldType,
      };
}

// To parse this JSON data, do
//
//     final cgiappZones = cgiappZonesFromMap(jsonString);

List<CgiappZones> cgiappZonesFromMap(String str) =>
    List<CgiappZones>.from(json.decode(str).map((x) => CgiappZones.fromMap(x)));

String cgiappZonesToMap(List<CgiappZones> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toMap())));

class CgiappZones {
  CgiappZones({
    this.zoneId,
    this.componentId,
    this.issueTypeComponentId,
    this.zoneName,
  });

  String? zoneId;
  String? componentId;
  String? issueTypeComponentId;
  String? zoneName;

  factory CgiappZones.fromMap(Map<String, dynamic> json) => CgiappZones(
        zoneId: json["zone_id"],
        componentId: json["component_id"],
        issueTypeComponentId: json["issue_type_component_id"],
        zoneName: json["zone_name"],
      );

  Map<String, dynamic> toMap() => {
        "zone_id": zoneId,
        "component_id": componentId,
        "issue_type_component_id": issueTypeComponentId,
        "zone_name": zoneName,
      };
}

// To parse this JSON data, do
//
//     final zoneGrade = zoneGradeFromMap(jsonString);

List<ZoneGrade> zoneGradeFromMap(String str) =>
    List<ZoneGrade>.from(json.decode(str).map((x) => ZoneGrade.fromMap(x)));

String zoneGradeToMap(List<ZoneGrade> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toMap())));

class ZoneGrade {
  ZoneGrade({
    this.gradeId,
    this.zoneId,
    this.gradeName,
  });

  String? gradeId;
  String? zoneId;
  String? gradeName;

  factory ZoneGrade.fromMap(Map<String, dynamic> json) => ZoneGrade(
        gradeId: json["grade_id"],
        zoneId: json["zone_id"],
        gradeName: json["grade_name"],
      );

  Map<String, dynamic> toMap() => {
        "grade_id": gradeId,
        "zone_id": zoneId,
        "grade_name": gradeName,
      };
}

// To parse this JSON data, do
//
//     final gradeComponents = gradeComponentsFromMap(jsonString);

List<GradeComponents> gradeComponentsFromMap(String str) =>
    List<GradeComponents>.from(
        json.decode(str).map((x) => GradeComponents.fromMap(x)));

String gradeComponentsToMap(List<GradeComponents> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toMap())));

class GradeComponents {
  GradeComponents({
    this.gradeCompId,
    this.gradeId,
    this.gradeComponentName,
    this.fieldtype,
    this.options,
  });

  String? gradeCompId;
  String? gradeId;
  String? gradeComponentName;
  String? fieldtype;
  String? options;

  factory GradeComponents.fromMap(Map<String, dynamic> json) => GradeComponents(
        gradeCompId: json["grade_comp_id"],
        gradeId: json["grade_id"],
        gradeComponentName: json["grade_component_name"],
        fieldtype: json["fieldtype"],
        options: json["options"],
      );

  Map<String, dynamic> toMap() => {
        "grade_comp_id": gradeCompId,
        "grade_id": gradeId,
        "grade_component_name": gradeComponentName,
        "fieldtype": fieldtype,
        "options": options,
      };
}
