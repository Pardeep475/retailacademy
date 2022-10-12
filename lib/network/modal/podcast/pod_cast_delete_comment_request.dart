class PodCastDeleteCommentRequest {
  PodCastDeleteCommentRequest({
    this.commentId = "",
    this.userId = "",
    this.podcastId = "",
  });

  String commentId;
  String userId;
  String podcastId;

  Map<String, dynamic> toJson() => {
        "commentId": commentId,
        "userId": userId,
        "podcastid": podcastId,
      };
}
