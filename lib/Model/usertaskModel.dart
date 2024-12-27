// To parse this JSON data, do
//
//     final taskId = taskIdFromJson(jsonString);

import 'dart:convert';

List<TaskId> taskIdFromJson(String str) =>
    List<TaskId>.from(json.decode(str).map((x) => TaskId.fromJson(x)));

String taskIdToJson(List<TaskId> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class TaskId {
  TaskId(
      {
      //   this.empTaskId,
      // this.empId,
      // this.taskId,
      // this.tempTaskId,
      this.formName});

  // String? empTaskId;
  // String? empId;
  // String? taskId;
  // String? tempTaskId;
  String? formName;

  factory TaskId.fromJson(Map<String, dynamic> json) => TaskId(
        // empTaskId: json["emp_task_id"],
        // empId: json["emp_id"],
        // taskId: json["task_id"],
        // tempTaskId: json["temp_task_id"],
        formName: json["form_name"],
      );

  Map<String, dynamic> toJson() => {
        // "emp_task_id": empTaskId,
        // "emp_id": empId,
        // "task_id": taskId,
        // "temp_task_id": tempTaskId,
        "form_name": formName,
      };
}
