
class RetailReelsLikeRequest {
  RetailReelsLikeRequest({
    this.reelId  = '',
    this.userId = '',
  });

  String reelId;
  String userId;

  Map<String, dynamic> toJson() => {
    "reelid": reelId,
    "userid": userId,
  };
}
