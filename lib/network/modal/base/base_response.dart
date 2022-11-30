class BaseResponse {
  BaseResponse({
    this.message = "",
    this.status = false,
  });

  String message;
  bool status;

  factory BaseResponse.fromJson(Map<String, dynamic> json) => BaseResponse(
        message: json["message"] ?? json["Message"]  ?? '',
        status: json["status"] ?? json["Status"]  ?? false,
      );
}
