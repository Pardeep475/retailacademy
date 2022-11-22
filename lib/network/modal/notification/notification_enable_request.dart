class NotificationEnableRequest {
  bool notificationStatus;
  String userId;

  NotificationEnableRequest({required this.notificationStatus,required this.userId});

  Map<String, dynamic> toJson() => {
    "notificationStatus": notificationStatus,
    "userid": userId,
  };
}