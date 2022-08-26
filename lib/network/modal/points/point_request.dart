class PointRequest {
  PointRequest({
    this.userid = '',
    this.orgId = '',
  });

  String userid;
  String orgId;

  Map<String, dynamic> toJson() => {
    "userid": userid,
    "orgid": orgId,
  };
}