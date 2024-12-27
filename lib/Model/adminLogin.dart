import 'dart:convert';

List<AdminLogin> adminLoginFromJson(String str) =>
    List<AdminLogin>.from(json.decode(str).map((x) => AdminLogin.fromJson(x)));

String adminLoginToJson(List<AdminLogin> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class AdminLogin {
  AdminLogin({
    this.adminId,
    this.username,
    this.password,
    this.adminEmail,
    this.role,
    this.officeId,
    this.roleName,
    this.officeName,
    this.empId,
    this.adminLevel,
    this.version,
  });

  String? adminId;
  String? username;
  String? password;
  String? adminEmail;
  String? role;
  String? officeId;
  String? roleName;
  String? officeName;
  String? empId;
  String? adminLevel;
  String? version;

  factory AdminLogin.fromJson(Map<String, dynamic> json) => AdminLogin(
        adminId: json["admin_id"],
        username: json["username"],
        password: json["password"],
        adminEmail: json["admin_email"],
        role: json["role"],
        officeId: json["office_id"],
        roleName: json["role_name"],
        officeName: json["office_name"],
        empId: json["emp_id"],
        adminLevel: json["admin_level"],
        version: json["version"],
      );

  Map<String, dynamic> toJson() => {
        "admin_id" :adminId,
        "username":username,
        "password":password,
        "admin_email":adminEmail,
        "role":role,
        "office_id":officeId,
        "role_name":roleName,
        "office_name":officeName,
        "emp_id":empId,
        "admin_level":adminLevel,
        "version":version,
      };
}
