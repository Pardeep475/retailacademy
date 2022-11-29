class ActivityStreamViewedRequest {
  String activityStreamId;
  String userid;

  ActivityStreamViewedRequest({
    required this.activityStreamId,
    required this.userid,
  });

  Map<String, dynamic> toJson() => {
        "activityStreamId": activityStreamId,
        "userid": userid,
      };
}
/*
*
* {
   "activityStreamId": "1368",
    "userid":"16686"
}
*
* */
