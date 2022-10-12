class RetailReelsCommentResponse {
  RetailReelsCommentResponse({
    this.reelComments,
    this.commentCount = 0,
    this.status = false,
    this.message = '',
  });

  List<ReelCommentElement>? reelComments;
  int commentCount;
  bool status;
  String message;

  factory RetailReelsCommentResponse.fromJson(Map<String, dynamic> json) =>
      RetailReelsCommentResponse(
        reelComments: json["reelcomments"] == null
            ? null
            : List<ReelCommentElement>.from(json["reelcomments"]
                .map((x) => ReelCommentElement.fromJson(x))),
        commentCount: json["commentcount"] ?? 0,
        status: json["status"] ?? false,
        message: json["message"] ?? '',
      );
}

class ReelCommentElement {
  ReelCommentElement({
    this.commentId = -1,
    this.reelId = -1,
    this.userId = -1,
    this.comment = '',
    this.userName = '',
    this.profileImage = '',
    this.commentedDate = '',
  });

  int commentId;
  int reelId;
  int userId;
  String comment;
  String userName;
  String profileImage;
  String commentedDate;

  factory ReelCommentElement.fromJson(Map<String, dynamic> json) =>
      ReelCommentElement(
        commentId: json["commentid"] ?? -1,
        reelId: json["reelid"] ?? -1,
        userId: json["userid"] ?? -1,
        comment: json["comment"] ?? '',
        userName: json["username"] ?? '',
        profileImage: json["profileimage"] ?? '',
        commentedDate: json["commenteddate"] ?? '',
      );
}
