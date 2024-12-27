// To parse this JSON data, do
//
//     final expenseClaim = expenseClaimFromJson(jsonString);

// List<ExpenseClaim> expenseClaimFromJson(String str) => List<ExpenseClaim>.from(
//     json.decode(str).map((x) => ExpenseClaim.fromJson(x)));

// String expenseClaimToJson(List<ExpenseClaim> data) =>
//     json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ExpenseClaim {
  const ExpenseClaim({
    this.expenseClaimId,
    this.date,
    this.uniqueId,
    this.expenseHead,
    this.amount,
    this.description,
    this.image,
    this.submittedBy,
    this.status,
    this.createdAt,
    this.approvedBy,
    this.updatedAt,
    this.office,
    this.version,
  });

  final String? expenseClaimId;
  final String? date;
  final String? uniqueId;
  final String? expenseHead;
  final String? amount;
  final String? description;
  final List<String>? image;
  final String? submittedBy;
  final String? status;
  final String? createdAt;
  final String? approvedBy;
  final String? updatedAt;
  final String? office;
  final String? version;

  // factory ExpenseClaim.fromJson(Map<String, dynamic> json) => ExpenseClaim(
  //       expenseClaimId: json["expense_claim_id"],
  //       date: json["date"],
  //       expenseHead: json["expense_head"],
  //       amount: json["amount"],
  //       description: json["description"],
  //       image: json["image"],
  //       submittedBy: json["submitted_by"],
  //       status: json["status"],
  //       createdAt: json["created_at"],
  //       approvedBy: json["approved_by"],
  //       updatedAt: json["updated_at"],
  //       office: json["office"],
  //       version: json["version"],
  //     );

  // Map<String, dynamic> toJson() => {
  //       "expense_claim_id": expenseClaimId,
  //       "date": date,
  //       "expense_head": expenseHead,
  //       "amount": amount,
  //       "description": description,
  //       "image": image,
  //       "submitted_by": submittedBy,
  //       "status": status,
  //       "created_at": createdAt,
  //       "approved_by": approvedBy,
  //       "updated_at": updatedAt,
  //       "office": office,
  //       "version": version,
  //     };
}
