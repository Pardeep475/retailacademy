class TrendingPaginationRequest {
  int userId;
  String orgId;
  int aIDAfter;

  TrendingPaginationRequest(
      {required this.userId, required this.orgId, required this.aIDAfter});

  Map<String, dynamic> toJson() => {
        "orgid": orgId,
        "userid": userId,
        "aIDAfter": aIDAfter,
      };
}
