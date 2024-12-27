// To parse this JSON data, do
//
//     final tourId = tourIdFromJson(jsonString);

import 'dart:convert';

List<ExpenseHead> expenseHeadFromJson(String str) => List<ExpenseHead>.from(
    json.decode(str).map((x) => ExpenseHead.fromJson(x)));

String expenseHeadToJson(List<ExpenseHead> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ExpenseHead {
  ExpenseHead({
    this.id,
    this.expenseheadname,
  });

  String? id;
  String? expenseheadname;

  factory ExpenseHead.fromJson(Map<String, dynamic> json) => ExpenseHead(
        id: json["id"],
        expenseheadname: json["expensehead_name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "expensehead_name": expenseheadname,
      };
}

// To parse this JSON data, do
//
//     final expenseClaimHead = expenseClaimHeadFromJson(jsonString);

List<ExpenseClaimHead> expenseClaimHeadFromJson(String str) =>
    List<ExpenseClaimHead>.from(
        json.decode(str).map((x) => ExpenseClaimHead.fromJson(x)));

String expenseClaimHeadToJson(List<ExpenseClaimHead> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ExpenseClaimHead {
  ExpenseClaimHead({
    this.claimId,
    this.expenseHeadName,
  });

  String? claimId;
  String? expenseHeadName;

  factory ExpenseClaimHead.fromJson(Map<String, dynamic> json) =>
      ExpenseClaimHead(
        claimId: json["claim_id"],
        expenseHeadName: json["expense_head_name"],
      );

  Map<String, dynamic> toJson() => {
        "claim_id": claimId,
        "expense_head_name": expenseHeadName,
      };
}
