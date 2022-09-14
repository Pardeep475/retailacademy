// {
// "employeenumber": "15224",
// "userfullname": "Nagaraju Akurathi",
// "firstname": "Nagaraju",
// "lastname": "Akurathi",
// "avatarurl": "https://demo1kentico8.raybiztech.com/CMSModules/Avatars/CMSPages/GetAvatar.aspx?maxsidesize=1000&avatarguid=9f84186a-8dfd-4e85-a40b-ccf309868911",
// "status": true,
// "emailid": "nagaraju@gmail.com",
// "mobilenumber": "",
// "landnumber": "1234567890",
// "message": null
// }

class ProfileResponse {
  ProfileResponse({
    this.status = false,
    this.employeeNumber = '',
    this.userFullName = '',
    this.profilePic = '',
    this.emailId = '',
    this.mobileNumber = '',
    this.landNumber = '',
    this.message = '',
  });

  bool status;
  String employeeNumber;
  String userFullName;
  String profilePic;
  String emailId;
  String mobileNumber;
  String landNumber;
  String message;

  factory ProfileResponse.fromJson(Map<String, dynamic> json) => ProfileResponse(
    status: json["status"] ?? false,
    employeeNumber: json["employeenumber"] ?? '',
    userFullName: json["userfullname"] ?? '',
    profilePic: json["avatarurl"] ?? '',
    emailId: json["emailid"] ?? '',
    mobileNumber: json["mobilenumber"] ?? '',
    landNumber: json["landnumber"] ?? '',
    message: json["message"] ?? '',
  );

}