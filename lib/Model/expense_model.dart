import 'dart:convert';

ExpenseModel expenseModelFromJson(String str) =>
    ExpenseModel.fromJson(json.decode(str));

String expenseModelToJson(ExpenseModel data) => json.encode(data.toJson());

class ExpenseModel {
  ExpenseModel({
    this.office,
    this.submissionDate,
    this.tourId,
    this.vendorName,
    this.invoiceNumber,
    this.invoiceDate,
    this.invoiceAmount,
    this.towardsCost,
    this.expenseHead,
    this.projectName,
    this.sponsorName,
    this.expenseBy,
    this.expenseApprovedBy,
    this.invoiceImage,
    this.dateOfPayment,
    this.paidBy,
    this.paymentApprovedBy,
    this.paidAmount,
    this.paymentType,
    this.paymentMode,
    this.userId,
    this.budgetHead,
  });

  String? office;
  String? submissionDate;
  String? tourId;
  String? vendorName;
  String? invoiceNumber;
  String? invoiceDate;
  String? invoiceAmount;
  String? towardsCost;
  String? expenseHead;
  String? projectName;
  String? sponsorName;
  String? expenseBy;
  String? expenseApprovedBy;
  String? invoiceImage;
  String? dateOfPayment;
  String? paidBy;
  String? paymentApprovedBy;
  String? paidAmount;
  String? paymentType;
  String? paymentMode;
  String? userId;
  String? budgetHead;

  factory ExpenseModel.fromJson(Map<String, dynamic> json) => ExpenseModel(
        office: json["office"],
        submissionDate: json["submissionDate"],
        tourId: json["tourID"],
        vendorName: json["vendorName"],
        invoiceNumber: json["invoiceNumber"],
        invoiceDate: json["invoiceDate"],
        invoiceAmount: json["invoiceAmount"],
        towardsCost: json["towardsCost"],
        expenseHead: json["expenseHead"],
        projectName: json["projectName"],
        sponsorName: json["sponsorName"],
        expenseBy: json["expenseBy"],
        expenseApprovedBy: json["expenseApprovedBy"],
        invoiceImage: json["invoiceImage"],
        dateOfPayment: json["dateOfPayment"],
        paidBy: json["paidBy"],
        paymentApprovedBy: json["paymentApprovedBy"],
        paidAmount: json["paidAmount"],
        paymentType: json["paymentType"],
        paymentMode: json["paymentMode"],
        userId: json["userId"],
        budgetHead: json["budget_head"],
      );

  Map<String, dynamic> toJson() => {
        "office": office,
        "submissionDate": submissionDate,
        "tourID": tourId,
        "vendorName": vendorName,
        "invoiceNumber": invoiceNumber,
        "invoiceDate": invoiceDate,
        "invoiceAmount": invoiceAmount,
        "towardsCost": towardsCost,
        "expenseHead": expenseHead,
        "projectName": projectName,
        "sponsorName": sponsorName,
        "expenseBy": expenseBy,
        "expenseApprovedBy": expenseApprovedBy,
        "invoiceImage": invoiceImage,
        "dateOfPayment": dateOfPayment,
        "paidBy": paidBy,
        "paymentApprovedBy": paymentApprovedBy,
        "paidAmount": paidAmount,
        "paymentType": paymentType,
        "paymentMode": paymentMode,
        "userId": userId,
        "budget_head":budgetHead,
      };
}
