class NotificationListRequest {
  String userId;
  String orgId;
  String idAfter;
  String dateAfter;

  NotificationListRequest(
      {required this.orgId,
      required this.userId,
      this.idAfter = "",
      this.dateAfter = ""});

  // {
  // "userid":"853",
  // "Orgid":"8fb378da-e94b-4b94-b547-22723a1b8cbf",
  // "idafter":"",
  // "dateafter":""
  // }

  Map<String, dynamic> toJson() => {
        "userid": userId,
        "Orgid": orgId,
        "idafter": idAfter,
        "dateafter": dateAfter,
      };
}
