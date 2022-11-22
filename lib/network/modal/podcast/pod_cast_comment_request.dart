
class PodCastCommentRequest {
  PodCastCommentRequest({
    this.podcastId = '',
    this.podcastCommentPost = '',
    this.userId = '',
  });

  String podcastId;
  String podcastCommentPost;
  String userId;

  Map<String, dynamic> toJson() => {
    "podcastid": podcastId,
    "podcastcommentpost": podcastCommentPost,
    "userid": userId,
  };
}
