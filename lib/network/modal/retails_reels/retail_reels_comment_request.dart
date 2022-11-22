
class RetailReelsCommentRequest {
  RetailReelsCommentRequest({
    this.reelId = '',
    this.userId = '',
    this.commentText = '',
  });

  String reelId;
  String userId;
  String commentText;


  Map<String, dynamic> toJson() => {
    "reelid": reelId,
    "userid": userId,
    "CommentText": commentText,
  };
}
