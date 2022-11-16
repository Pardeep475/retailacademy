class TrendingCommentResponse {
  TrendingCommentResponse({
    this.commentElementList,
    this.commentCount = 0,
    this.message = '',
    this.status = false,
  });

  List<CommentElement>? commentElementList;
  int commentCount;
  String message;
  bool status;

  factory TrendingCommentResponse.fromJson(Map<String, dynamic> json) =>
      TrendingCommentResponse(
        commentElementList: json["asCommentList"] == null
            ? null
            : List<CommentElement>.from(
                json["asCommentList"].map((x) => CommentElement.fromJson(x))),
        commentCount: json["commentcount"] ?? 0,
        message: json["message"] ?? '',
        status: json["status"] ?? false,
      );
}

class CommentElement {
  CommentElement({
    this.commentId = 0,
    this.activityStreamId = 0,
    this.userId = 0,
    this.comment = '',
    this.userName = '',
    this.profileImage = '',
    this.commentImage = '',
    this.commentedDate = '',
  });

  int commentId;
  int activityStreamId;
  int userId;
  String comment;
  String userName;
  String profileImage;
  String commentImage;
  String commentedDate;

  factory CommentElement.fromJson(Map<String, dynamic> json) => CommentElement(
        commentId: json["commentID"] ?? 0,
        activityStreamId: json["activityStreamId"] ?? 0,
        userId: json["userId"] ?? 0,
        comment: json["comment"] ?? '',
        userName: json["userName"] ?? '',
        profileImage: json["profileImage"] ?? '',
        commentImage: json["CommentImage"] ?? '',
        commentedDate: json["commentedDate"] ?? '',
      );
}
