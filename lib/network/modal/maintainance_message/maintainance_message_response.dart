class MaintenanceMessageResponse {
  MaintenanceMessageResponse({
    this.maintenanceMessage,
    this.navigation = true,
    this.message = '',
    this.status = false,
  });

  MaintenanceMessage? maintenanceMessage;
  bool navigation;
  String message;
  bool status;

  factory MaintenanceMessageResponse.fromJson(Map<String, dynamic> json) =>
      MaintenanceMessageResponse(
        maintenanceMessage: json["maintenanceMessage"] == null
            ? null
            : MaintenanceMessage.fromJson(json["maintenanceMessage"]),
        navigation: json["navigation"] ?? true,
        message: json["message"] ?? '',
        status: json["status"] ?? false,
      );
}

class MaintenanceMessage {
  MaintenanceMessage({
    this.message = '',
    this.startDate = '',
    this.endDate = '',
  });

  String message;
  String startDate;
  String endDate;

  factory MaintenanceMessage.fromJson(Map<String, dynamic> json) =>
      MaintenanceMessage(
        message: json["message"] ?? '',
        startDate: json["startDate"] ?? '',
        endDate: json["endDate"] ?? '',
      );
}
