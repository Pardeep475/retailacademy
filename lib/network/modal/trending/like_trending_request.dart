
class LikeTrendingRequest {
  LikeTrendingRequest({
    this.activityStreamId = 0,
    this.userid = "",
    this.orgId = "",
  });

  int activityStreamId;
  String userid;
  String orgId;


  Map<String, dynamic> toJson() => {
    "activityStreamId": activityStreamId,
    "userid": userid,
    "orgid": orgId,
  };
}
