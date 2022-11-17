import 'dart:convert';

LoginResponse loginResponseFromJson(String str) => LoginResponse.fromJson(json.decode(str));

String loginResponseToJson(LoginResponse data) => json.encode(data.toJson());

class LoginResponse {
  LoginResponse({
    this.message = "",
    this.status = false,
    this.userid = "",
    this.firstLogin = false,
    this.role = "",
    this.jwtToken = "",
    this.emailID = "",
    this.staffID = 0,
  });

  String message;
  bool status;
  String userid;
  bool firstLogin;
  String role;
  String jwtToken;
  String emailID;
  int staffID;

  factory LoginResponse.fromJson(Map<String, dynamic> json) => LoginResponse(
    message: json["message"] ?? '',
    status: json["status"] ?? false,
    userid: json["userid"] ?? '',
    firstLogin: json["firstlogin"] ?? false,
    role: json["role"] ?? '',
    jwtToken: json["jwtToken"] ?? '',
    emailID: json["emailID"] ?? '',
    staffID: json["staffID"] ?? '',
  );

  Map<String, dynamic> toJson() => {
    "message": message,
    "status": status,
    "userid": userid,
    "firstlogin": firstLogin,
    "role": role,
    "jwtToken": jwtToken,
    "emailID": emailID,
    "staffID": staffID,
  };
}
