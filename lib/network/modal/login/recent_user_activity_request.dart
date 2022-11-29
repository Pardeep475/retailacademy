class RecentUserActivityRequest {
  String userId;
  String brandGuid;
  String startDate;
  String endDate;

  RecentUserActivityRequest({
    required this.userId,
    this.brandGuid = '',
    required this.startDate,
    required this.endDate,
  });

  Map<String, dynamic> toJson() => {
        "userId": userId,
        "brandGuid": brandGuid,
        "startDate": startDate,
        "endDate": endDate,
      };
}
