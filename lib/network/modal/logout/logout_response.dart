
class LogoutResponse {
  LogoutResponse({
    this.status = false,
    this.message = '',
  });

  bool status;
  String message;

  factory LogoutResponse.fromJson(Map<String, dynamic> json) => LogoutResponse(
        status: json["status"] ?? false,
        message: json["message"] ?? '',
      );

}
