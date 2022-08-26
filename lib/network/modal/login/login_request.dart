class LoginRequest {
  String type;
  String userName;
  String deviceToken;
  String platform;
  String password;

  LoginRequest.name(
      this.type, this.userName, this.deviceToken, this.platform, this.password);

// {
// "type": "employeenumber",
// "username": "15224",
// "deviceToken": "cjdfV6VG87M:APA91bFzmp297En7RrHtuJG2D7DKVwigDwqtLp1xf-7HsKccEr7UFQrSpB7W1fU4kB8-LIv-XMqdGo75_kdJ8vqmWiO9Uy5gbzJfAOdr5mktuxN9W6HNG0WUjz0yYaNecfv9_n_KOZOA",
// "platform": "android",
// "Password": "feb12345"
// }

  Map<String, dynamic> toJson() => {
    "type": type,
    "username": userName,
    "deviceToken": deviceToken,
    "platform": platform,
    "Password": password,
  };
}

