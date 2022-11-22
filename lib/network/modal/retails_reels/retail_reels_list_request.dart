class RetailReelsListRequest {
  RetailReelsListRequest({
    this.categoryId = '',
    this.userId = '',
    this.reelId = -1,
  });

  String categoryId;
  String userId;
  int reelId;


  Map<String, dynamic> toJson() => {
    "categoryid": categoryId,
    "userid": userId,
    if(reelId != -1) "reelid": reelId,
  };
}