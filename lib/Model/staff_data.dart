// import 'dart:convert';

// List<StaffDetails> staffDetailsFromJson(String str) => List<StaffDetails>.from(
//     json.decode(str).map((x) => StaffDetails.fromJson(x)));

// String staffDetailsToJson(List<StaffDetails> data) =>
//     json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

// class StaffDetails {
//   StaffDetails({
//     this.employeeId,
//     this.firstName,
//     this.middleName,
//     this.lastName,
//     this.dateOfBirth,
//     this.gender,
//     this.fatherName,
//     this.husbandName,
//     this.location,
//     this.maritialStatus,
//     this.bloodGroup,
//     this.aadharNo,
//     this.pan,
//     this.presentAddress,
//     this.permanentAddress,
//     this.mobileNo,
//     this.emailId,
//     this.mothersName,
//     this.spouseName,
//     this.nomineeName,
//     this.relationship,
//     this.bankAccountNo,
//     this.ifscCode,
//     this.bankName,
//     this.photograph,
//     this.panCard,
//     this.adhaarFront,
//     this.adhaarBack,
//     this.remarks,
//     this.createdAt,
//     this.updatedAt,
//   });

//   String? employeeId;
//   String? firstName;
//   String? middleName;
//   String? lastName;
//   String? dateOfBirth;
//   String? gender;
//   String? fatherName;
//   String? husbandName;
//   String? location;
//   String? maritialStatus;
//   String? bloodGroup;
//   String? aadharNo;
//   String? pan;
//   String? presentAddress;
//   String? permanentAddress;
//   String? mobileNo;
//   String? emailId;
//   String? mothersName;
//   String? spouseName;
//   String? nomineeName;
//   String? relationship;
//   String? bankAccountNo;
//   String? ifscCode;
//   String? bankName;
//   String? photograph;
//   String? panCard;
//   String? adhaarFront;
//   String? adhaarBack;
//   String? remarks;
//   String? createdAt;
//   String? updatedAt;

//   factory StaffDetails.fromJson(Map<String, dynamic> json) => StaffDetails(
//         employeeId: json["employee_id"],
//         firstName: json["first_name"],
//         middleName: json["middle_name"],
//         lastName: json["last_name"],
//         dateOfBirth: json["date_of_birth"],
//         gender: json["gender"],
//         fatherName: json["father_name"],
//         husbandName: json["husband_name"],
//         location: json["location"],
//         maritialStatus: json["maritial_status"],
//         bloodGroup: json["blood_group"],
//         aadharNo: json["aadhar_no"],
//         pan: json["pan"],
//         presentAddress: json["present_address"],
//         permanentAddress: json["permanent_address"],
//         mobileNo: json["mobile_no"],
//         emailId: json["email_id"],
//         mothersName: json["mothers_name"],
//         spouseName: json["spouse_name"],
//         nomineeName: json["nominee_name"],
//         relationship: json["relationship"],
//         bankAccountNo: json["bank_account_no"],
//         ifscCode: json["ifsc_code"],
//         bankName: json["bank_name"],
//         photograph: json["photograph"],
//         panCard: json["pan_card"],
//         adhaarFront: json["adhaar_front"],
//         adhaarBack: json["adhaar_back"],
//         remarks: json["remarks"],
//         createdAt: json["created_at"],
//         updatedAt: json["updated_at"],
//       );

//   Map<String, dynamic> toJson() => {
//         "employee_id": employeeId,
//         "first_name": firstName,
//         "middle_name": middleName,
//         "last_name": lastName,
//         "date_of_birth": dateOfBirth,
//         "gender": gender,
//         "father_name": fatherName,
//         "husband_name": husbandName,
//         "location": location,
//         "maritial_status": maritialStatus,
//         "blood_group": bloodGroup,
//         "aadhar_no": aadharNo,
//         "pan": pan,
//         "present_address": presentAddress,
//         "permanent_address": permanentAddress,
//         "mobile_no": mobileNo,
//         "email_id": emailId,
//         "mothers_name": mothersName,
//         "spouse_name": spouseName,
//         "nominee_name": nomineeName,
//         "relationship": relationship,
//         "bank_account_no": bankAccountNo,
//         "ifsc_code": ifscCode,
//         "bank_name": bankName,
//         "photograph": photograph,
//         "pan_card": panCard,
//         "adhaar_front": adhaarFront,
//         "adhaar_back": adhaarBack,
//         "remarks": remarks,
//         "created_at": createdAt,
//         "updated_at": updatedAt,
//       };
// }

// To parse this JSON data, do
//
//     final staff = staffFromJson(jsonString);

import 'dart:convert';

Staff staffFromJson(String str) => Staff.fromJson(json.decode(str));

String staffToJson(Staff data) => json.encode(data.toJson());

class Staff {
  Staff({
    this.status,
    this.data,
  });

  int? status;
  List<Datum>? data;

  factory Staff.fromJson(Map<String, dynamic> json) => Staff(
        status: json["status"],
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "data": List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class Datum {
  Datum(
      {this.employeeId,
      this.firstName,
      this.middleName,
      this.lastName,
      this.dateOfBirth,
      this.gender,
      this.fatherName,
      this.husbandName,
      this.location,
      this.maritialStatus,
      this.bloodGroup,
      this.aadharNo,
      this.pan,
      this.presentAddress,
      this.permanentAddress,
      this.mobileNo,
      this.emailId,
      this.mothersName,
      this.spouseName,
      this.nomineeName,
      this.relationship,
      this.bankAccountNo,
      this.ifscCode,
      this.bankName,
      this.photograph,
      this.panCard,
      this.adhaarFront,
      this.adhaarBack,
      this.remarks,
      this.createdAt,
      this.updatedAt,
      this.role_Id});

  String? employeeId;
  String? firstName;
  String? middleName;
  String? lastName;
  String? dateOfBirth;
  String? gender;
  String? fatherName;
  String? husbandName;
  String? location;
  String? maritialStatus;
  String? bloodGroup;
  String? aadharNo;
  String? pan;
  String? presentAddress;
  String? permanentAddress;
  String? mobileNo;
  String? emailId;
  String? mothersName;
  String? spouseName;
  String? nomineeName;
  String? relationship;
  String? bankAccountNo;
  String? ifscCode;
  String? bankName;
  String? photograph;
  String? panCard;
  String? adhaarFront;
  String? adhaarBack;
  String? remarks;
  String? createdAt;
  String? updatedAt;
  String? role_Id;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        employeeId: json["employee_id"],
        firstName: json["first_name"],
        middleName: json["middle_name"],
        lastName: json["last_name"],
        dateOfBirth: json["date_of_birth"],
        gender: json["gender"],
        fatherName: json["father_name"],
        husbandName: json["husband_name"],
        location: json["location"],
        maritialStatus: json["maritial_status"],
        bloodGroup: json["blood_group"],
        aadharNo: json["aadhar_no"],
        pan: json["pan"],
        presentAddress: json["present_address"],
        permanentAddress: json["permanent_address"],
        mobileNo: json["mobile_no"],
        emailId: json["email_id"],
        mothersName: json["mothers_name"],
        spouseName: json["spouse_name"],
        nomineeName: json["nominee_name"],
        relationship: json["relationship"],
        bankAccountNo: json["bank_account_no"],
        ifscCode: json["ifsc_code"],
        bankName: json["bank_name"],
        photograph: json["photograph"],
        panCard: json["pan_card"],
        adhaarFront: json["adhaar_front"],
        adhaarBack: json["adhaar_back"],
        remarks: json["remarks"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
        role_Id: json["role_id"],
      );

  Map<String, dynamic> toJson() => {
        "employee_id": employeeId,
        "first_name": firstName,
        "middle_name": middleName,
        "last_name": lastName,
        "date_of_birth": dateOfBirth,
        "gender": gender,
        "father_name": fatherName,
        "husband_name": husbandName,
        "location": location,
        "maritial_status": maritialStatus,
        "blood_group": bloodGroup,
        "aadhar_no": aadharNo,
        "pan": pan,
        "present_address": presentAddress,
        "permanent_address": permanentAddress,
        "mobile_no": mobileNo,
        "email_id": emailId,
        "mothers_name": mothersName,
        "spouse_name": spouseName,
        "nominee_name": nomineeName,
        "relationship": relationship,
        "bank_account_no": bankAccountNo,
        "ifsc_code": ifscCode,
        "bank_name": bankName,
        "photograph": photograph,
        "pan_card": panCard,
        "adhaar_front": adhaarFront,
        "adhaar_back": adhaarBack,
        "remarks": remarks,
        "created_at": createdAt,
        "updated_at": updatedAt,
        "role_id": role_Id,
      };
}

List<Authority> authorityFromJson(String str) =>
    List<Authority>.from(json.decode(str).map((x) => Authority.fromJson(x)));

String authorityToJson(List<Authority> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Authority {
  Authority({
    this.authorityId,
    this.name,
    this.role,
    this.location,
    this.empId,
  });

  String? authorityId;
  String? name;
  String? role;
  String? location;
  String? empId;

  factory Authority.fromJson(Map<String, dynamic> json) => Authority(
        authorityId: json["authority_id"],
        name: json["name"],
        role: json["role"],
        location: json["location"],
        empId: json["emp_id"],
      );

  Map<String, dynamic> toJson() => {
        "authority_id": authorityId,
        "name": name,
        "role": role,
        "location": location,
        "emp_id": empId,
      };
}

// To parse this JSON data, do
//
//     final allStaff = allStaffFromJson(jsonString);

// List<AllStaff> allStaffFromJson(String str) =>
//     List<AllStaff>.from(json.decode(str));

// String allStaffToJson(AllStaff data) => json.encode(data.toJson());

List<AllStaff> allStaffFromJson(String str) =>
    List<AllStaff>.from(json.decode(str).map((x) => AllStaff.fromJson(x)));

String allStaffToJson(List<AllStaff> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class AllStaff {
  AllStaff({
    this.employeeId,
    this.firstName,
    this.middleName,
    this.lastName,
    this.dateOfBirth,
    this.gender,
    this.fatherName,
    this.husbandName,
    this.location,
    this.maritialStatus,
    this.bloodGroup,
    this.aadharNo,
    this.pan,
    this.presentAddress,
    this.permanentAddress,
    this.mobileNo,
    this.emailId,
    this.mothersName,
    this.spouseName,
    this.nomineeName,
    this.relationship,
    this.bankAccountNo,
    this.ifscCode,
    this.bankName,
    this.photograph,
    this.panCard,
    this.adhaarFront,
    this.adhaarBack,
    this.remarks,
    this.createdAt,
    this.updatedAt,
    this.roleId,
    this.status,
    this.personalEmail,
  });

  String? employeeId;
  String? firstName;
  String? middleName;
  String? lastName;
  String? dateOfBirth;
  String? gender;
  String? fatherName;
  String? husbandName;
  String? location;
  String? maritialStatus;
  String? bloodGroup;
  String? aadharNo;
  String? pan;
  String? presentAddress;
  String? permanentAddress;
  String? mobileNo;
  String? emailId;
  String? mothersName;
  String? spouseName;
  String? nomineeName;
  String? relationship;
  String? bankAccountNo;
  String? ifscCode;
  String? bankName;
  String? photograph;
  String? panCard;
  String? adhaarFront;
  String? adhaarBack;
  String? remarks;
  String? createdAt;
  String? updatedAt;
  String? roleId;
  String? status;
  String? personalEmail;

  factory AllStaff.fromJson(Map<String, dynamic> json) => AllStaff(
        employeeId: json["employee_id"],
        firstName: json["first_name"],
        middleName: json["middle_name"],
        lastName: json["last_name"],
        dateOfBirth: json["date_of_birth"],
        gender: json["gender"],
        fatherName: json["father_name"],
        husbandName: json["husband_name"],
        location: json["location"],
        maritialStatus: json["maritial_status"],
        bloodGroup: json["blood_group"],
        aadharNo: json["aadhar_no"],
        pan: json["pan"],
        presentAddress: json["present_address"],
        permanentAddress: json["permanent_address"],
        mobileNo: json["mobile_no"],
        emailId: json["email_id"],
        mothersName: json["mothers_name"],
        spouseName: json["spouse_name"],
        nomineeName: json["nominee_name"],
        relationship: json["relationship"],
        bankAccountNo: json["bank_account_no"],
        ifscCode: json["ifsc_code"],
        bankName: json["bank_name"],
        photograph: json["photograph"],
        panCard: json["pan_card"],
        adhaarFront: json["adhaar_front"],
        adhaarBack: json["adhaar_back"],
        remarks: json["remarks"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
        roleId: json["role_id"],
        status: json["status"],
        personalEmail: json["personal_email"],
      );

  Map<String, dynamic> toJson() => {
        "employee_id": employeeId,
        "first_name": firstName,
        "middle_name": middleName,
        "last_name": lastName,
        "date_of_birth": dateOfBirth,
        "gender": gender,
        "father_name": fatherName,
        "husband_name": husbandName,
        "location": location,
        "maritial_status": maritialStatus,
        "blood_group": bloodGroup,
        "aadhar_no": aadharNo,
        "pan": pan,
        "present_address": presentAddress,
        "permanent_address": permanentAddress,
        "mobile_no": mobileNo,
        "email_id": emailId,
        "mothers_name": mothersName,
        "spouse_name": spouseName,
        "nominee_name": nomineeName,
        "relationship": relationship,
        "bank_account_no": bankAccountNo,
        "ifsc_code": ifscCode,
        "bank_name": bankName,
        "photograph": photograph,
        "pan_card": panCard,
        "adhaar_front": adhaarFront,
        "adhaar_back": adhaarBack,
        "remarks": remarks,
        "created_at": createdAt,
        "updated_at": updatedAt,
        "role_id": roleId,
        "status": status,
        "personal_email": personalEmail,
      };
}
