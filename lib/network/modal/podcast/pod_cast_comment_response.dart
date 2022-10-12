class PodCastCommentResponse {
  PodCastCommentResponse({
    this.podcastComments,
    this.commentCount = 0,
    this.status = false,
    this.message = '',
  });

  List<PodcastCommentElement>? podcastComments;
  int commentCount;
  bool status;
  String message;

  factory PodCastCommentResponse.fromJson(Map<String, dynamic> json) =>
      PodCastCommentResponse(
        podcastComments: json["podcastcomments"] == null
            ? null
            : List<PodcastCommentElement>.from(json["podcastcomments"]
                .map((x) => PodcastCommentElement.fromJson(x))),
        commentCount: json["commentcount"] ?? 0,
        status: json["status"] ?? false,
        message: json["message"] ?? '',
      );
}

class PodcastCommentElement {
  PodcastCommentElement({
    this.commentId = -1,
    this.podcastId = -1,
    this.userId = -1,
    this.comment = '',
    this.userName = '',
    this.profileImage = '',
    this.commentedDate = '',
  });

  int commentId;
  int podcastId;
  int userId;
  String comment;
  String userName;
  String profileImage;
  String commentedDate;

  factory PodcastCommentElement.fromJson(Map<String, dynamic> json) =>
      PodcastCommentElement(
        commentId: json["commentid"] ?? -1,
        podcastId: json["podcastid"] ?? -1,
        userId: json["userid"] ?? -1,
        comment: json["comment"] ?? '',
        userName: json["username"] ?? '',
        profileImage: json["profileimage"] ?? '',
        commentedDate: json["commenteddate"] ?? '',
      );
}
