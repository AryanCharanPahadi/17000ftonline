// To parse this JSON data, do
//
//     final expense = expenseFromJson(jsonString);

import 'dart:convert';

List<PendingExpense> expenseFromJson(String str) => List<PendingExpense>.from(
    json.decode(str).map((x) => PendingExpense.fromJson(x)));

String expenseToJson(List<PendingExpense> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class PendingExpense {
  PendingExpense(
      {this.expenseId,
      this.office,
      this.tourId,
      this.vendorName,
      this.invoiceNo,
      this.dateOfInvoice,
      this.invoiceAmt,
      this.towardsCost,
      this.expenseHead,
      this.programme,
      this.project,
      this.sponsor,
      this.expenseBy,
      this.expenseApprovedBy,
      this.image,
      this.paymentDate,
      this.paidBy,
      this.paymentApprovedBy,
      this.paidAmt,
      this.typeOfPayment,
      this.modeOfPayment,
      this.submissionDate,
      this.uid,
      this.status,
      this.approvalamt,
      this.remarks,
      this.txnid,
      this.finalamt,
      this.chequeNo,
      this.referenceNo,
      this.budgetHead});

  String? expenseId;
  String? office;
  String? tourId;
  String? vendorName;
  String? invoiceNo;
  String? dateOfInvoice;
  String? invoiceAmt;
  String? towardsCost;
  String? expenseHead;
  String? programme;
  String? project;
  String? sponsor;
  String? expenseBy;
  String? expenseApprovedBy;
  String? image;
  String? paymentDate;
  String? paidBy;
  String? paymentApprovedBy;
  String? paidAmt;
  String? typeOfPayment;
  String? modeOfPayment;
  String? submissionDate;
  String? uid;
  String? status;
  String? approvalamt;
  String? remarks;
  String? txnid;
  String? finalamt;
  String? chequeNo;
  String? referenceNo;
  String? budgetHead;

  factory PendingExpense.fromJson(Map<String, dynamic> json) => PendingExpense(
        expenseId: json["expense_id"],
        office: json["office"],
        tourId: json["tour_id"],
        vendorName: json["vendor_name"],
        invoiceNo: json["invoice_no"],
        dateOfInvoice: json["date_of_invoice"],
        invoiceAmt: json["invoice_amt"],
        towardsCost: json["towards_cost"],
        expenseHead: json["expense_head"],
        project: json["project"],
        sponsor: json["sponsor"],
        expenseBy: json["expense_by"],
        expenseApprovedBy: json["expense_approved_by"],
        image: json["image"],
        paymentDate: json["payment_date"],
        paidBy: json["paid_by"],
        paymentApprovedBy: json["payment_approved_by"],
        paidAmt: json["paid_amt"],
        typeOfPayment: json["type_of_payment"],
        modeOfPayment: json["mode_of_payment"],
        submissionDate: json["submission_date"],
        uid: json["uid"],
        status: json["status"],
        approvalamt: json["approval_amount"],
        remarks: json["remarks"],
        txnid: json["txn_id"],
        finalamt: json["final_paidamt"],
        chequeNo: json["cheque_no"],
        referenceNo: json["ref_no"],
        programme: json["program"],
        budgetHead: json["budget_head"],
      );

  Map<String, dynamic> toJson() => {
        "expense_id": expenseId,
        "office": office,
        "tour_id": tourId,
        "vendor_name": vendorName,
        "invoice_no": invoiceNo,
        "date_of_invoice": dateOfInvoice,
        "invoice_amt": invoiceAmt,
        "towards_cost": towardsCost,
        "expense_head": expenseHead,
        "project": project,
        "sponsor": sponsor,
        "expense_by": expenseBy,
        "expense_approved_by": expenseApprovedBy,
        "image": image,
        "payment_date": paymentDate,
        "paid_by": paidBy,
        "payment_approved_by": paymentApprovedBy,
        "paid_amt": paidAmt,
        "type_of_payment": typeOfPayment,
        "mode_of_payment": modeOfPayment,
        "submission_date": submissionDate,
        "uid": uid,
        "status": status,
        "approval_amount": approvalamt,
        "remarks": remarks,
        "txn_id": txnid,
        "final_paidamt": finalamt,
        "cheque_no": chequeNo,
        "ref_no": referenceNo,
        "program": programme,
        "budget_head": budgetHead,
      };
}
