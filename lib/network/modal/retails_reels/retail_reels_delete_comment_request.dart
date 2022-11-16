class RetailReelsDeleteCommentRequest {
  RetailReelsDeleteCommentRequest({
    this.commentId = '',
    this.userId = '',
    this.reelId = '',
  });

  String commentId;
  String userId;
  String reelId;

  Map<String, dynamic> toJson() => {
        "commentId": commentId,
        "userid": userId,
        "reelid": reelId,
      };
}
