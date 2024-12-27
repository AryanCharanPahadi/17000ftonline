import 'dart:convert';

LeaveRequestModal leaveRequestModalFromJson(String str) =>
    LeaveRequestModal.fromJson(json.decode(str));

String leaveRequestModalToJson(LeaveRequestModal data) =>
    json.encode(data.toJson());

class LeaveRequestModal {
  String? leaveRequest;
  String? empId;
  String? type;
  String? numberOfLeaves;
  String? startDate;
  String? endDate;
  String? reason;
  String? compoff;
  String? document;
  String? office;

  LeaveRequestModal({
    this.leaveRequest,
    this.empId,
    this.type,
    this.numberOfLeaves,
    this.startDate,
    this.endDate,
    this.reason,
    this.compoff,
    this.document,
    required this.office,
  });

  factory LeaveRequestModal.fromJson(Map<String, dynamic> json) =>
      LeaveRequestModal(
        leaveRequest: json['leave_request'],
        empId: json['emp_id'],
        type: json['type'],
        numberOfLeaves: json['Number_of_leaves'],
        startDate: json['start_date'],
        endDate: json['end_date'],
        reason: json['reason'],
        compoff: json['compoff'],
        document: json['document'],
        office: json['office'],
      );

  Map<String, dynamic> toJson() => {
        'leave_request': leaveRequest,
        'emp_id': empId,
        'type': type,
        'Number_of_leaves': numberOfLeaves,
        'start_date': startDate,
        'end_date': endDate,
        'reason': reason,
        'compoff': compoff,
        'document': document,
        'office': office,
      };
}
