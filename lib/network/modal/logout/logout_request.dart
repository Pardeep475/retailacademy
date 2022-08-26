class LogoutRequest {
  LogoutRequest({
    this.userid = '',
    this.deviceToken = '',
    this.platform = '',
  });

  String userid;
  String deviceToken;
  String platform;

  Map<String, dynamic> toJson() => {
        "userid": userid,
        "deviceToken": deviceToken,
        "platform": platform,
      };
}
